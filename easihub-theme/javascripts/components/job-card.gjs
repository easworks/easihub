import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { htmlSafe } from '@ember/template';
import { on } from '@ember/modifier';

export default class JobCardComponent extends Component {
  @service router;
  @tracked jobs = [];
  @tracked selectedJob = null;
  @tracked isLoading = false;
  @tracked isLoadingMore = false;
  @tracked isLoadingDetails = false;
  @tracked error = null;
  @tracked totalRecords = 0;
  @tracked pageNum = 1;
  @tracked pageSize = 10;

  constructor() {
    super(...arguments);
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

  get showMore() {
    return this.jobs.length >= this.pageSize * this.pageNum;
  }

  get showMoreButton() {
    return this.showMore || this.isLoadingMore;
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
      const response = await fetch('https://easihub.com/erp_db/api/erp-collections/jobs/count', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      });
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      const result = await response.json();
      this.totalRecords = result.totalRecords || 0;
    } catch (error) {
      console.error('Error fetching job count:', error);
      this.totalRecords = 0;
    }
  }

  @action
  async fetchJobs(reset = true) {
    if (reset) {
      this.pageNum = 1;
      this.jobs = [];
      this.isLoading = true;
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
        page_num: this.pageNum,
        page_size: this.pageSize
      };
      
      const response = await fetch('https://easihub.com/erp_db/api/erp-collections/jobs', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      });
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      const result = await response.json();
      const newJobs = Array.isArray(result) ? result : (result?.data || []);
      
      if (reset) {
        this.jobs = newJobs;
        if (newJobs.length > 0) {
          this.selectedJob = newJobs[0];
        }
      } else {
        this.jobs = [...this.jobs, ...newJobs];
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
      const response = await fetch('https://easihub.com/erp_db/api/erp-collections/jobs/details', {
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
  async loadMore(event) {
    event.preventDefault();
    const sidebar = document.querySelector('.jobs-sidebar');
    const currentScrollTop = sidebar.scrollTop;
    this.pageNum += 1;
    await this.fetchJobs(false);
    sidebar.scrollTop = currentScrollTop;
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
              <span class="text-gray-400">|</span>
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
          <a href="${job.apply_url || '#'}" target="_blank" class="quick-apply-btn" onclick="event.stopPropagation()">
            Apply
          </a>
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
        
        <div class="preview-body">
          ${comp_desc ? `<div class="preview-section"><h3 class="preview-title">Company Description</h3><p>${comp_desc}</p></div>` : ''}
          
          ${full_job_description ? `<div class="preview-section"><h3 class="preview-title">Job Description</h3><div class="job-desc">${full_job_description}</div></div>` : ''}
          
          ${reqSkills ? `<div class="preview-section"><h3>Required Skills</h3><div class="tags-container">${reqSkills}</div></div>` : ''}
          
          ${techSkillsList ? `<div class="preview-section"><h3 class="preview-title">Tech Stack</h3><div class="tags-container">${techSkillsList}</div></div>` : ''}
          
          ${qualificationsList ? `<div class="preview-section"><h3 class="preview-title">Qualifications</h3><div class="qualifications-list">${qualificationsList}</div></div>` : ''}
          
          ${benefitsList ? `<div class="preview-section"><h3 class="preview-title">Benefits</h3><div class="tags-container">${benefitsList}</div></div>` : ''}
          
          ${industries ? `<div class="preview-section"><h3 class="preview-title">Industry</h3><div class="tags-container">${industries}</div></div>` : ''}
        </div>
        
        <div class="preview-footer">
          <a href="${apply_url}" target="_blank" class="apply-button">
            ${apply_button_label || 'Apply Now'}
          </a>
        </div>
      </div>
    `;
  }

  get renderedJobs() {
    if (!this.jobs?.length) {
      return htmlSafe('<div class="no-jobs">No jobs available</div>');
    }
    const html = this.jobs.map((job, index) => {
      const isActive = this.selectedJob?._id === job._id;
      return this.templateJob(job, isActive);
    }).join('');
    return htmlSafe(`<div class="jobs-list mt-2">${html}</div>`);
  }

  @action
  handleJobClick(event) {
    const jobCard = event.target.closest('.job-card');
    if (jobCard) {
      const jobId = jobCard.dataset.jobId;
      this.selectJob(jobId);
    }
  }

  get renderedJobDetails() {
    return htmlSafe(this.templateJobDetails(this.selectedJob));
  }

  <template>
    <div class="job-layout">
      <div class="jobs-sidebar" {{on "click" this.handleJobClick}}>
        {{#if this.isLoading}}
          <div class="loading">Loading jobs...</div>
        {{else if this.error}}
          <div class="error">{{this.error}}</div>
        {{else}}
          {{{this.renderedJobs}}}
        {{/if}}
        
        {{#if this.showMoreButton}}
          <div class="load-more">
            <button 
              class="load-more-btn {{if this.isLoadingMore 'animate-pulse'}}"
              {{on "click" this.loadMore}}
              disabled={{this.isLoadingMore}}
            >
              {{#if this.isLoadingMore}}Loading...{{else}}Load More{{/if}}
            </button>
          </div>
        {{/if}}
      </div>

      <div class="job-preview">
        {{{this.renderedJobDetails}}}
      </div>
    </div>
  </template>
}