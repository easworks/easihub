import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { htmlSafe } from '@ember/template';
import { on } from '@ember/modifier';
import { eq, gt, not } from 'truth-helpers';
import { fn, and } from '@ember/helper';

export default class JobCardComponent extends Component {
  @service router;
  @tracked jobs = [];
  @tracked selectedJob = null;
  @tracked isLoading = false;
  @tracked isLoadingMore = false;
  @tracked isLoadingDetails = false;
  @tracked error = null;
  @tracked totalRecords = 0;

  @tracked pageSize = 10;
  @tracked currentPage = 1;

  constructor() {
    super(...arguments);
    this.fetchJobCount();
    this.fetchJobs();
  }

  getCategoryDetails() {
    if (!this.args.category) {
      return {
        domain_name: null,
        software_name: null
      };
    }

    if (this.args.category.parentCategory) {
      return {
        domain_name: this.args.category.parentCategory.name,
        software_name: this.args.category.name
      };
    }

    return {
      domain_name: this.args.category.name,
      software_name: this.args.category.name
    };
  }

  get totalPages() {
    return Math.ceil(this.totalRecords / this.pageSize);
  }

  get startIndex() {
    return (this.currentPage - 1) * this.pageSize;
  }

  get endIndex() {
    return this.startIndex + this.pageSize;
  }

  get currentJobs() {
    return this.jobs;
  }

  get pageNumbers() {
    const pages = [];
    const maxVisible = 5;
    
    if (this.totalPages <= maxVisible) {
      for (let i = 1; i <= this.totalPages; i++) {
        pages.push(i);
      }
    } else {
      if (this.currentPage <= 3) {
        for (let i = 1; i <= 4; i++) pages.push(i);
        pages.push('...');
        pages.push(this.totalPages);
      } else if (this.currentPage >= this.totalPages - 2) {
        pages.push(1);
        pages.push('...');
        for (let i = this.totalPages - 3; i <= this.totalPages; i++) {
          pages.push(i);
        }
      } else {
        pages.push(1);
        pages.push('...');
        for (let i = this.currentPage - 1; i <= this.currentPage + 1; i++) {
          pages.push(i);
        }
        pages.push('...');
        pages.push(this.totalPages);
      }
    }
    
    return pages;
  }




