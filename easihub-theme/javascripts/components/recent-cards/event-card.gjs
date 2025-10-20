import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

export default class EventCard extends Component {
  @tracked events = [];
  @tracked isLoading = false;

  eventsCategory = [
    {
      "domain": "CRM",
      "software": "Salesforce"
    },
    {
      "domain": "ERP",
      "software": "SAP S/4HANA"
    },
    {
      "domain": "Cloud Platforms",
      "software": "Amazon Web Services (AWS)"
    },
  ]

  softwareUrls = {
    "Salesforce": "/tags/c/crm-customer-relationship-management/salesforce/1589/event",
    "SAP S/4HANA": "/tags/c/erp-enterprise-resource-planning/sap-s4hana/1588/event",
    "Amazon Web Services (AWS)": "/tags/c/cloud-platforms/aws/1045/event"
  }

  constructor(){
    super(...arguments);
    this.getevents();
  }

  async getevents() {
    const allevents = [];

    this.isLoading = true;

    for (const item of this.eventsCategory) {
      try {
        const data = {
          domain_name: item.domain,
          software_name: item.software, 
          topic_type: "events",
          page_num: 1,
          page_size: 1
        };
          
        const response = await fetch('https://community.easihub.com/erp_db/api/erp-collections', {
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
        allevents.push(...newContent);
        
      } catch (error) {
        console.error(`Error fetching events for ${item.software}:`, error);
      } finally {
        this.isLoading = false;
      }
    }
    
    this.events = allevents;
  }

  getAuthorName(event){
    return (typeof event.author_name === "string" && event.author_name.trim() !== "")
    ? event.author_name
    : "Unknown Author";
  }

  getDates(event) {
    let start_date = new Date(event.start_date.$date);
    let end_date = new Date(event.end_date.$date); 
    let date = 'Not Specified';
    if(start_date && end_date) {
      return date = `${start_date.toLocaleString("default", {month: "short"})} ${start_date.getDate()} - ${end_date.toLocaleString("default", {month: "short"})} ${end_date.getDate()} ${start_date.getFullYear()}`
    }
    return date;
  }

  getCategoryUrl = (event) => {
    return this.softwareUrls[event.software_name] || "#";
  }

  isNewEvent = (event) => {
    const now = new Date();
    const eventDate = new Date(event.start_date.$date);
    const threeWeeksFromNow = new Date(now.getTime() + (21 * 24 * 60 * 60 * 1000));
    return eventDate <= threeWeeksFromNow && eventDate >= now;
  }

  getUrl = (event) => {
    if(!event.url) {
      return this.softwareUrls[event.software_name] || '#';
    }
    return event.url;
  }

  <template>
      <div class="section section--events">
          <div class="section-header">
            <div class="section-title">
              <span class="section-icon">📅</span>Events
            </div>
          </div>
          {{#if this.isLoading}}
            <div class="loading w-full p-4 flex items-center justify-center text-sm font-bold text-primary-500 animate-pulse">Loading events...</div>
          {{else if this.events.length}}
          {{#each this.events as |event|}}
          {{#let 
            (this.getAuthorName event)
            (this.getDates event)
            (this.getCategoryUrl event)
            (this.isNewEvent event)
            (this.getUrl event)
            as |author date categoryUrl isNew eventUrl|
          }}
            <div class="event-card" style="border-left: 3px solid #8b5cf6">
              <a
                href={{eventUrl}}
                style="display: block; text-decoration: none; color: inherit"
              >
                <div class="event-title">
                  {{event.title}}{{#if isNew}}<span class="badge new">New</span>{{/if}}
                </div>
                <div class="event-date">{{date}}</div>
                <div class="event-desc">World's largest AI and CRM conference</div>
              </a>
              <div class="event-footer">
                <a href={{categoryUrl}} class="event-view-all">View All {{event.software_name}} Events →</a>
              </div>
            </div>
          {{/let}}
          {{/each}}
          {{/if}}
      </div>
  </template>
}