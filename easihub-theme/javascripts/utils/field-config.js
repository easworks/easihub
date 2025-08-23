const fieldConfig = {
  questions: [
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

  use_cases: [
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

  articles: [
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

  bulletins: [
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

  events: [
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
  ]
};

export default fieldConfig;