  @action
  async fetchJobCount() {
    const { domain_name, software_name } = this.getCategoryDetails();
    const data = {
      domain_name,
      software_name,
      topic_type: 'jobs'
    };

    try {
      const response = await fetch('https://community.easihub.com/erp_db/api/erp-collections/jobs/count', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      });
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      const result = await response.json();
      this.totalRecords = result || 0;
    } catch (error) {
      console.error('Error fetching job count:', error);
      this.totalRecords = 0;
    }
  }

  @action
  async fetchJobs(reset = true) {
    if (reset) {
      this.jobs = [];
      this.isLoading = true;
      this.currentPage = 1;
      await this.fetchJobCount();
    } else {
      this.isLoadingMore = true;
    }

    try {
      const { domain_name, software_name } = this.getCategoryDetails();
      const data = {
        domain_name,
        software_name,
        topic_type: 'jobs',
        page_num: this.currentPage,
        page_size: this.pageSize
      };
      
      const response = await fetch('https://community.easihub.com/erp_db/api/erp-collections/jobs', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      });
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      const result = await response.json();
      const newJobs = Array.isArray(result) ? result : (result?.data || []);
      
      this.jobs = newJobs;
      if (newJobs.length > 0 && !this.selectedJob) {
        this.selectedJob = newJobs[0];
      }
    } catch (error) {
      this.error = error?.message || 'Failed to load jobs';
    } finally {
      this.isLoading = false;
      this.isLoadingMore = false;
    }
  }

  @action
  async fetchJobDetails(jobId) {
    this.isLoadingDetails = true;
    try {
      const response = await fetch('https://community.easihub.com/erp_db/api/erp-collections/jobs/details', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ job_id: jobId })
      });
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      this.selectedJob = await response.json();
    } catch (error) {
      console.error('Error fetching job details:', error);
    } finally {
      this.isLoadingDetails = false;
    }
  }

  @action
  async goToPage(page) {
    if (typeof page === 'number' && page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
      await this.fetchJobs(false);
    }
  }

  @action
  async nextPage() {
    if (this.currentPage < this.totalPages) {
      this.currentPage++;
      await this.fetchJobs(false);
    }
  }
  
  @action
  async previousPage() {
    if (this.currentPage > 1) {
      this.currentPage--;
      await this.fetchJobs(false);
    }
  }



  @action
  selectJob(jobId) {
    const job = this.jobs.find(j => j._id === jobId);
    if (job) {
      this.selectedJob = job;
      document.querySelectorAll('.job-card').forEach(card => card.classList.remove('active'));
      document.querySelector(`[data-job-id="${jobId}"]`)?.classList.add('active');
    }
  }

  @action
  closeJobDetails() {
    this.selectedJob = null;
  }

  @action
  async shareJob(event, job) {
    event.stopPropagation();
    
    const shareData = {
      title: `${job.job_title} at ${job.company_name}`,
      text: `Check out this job opportunity: ${job.job_title} at ${job.company_name} in ${job.job_location}`,
      url: job.apply_url || window.location.href
    };

    try {
      if (navigator.share) {
        await navigator.share(shareData);
      } else {
        await navigator.clipboard.writeText(`${shareData.title}\n${shareData.text}\n${shareData.url}`);
        alert('Job details copied to clipboard!');
      }
    } catch (error) {
      console.error('Error sharing:', error);
    }
  }

  templateJob(job, isActive = false) {
    const { _id, job_title, company_name, job_location, employment_type, work_location_type, seniority_level, required_skills, tech_skills, industry, posted_date } = job;
    
    const requiredSkills = required_skills?.split(',').slice(0, 3).map(x => `<span class="skill-badge">${x.trim()}</span>`).join('') || '';
    const techSkills = tech_skills?.split(',').slice(0, 3).map(x => `<span class="tech-badge">${x.trim()}</span>`).join('') || '';
    const industries = industry?.split(',').slice(0, 3).map(x => `<span class="industry-badge">${x.trim()}</span>`).join('') || '';
    
    return `
      <div class="job-card ${isActive ? 'active' : ''}" data-job-id="${_id}">
        <div class="job-header">
          <div class="job-meta">
            <h3 class="job-title">${job_title}</h3>
            <div class="company-info">
              <div class="company-name">${company_name}</div>
              <span class="text-gray-400 mx-2">|</span>
              <div class="job-location">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/>
                </svg>
                ${job_location}
              </div>
            </div>
          </div>
        </div>
        
        <div class="job-badges">
          <span class="employment-badge">${employment_type}</span>
          <span class="location-badge">${work_location_type}</span>
          <span class="level-badge">${seniority_level}</span>
        </div>
        
        <div class="skill-tags">
          ${requiredSkills}
          ${techSkills}
          ${industries}
        </div>
        
        <div class="job-footer">
          <div class="posted-date">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
              <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
            </svg>
            ${posted_date || 'Recently posted'}
          </div>
          <div class="apply-wrap">  
            <button class="share-button" title="Share this job" data-job-id="${_id}">
              <i class="fas fa-share-alt"></i>
            </button>
            <a href="${job.apply_url || '#'}" target="_blank" class="quick-apply-btn" onclick="event.stopPropagation()">
              Apply
            </a>
          </div>
        </div>
      </div>
    `;
  }

  templateJobDetails(job) {
    if (!job) return '<div class="no-selection">Select a job to view details</div>';
    
    const { job_title, company_name, comp_desc, job_location, employment_type, salary_range, work_location_type, posted_date, benefits, qualifications, tech_skills, required_skills, full_job_description, apply_button_label, apply_url, industry } = job;
    
    const benefitsList = benefits?.split(',').map(x => `<span class="benefit-tag">${x.trim()}</span>`).join('') || '';
    const techSkillsList = tech_skills?.split(',').map(x => `<span class="tech-tag">${x.trim()}</span>`).join('') || '';
    const reqSkills = required_skills?.split(',').map(x => `<span class="skill-tag">${x.trim()}</span>`).join('') || '';
    const industries = industry?.split(',').map(x => `<span class="industry-tag">${x.trim()}</span>`).join('') || '';
    const qualificationsList = qualifications?.split(',').map(x => `<div class="qualification-item">${x.trim()}</div>`).join('') || '';
    
    return `
      <div class="job-preview-content">
        <div class="preview-header">
          <div class="preview-header-content">
            <div class="preview-header-info">
              <h2 class="preview-title">${job_title}</h2>
              <div class="preview-company-info">
                <div class="preview-company">${company_name}</div>
                <span class="text-gray-400">|</span>
                <div class="preview-location">${job_location}</div>
              </div>
              <div class="preview-badges">
                <span class="preview-badge">${employment_type}</span>
                <span class="preview-badge">${work_location_type}</span>
                <span class="preview-badge">${salary_range || 'Salary not disclosed'}</span>
              </div>
            </div>
            <div class="preview-header-actions">
              <button class="share-btn" title="Share this job">
                <i class="fas fa-share-alt"></i>
              </button>
              <a href="${apply_url}" target="_blank" class="apply-button">
                ${apply_button_label || 'Apply Now'}
              </a>
            </div>
          </div>
        </div>
        
        <div class="preview-body">
          ${comp_desc ? `<div class="preview-section"><h3 class="preview-title">Company Description</h3><p>${comp_desc}</p></div>` : ''}
          
          ${full_job_description ? `<div class="preview-section"><h3 class="preview-title">Job Description</h3><div class="job-desc">${full_job_description}</div></div>` : ''}
          
          ${reqSkills ? `<div class="preview-section"><h3>Required Skills</h3><div class="tags-container">${reqSkills}</div></div>` : ''}
          
          ${techSkillsList ? `<div class="preview-section"><h3 class="preview-title">Tech Stack</h3><div class="tags-container">${techSkillsList}</div></div>` : ''}
          
          ${qualificationsList ? `<div class="preview-section"><h3 class="preview-title">Qualifications</h3><div class="qualifications-list">${qualificationsList}</div></div>` : ''}
          
          ${benefitsList ? `<div class="preview-section"><h3 class="preview-title">Benefits</h3><div class="tags-container">${benefitsList}</div></div>` : ''}
          
          ${industries ? `<div class="preview-section"><h3 class="preview-title">Industry</h3><div class="tags-container">${industries}</div></div>` : ''}
        </div>
      </div>
    `;
  }

  get renderedJobs() {
    const jobsToRender = this.currentJobs;
    if (!jobsToRender?.length) {
      return htmlSafe('<div class="no-jobs">No jobs available</div>');
    }
    const html = jobsToRender.map((job, index) => {
      const isActive = this.selectedJob?._id === job._id;
      return this.templateJob(job, isActive);
    }).join('');
    
    const loadingIndicator = this.isLoadingMore ? '<div class="loading animate-pulse text-center py-4">Loading more jobs...</div>' : '';
    
    return htmlSafe(`<div class="jobs-list mt-2">${html}${loadingIndicator}</div>`);
  }

  @action
  handleJobClick(event) {
    // Handle share button clicks
    const shareButton = event.target.closest('.share-button');
    if (shareButton) {
      const jobId = shareButton.dataset.jobId;
      const job = this.jobs.find(j => j._id === jobId);
      if (job) {
        this.shareJob(event, job);
      }
      return;
    }

    // Handle job card clicks
    const jobCard = event.target.closest('.job-card');
    if (jobCard) {
      const jobId = jobCard.dataset.jobId;
      this.selectJob(jobId);
    }
  }

  @action
  handleShareClick(event) {
    const shareBtn = event.target.closest('.share-btn');
    if (shareBtn && this.selectedJob) {
      this.shareJob(event, this.selectedJob);
    }
  }

  get renderedJobDetails() {
    return htmlSafe(this.templateJobDetails(this.selectedJob));
  }

  <template>
    <div class="job-layout">
      <div class="jobs-sidebar" {{on "click" this.handleJobClick}}>
        <div class="jobs-container">
          {{#if this.isLoading}}
            <div class="loading animate-pulse">Loading jobs...</div>
          {{else if this.error}}
            <div class="error">{{this.error}}</div>
          {{else}}
            {{{this.renderedJobs}}}
          {{/if}}
        </div>
        <div class="pagination-container">
          {{#if (not this.isLoading)}}
            {{#if (gt this.totalPages 1)}}
              <div class="pagination">
                <button 
                  class="pagination-btn" 
                  {{on "click" this.previousPage}}
                  disabled={{eq this.currentPage 1}}
                >
                  Previous
                </button>
                
                {{#each this.pageNumbers as |page|}}
                  {{#if (eq page "...")}}
                    <span class="pagination-ellipsis">...</span>
                  {{else}}
                    <button 
                      class="pagination-btn {{if (eq page this.currentPage) 'active'}}"
                      {{on "click" (fn this.goToPage page)}}
                    >
                      {{page}}
                    </button>
                  {{/if}}
                {{/each}}
                
                <button 
                  class="pagination-btn" 
                  {{on "click" this.nextPage}}
                  disabled={{eq this.currentPage this.totalPages}}
                >
                  Next
                </button>
              </div>
            {{/if}}
          {{/if}}
        </div>
      </div>

      <div class="job-preview" {{on "click" this.handleShareClick}}>
        {{{this.renderedJobDetails}}}
      </div>
    </div>
  </template>
}