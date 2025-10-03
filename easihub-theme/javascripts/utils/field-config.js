const fieldConfig = {
  question: [
    {
      key: "title",
      type: "input",
      label: "Step 2: Title (Describe your question briefly)",
      placeholder: "Clearly state your question related to a domain, software, or technical area (e.g., 'SAP API error in OAuth setup')"
    },
    {
      key: "problem_details",
      type: "textarea",
      label: "Step 4: Problem Details (Include error, setup info, or code snippet)",
      placeholder: "Include system or technical area, version info, exact error message, and setup context..."
    },
    {
      key: "attempted_solutions",
      type: "textarea",
      label: "Step 5: Attempted Solutions (Explain what you've already attempted)",
      placeholder: "Explain what methods you tried (config steps, API calls, scripts) and what happened..."
    }
  ],

  discussion: [
    {
      key: "title",
      type: "input",
      label: "Step 2: Discussion Title (Frame your topic)",
      placeholder: "What are pros/cons of customizing Oracle Fusion workflows?"
    },
    {
      key: "context",
      type: "textarea",
      label: "Step 4: Discussion Context (Describe your thoughts or objective)",
      placeholder: "Share context: what prompted this discussion, which systems or challenges are involved..."
    }
  ],

  use_case: [
    {
      key: "title",
      type: "input",
      label: "Step 2: Use Case Title (Summarize your solution)",
      placeholder: "Automated BOM sync between Teamcenter and SAP using REST API"
    },
    {
      key: "problem",
      type: "textarea",
      label: "Step 4: Problem (Describe the initial situation)",
      placeholder: "Describe original bottleneck or process issue, e.g., manual data duplication in ERP & PLM..."
    },
    {
      key: "solution",
      type: "textarea",
      label: "Step 5: Solution (Explain what you built or configured)",
      placeholder: "Mention technical setup (scripts, APIs, middleware), sequence, validations, etc."
    },
    {
      key: "outcome",
      type: "textarea",
      label: "Step 6: Outcome (Summarize the impact)",
      placeholder: "E.g., Reduced manual entry by 60%, improved data accuracy across ERP-PLM"
    }
  ],

  article: [
    {
      key: "title",
      type: "input",
      label: "Step 2: Article Title (Summarize your article)",
      placeholder: "Enter a clear, descriptive article title"
    },
    {
      key: "content",
      type: "textarea",
      label: "Step 4: Article Content or External URL",
      placeholder: "Write your content here (Markdown/HTML) or paste an article URL (e.g., https://yourdomain.com/article123)"
    },
    {
      key: "image",
      type: "file",
      label: "Step 5: Thumbnail Image"
    },
    {
      key: "source",
      type: "input",
      label: "Step 6: Source",
      placeholder: "Source URL or reference (e.g., oracle.com)"
    },
    {
      key: "author",
      type: "input",
      label: "Step 7: Author",
      placeholder: "Author name or reference (e.g., John Doe)"
    },
    {
      key: "publication_date",
      type: "date",
      label: "Step 8: Publication Date"
    }
  ],

  bulletin: [
    {
      key: "title",
      type: "input",
      label: "Step 2: Bulletin Title (Summarize your bulletin)",
      placeholder: "E.g., Oracle Fusion Q2 Update Released"
    },
    {
      key: "desc",
      type: "textarea",
      label: "Step 4: Description or URL",
      placeholder: "Summarize the bulletin or paste a URL (e.g., https://updates.oracle.com/fusion2024q2)..."
    },
    {
      key: "release",
      type: "input",
      label: "Step 5: Release Name",
      placeholder: "e.g., Teamcenter 15.4, Fusion HCM Q2 2024"
    },
    {
      key: "release_date",
      type: "date",
      label: "Step 6: Release Date"
    },
    {
      key: "image",
      type: "file",
      label: "Step 7: Thumbnail Image"
    },
    {
      key: "source",
      type: "input",
      label: "Step 8: Source",
      placeholder: "Source URL or reference (e.g., oracle.com)"
    },
    {
      key: "author",
      type: "input",
      label: "Step 9: Author / Publisher",
      placeholder: "Author name or reference (e.g., John Doe)"
    }
  ],

  event: [
    {
      key: "title",
      type: "input",
      label: "Step 2: Event Title (Summarize your event)",
      placeholder: "E.g., Join our SAP S/4HANA API Workshop - June 2025"
    },
    {
      key: "type",
      type: "select",
      label: "Step 4: Type of Event",
      options: {
        "conference": "Conference",
        "webinar": "Webinar",
        "workshop": "Workshop",
        "meetup": "Meetup"
      }
    },
    {
      key: "desc",
      type: "textarea",
      label: "Step 5: Event Details or Registration Link",
      placeholder: "Provide event details or paste registration link..."
    },
    {
      key: "image",
      type: "file",
      label: "Step 6: Thumbnail Image"
    },
    {
      key: "organizer",
      type: "input",
      label: "Step 7: Organizer and Website",
      placeholder: "Organizer (e.g., SAP, Dassault)"
    },
    {
      key: "website",
      type: "input",
      label: "Event Website",
      placeholder: "Official Event Website URL"
    },
    {
      key: "start_date",
      type: "date",
      label: "Step 8: Start Date"
    },
    {
      key: "end_date",
      type: "date",
      label: "Step 9: End Date"
    }
  ],

  job: [
    {
      key: "section1_label",
      label: "Basic Job Details"
    },
    {
      key: "title",
      type: "input",
      label: "Job Title",
      placeholder: "e.g., SAP Basis Consultant (Mid-Level), PLM Solution Architect – Teamcenter (Lead)"
    },
    {
      key: "company",
      type: "input",
      label: "Company Name",
      placeholder: "e.g., Accenture, Deloitte"
    },
    {
      key: "section2_label",
      label: "Classification"
    },
    {
      key: "domain",
      type: "select",
      label: "Domain",
      options: {
        "erp": "ERP",
        "crm": "CRM",
        "plm": "PLM",
        "scm": "SCM",
        "hcm": "HCM",
        "cloud-platforms": "Cloud Platforms",
        "ba-bi": "BA/BI",
        "mes": "MES",
        "qcm": "QCM"
      }
    },
    {
      key: "software",
      type: "input",
      label: "Software",
      placeholder: "e.g., SAP, Oracle, SAP HANA"
    },
    {
      key: "work_mode",
      type: "select",
      label: "Work Mode",
      options: {
        "onsite": "Onsite",
        "remote": "Remote",
        "hybrid": "Hybrid"
      }
    },
    {
      key: "job_type",
      type: "select",
      label: "Job Type",
      options: {
        "full-time": "Full-time",
        "part-time": "Part-time",
        "contract": "Contract",
        "internship": "Internship"
      }
    },
    {
      key: "section3_label",
      label: "Compensation"
    },
    {
      key: "compensation_type",
      type: "select",
      label: "Compensation Type",
      options: {
        "yearly": "Yearly",
        "monthly": "Monthly",
        "weekly": "Weekly",
        "hourly": "Hourly",
      }
    },
    {
      key: "compensation_range",
      type: "input",
      label: "Compensation Range",
      placeholder: "e.g. $80,000 - $100,000/year"
    },
    {
      key: "section4_label",
      label: "Experience & Skills"
    },
    {
      key: "seniority",
      type: "select",
      label: "Seniority Level",
      options:{
        "intern": "Intern/Trainee (0–1 year experience)",
        "entry": "Entry-Level (1–2 years experience)",
        "mid": "Mid-Level Consultant (2–4 years experience)",
        "experienced": "Experienced Consultant (4–7 years experience)",
        "senior": "Senior Consultant (7–10 years experience)",
        "lead": "Lead/Principal Consultant (10-15 years experience)",
        "distinguished": "Distinguished Principal Consultant(15+ years experience)"
      }
    },
    {
      key: "skills",
      type: "input",
      label: "Skills",
      placeholder: "e.g. SAP, SQL, REST API"
    },
    {
      key: "section5_label",
      label: "Job Details"
    },
    {
      key: "location",
      type: "input",
      label: "Location",
      placeholder: "e.g. Remote or New York"
    },
    {
      key: "duration",
      type: "input",
      label: "Duration",
      placeholder: "e.g. 6 months"
    },
    {
      key: "section6_label",
      label: "Description"
    },
    {
      key: "desc",
      type: "textarea",
      label: "Job Description",
      placeholder: "Describe responsibilities, expectations, duties, etc."
    },
    {
      key: "qualification",
      type: "textarea",
      label: "Qualifications",
      placeholder: "e.g. PMP, ERP Certification"
    },
    {
      key: "benefit",
      type: "textarea",
      label: "Benefits",
      placeholder: "e.g. Health, PTO, Remote Option"
    },
    {
      key: "section7_label",
      label: "Application Info"
    },
    {
      key: "external",
      type: "input",
      label: "External Apply URL",
      placeholder: "https://..."
    },
    {
      key: "email",
      type: "input",
      label: "Contact Email",
      placeholder: "e.g. jobs@company.com"
    },
    {
      key: "company_logo",
      type: "file",
      label: "Company Logo"
    },
    {
      key: "posting_date",
      type: "date",
      label: "Posting Date"
    },
    {
      key: "expiry_date",
      type: "date",
      label: "Expiry Date"
    }
]};

export default fieldConfig;
