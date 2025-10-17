import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class JobCard extends Component {
  @tracked jobs = [];
  @tracked isLoading = false;

  jobsCategory = [
    {
      "domain": "CRM",
      "software": "Salesforce"
    },
    {
      "domain": "ERP",
      "software": "SAP S/4HANA"
    },
    {
      "domain": "PLM",
      "software": "Teamcenter"
    },
  ]

  softwareUrls = {
    "Salesforce": "/tags/c/crm-customer-relationship-management/salesforce/1589/job",
    "SAP S/4HANA": "/tags/c/erp-enterprise-resource-planning/sap-s4hana/1588/job",
    "Teamcenter": "/tags/c/plm-product-lifecycle-management/teamcenter/686/job"
  }

  constructor(){
    super(...arguments);
    this.getjobs();
  }

  async getjobs() {
    const alljobs = [];

    this.isLoading = true;

    for (const item of this.jobsCategory) {
      try {
        const data = {
          domain_name: item.domain,
          software_name: item.software, 
          topic_type: "jobs",
          page_num: 1,
          page_size: 1
        };
          
        const response = await fetch('https://community.easihub.com/erp_db/api/erp-collections/jobs', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(data)
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const result = await response.json();
        const newContent = Array.isArray(result) ? result : (result?.data || []);
        alljobs.push(...newContent);
        
      } catch (error) {
        console.error(`Error fetching jobs for ${item.software}:`, error);
      } finally {
        this.isLoading = false;
      }
    }
    
    this.jobs = alljobs;
  }

  getAuthorName(job){
    return (typeof job.author_name === "string" && job.author_name.trim() !== "")
    ? job.author_name
    : "Unknown Author";
  }

  getDates(job) {
    let start_date = new Date(job.start_date.$date);
    let end_date = new Date(job.end_date.$date); 
    let date = 'Not Specified';
    if(start_date && end_date) {
      return date = `${start_date.toLocaleString("default", {month: "short"})} ${start_date.getDate()} - ${end_date.toLocaleString("default", {month: "short"})} ${end_date.getDate()} ${start_date.getFullYear()}`
    }
    return date;
  }

  getCategoryUrl = (job) => {
    return this.softwareUrls[job.software_name] || "#";
  }

  getUrl = (job) => {
    if(job.apply_url === "Not Applicable"){
      return this.softwareUrls[job.software_name] || '#';
    }
    return job.apply_url;
  }

  <template>
      <div class="section section--jobs">
          <div class="section-header">
            <div class="section-title">
              <span class="section-icon">📅</span>jobs
            </div>
          </div>
          {{#if this.isLoading}}
            <div class="loading w-full p-4 flex items-center justify-center text-sm font-bold text-primary-500 animate-pulse">Loading jobs...</div>
          {{else if this.jobs.length}}
          {{#each this.jobs as |job|}}
          {{#let 
            (this.getAuthorName job)
            (this.getDates job)
            (this.getCategoryUrl job)
            (this.getUrl job)
            as |author date categoryUrl jobUrl|
          }}
            <div class="job-card">
              <a
                href={{jobUrl}}
                style="display: block; text-decoration: none; color: inherit"
              >
                <div class="job-title">{{job.job_title}}</div>
                <div class="job-company">{{job.company_name}}</div>
                <div class="job-location">{{job.job_location}}</div>
                <div class="job-tags">
                  <span class="tag">{{job.software_name}}</span><span class="tag green">{{job.domain_name}}</span
                  ><span class="tag blue">Integrations</span>
                </div>
              </a>
              <div class="job-footer">
                <a href={{categoryUrl}} class="job-view-all">View All {{job.software_name}} Jobs →</a>
              </div>
            </div>
          {{/let}}
          {{/each}}
          {{/if}}
      </div>
  </template>
}