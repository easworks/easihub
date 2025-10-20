import { apiInitializer } from "discourse/lib/api";
import Category from 'discourse/models/category';
import sleep from '../../utils/sleep';

export default apiInitializer(async api => {

  const site = api.container.lookup('service:site');
  const store = api.container.lookup('service:store');

  let topicTagsAll = {
    "Teamcenter": ["Product Data Management", "Engineering Collaboration", "Change Management", "Bill Of Materials", "Integration", "Compliance", "Digital Twin", "Workflow Automation", "Reporting"],
    "Aras Innovator": ["Low Code Platform", "Configuration Management", "Document Management", "Collaboration", "Reporting"],
    "Windchill": ["Product Data Management", "Change Management", "Bill Of Materials", "Configuration Management", "Integration", "Digital Twin"],
    "Enovia": ["Collaboration", "Bill Of Materials", "Document Management", "Workflow Automation", "3d Experience"],
    "Oracle Agile Plm": ["Product Data Management", "Change Management", "Configuration Management", "Workflow Automation", "Document Management"],
    "Sap Plm": ["Product Data Management", "Integration", "Change Management", "Bill Of Materials", "Engineering Data"],
    "Tableau": ["Business Intelligence", "Data Visualization", "Analytics", "Dashboarding", "Interactive Analysis", "Kpis"],
    "Power Bi": ["Business Intelligence", "Data Visualization", "Analytics", "Dashboarding", "Data Preparation", "Kpis"],
    "Sql Server Reporting Services S S R S": ["Reporting", "Business Intelligence", "Data Visualization", "Dashboarding", "Scheduling"],
    "Sap Crystal Reports": ["Reporting", "Business Intelligence", "Data Visualization", "Analytics", "Export Formats"],
    "Ibm Cognos Analytics": ["Data Visualization", "Analytics", "Dashboarding", "Ai Insights"],
    "Qlik Sense": ["Data Visualization", "Analytics", "Dashboarding", "Self Service Bi", "Interactive Analysis"],
    "Tableau Crm Einstein Analytics": ["Data Visualization", "Analytics", "Dashboarding", "Ai Insights"],
    "Mode Analytics": ["Data Visualization", "Analytics", "Dashboarding", "Sql Based"],
    "Amazon Web Services Aws": ["Infrastructure As A Service", "Compute", "Storage", "Networking", "Security", "Databases", "Analytics", "Ai Ml", "Devops"],
    "Microsoft Azure": ["Infrastructure As A Service", "Compute", "Storage", "Networking", "Security", "Databases", "Ai Ml", "Devops"],
    "Google Cloud Platform Gcp": ["Infrastructure As A Service", "Compute", "Storage", "Networking", "Security", "Databases", "Analytics"],
    "Alibaba Cloud": ["Infrastructure As A Service", "Compute", "Storage", "Networking", "Security", "Databases"],
    "Oracle Cloud": ["Infrastructure As A Service", "Compute", "Storage", "Networking", "Security", "Databases", "Analytics"],
    "Ibm Cloud": ["Infrastructure As A Service", "Compute", "Storage", "Networking", "Security", "Analytics"],
    "Siemens Opcenter Execution": ["Manufacturing Operations", "Production Scheduling", "Quality Management", "Traceability", "Resource Management"],
    "Rockwell Factory Talk Mes": ["Manufacturing Operations", "Production Scheduling", "Quality Management", "Traceability"],
    "Aveva Mes": ["Manufacturing Operations", "Production Scheduling", "Quality Management", "Resource Management"],
    "Ge Proficy Smart Factory": ["Manufacturing Operations", "Production Scheduling", "Traceability"],
    "Delmia Apriso Mes": ["Manufacturing Operations", "Production Scheduling", "Workflow Automation", "Integration"],
    "Honeywell Mes": ["Manufacturing Operations", "Production Scheduling", "Analytics", "Compliance"],
    "Sap S 4 Hana": ["Finance", "Procurement", "Supply Chain", "Manufacturing", "Sales", "Service", "Analytics", "Compliance"],
    "Salesforce": ["Sales Automation", "Marketing Automation", "Service Management", "Customer Experience", "Mobile", "Ai Insights"],
    "Infor Cloudsuite": ["Finance", "Procurement", "Supply Chain", "Manufacturing", "Sales", "Service", "Integration"],
    "Oracle Jd Edwards": ["Finance", "Procurement", "Supply Chain", "Manufacturing", "Sales", "Service", "Analytics"],
    "Microsoft Dynamics 365": ["Finance", "Sales", "Service", "Marketing", "Ai Insights"],
    "Netsuite": ["Finance", "Procurement", "Supply Chain", "Manufacturing", "Sales", "Service"],
    "Odoo": ["Finance", "Procurement", "Supply Chain", "Manufacturing", "Sales", "Service", "Integration"],
    "Peoplesoft": ["Finance", "Procurement", "Supply Chain", "Hr", "Service"],
    "Oracle Fusion Cloud": ["Finance", "Procurement", "Supply Chain", "Hr"],
    "Workday": ["Finance", "Procurement", "Supply Chain", "Hr"],
    "Adobe Experience Cloud": ["Marketing", "Customer Experience", "Content Management", "Campaign Management", "Personalization", "Advertising", "Commerce", "Ai Insights"],
    "Oracle Cx Cloud": ["Customer Experience", "Sales", "Marketing", "Service", "Collaboration", "Mobile"],
    "Hubspot": ["Marketing Automation", "Sales Automation", "Service Management", "Customer Experience", "Collaboration", "Content Management", "Campaign Management"],
    "Microsoft Dynamics 365 Sales": ["Sales Automation", "Customer Experience", "Marketing Automation", "Service Management", "Collaboration", "Mobile"],
    "Sap Customer Experience Sap Cx": ["Customer Experience", "Sales", "Marketing", "Service", "Collaboration", "Mobile"],
    "Zendesk Sell": ["Sales Automation", "Customer Experience", "Service Management", "Collaboration", "Workflow Automation"],
    "Zoho Crm": ["Sales Automation", "Customer Experience", "Marketing Automation", "Service Management", "Collaboration", "Mobile"],
    "Sap Ibp": ["Supply Chain Planning", "Demand Planning", "Inventory Optimization", "Supply Planning", "Response Planning", "Forecasting"],
    "Oracle Fusion Cloud Scm": ["Supply Chain Management", "Procurement", "Logistics", "Planning", "Manufacturing", "Order Management"],
    "Blue Yonder Luminate": ["Demand Planning", "Inventory Optimization", "Supply Planning", "Logistics", "Forecasting"],
    "Infor Scm": ["Procurement", "Logistics", "Planning", "Manufacturing", "Order Management"],
    "Manhattan Active Supply Chain": ["Warehouse Management", "Transportation Management", "Order Management", "Planning"],
    "Epicor Scm": ["Procurement", "Logistics", "Planning", "Manufacturing", "Order Management"],
    "Snowflake": ["Cloud Data Platform", "Data Warehouse", "Data Lake", "Sql Analytics", "Data Sharing", "Scalability", "Real Time Data", "Etl", "Multi Cloud"],
    "Workday Hcm": ["Talent Management", "Recruiting", "Workforce Planning", "Learning", "Benefits", "Time Tracking", "Employee Experience"],
    "Sap Successfactors": ["Talent Management", "Recruiting", "Onboarding", "Performance Management", "Learning", "Compensation", "Employee Experience"],
    "Oracle Hcm Cloud": ["Core Hr", "Talent Management", "Workforce Management", "Recruiting", "Employee Experience", "Compensation", "Learning"],
    "Ukg Pro": ["Time And Attendance", "Talent Management", "Employee Experience", "Benefits", "Workforce Management", "Recruiting", "Onboarding"],
    "Adp Workforce Now": ["Time And Attendance", "Benefits", "Recruiting", "Talent Management", "Compliance", "Employee Self Service", "Hr Automation"],
    "Ceridian Dayforce": ["Workforce Management", "Recruiting", "Talent Management", "Time And Attendance", "Learning", "Benefits", "Compliance"],
    "Generic Qms Topics": ["Quality Management System", "Document Control", "Compliance", "Risk Management", "Audit Management", "Training Management", "Nonconformance", "Corrective Actions", "Process Improvement", "Sop Management"],
    "Mastercontrol Quality Excellence": ["Document Management", "Training Management", "Risk Management", "Audit Management", "Supplier Quality", "Product Quality", "Workflow Automation", "Electronic Signatures"],
    "Etq Reliance": ["Compliance", "Document Control", "Audit Management", "Risk Management", "Supplier Quality", "Training Management", "Workflow Automation", "Corrective Actions", "Nonconformance"],
    "Veeva Vault Qms": ["Cloud Qms", "Compliance", "Document Control", "Audit Trails", "Workflow Automation", "Training Management", "Risk Management", "Corrective Actions", "Change Control"],
    "Sparta Systems Trackwise": ["Enterprise Qms", "Compliance", "Audit Management", "Risk Management", "Document Control", "Workflow Automation", "Corrective Actions", "Nonconformance", "Supplier Quality"],
    "Arena Qms By Ptc": ["Cloud Qms", "Compliance", "Document Management", "Audit Management", "Risk Management", "Workflow Automation", "Training Management", "Change Control", "Collaboration"],
    "Qualio": ["Cloud Qms", "Life Sciences", "Document Control", "Training Management", "Audit Readiness", "Workflow Automation", "Risk Management", "Corrective Actions"]
  };

  function getTopicTagsFromAll(categoryName) {
    // Direct match first
    if (topicTagsAll[categoryName]) {
      return topicTagsAll[categoryName].slice(0, Math.floor(Math.random() * 5) + 8);
    }

    // Fuzzy matching for partial names
    const lowerCategoryName = categoryName.toLowerCase();
    for (const [softwareName, tags] of Object.entries(topicTagsAll)) {
      const lowerSoftwareName = softwareName.toLowerCase();
      if (lowerCategoryName.includes(lowerSoftwareName) || lowerSoftwareName.includes(lowerCategoryName)) {
        return tags.slice(0, Math.floor(Math.random() * 5) + 8);
      }
    }

    // Default tags if no match found
    return ['api-integration', 'configuration', 'customization', 'reporting', 'security', 'performance', 'data-management', 'workflow', 'analytics', 'administration'];
  }

  // const ids = Object.keys(CUSTOM_DATA);

  // const categories = await Category.asyncFindByIds([...ids]);
  const categories = await Category.list();


  // await Promise.all(categories.map(async category => {
  //   const customData = CUSTOM_DATA[category.id];

  //   const isSynced =
  //     await fastStableStringify(category.custom_fields.eas)
  //     === await fastStableStringify(customData);

  //   if (isSynced) {
  //     return;
  //   }

  //   console.log(`updating category ${category.id}, ${category.slug}`);

  //   category = await Category.reloadCategoryWithPermissions(
  //     { slug: Category.slugFor(category) },
  //     store,
  //     site
  //   );

  //   category.custom_fields.eas = customData;

  //   await category.save();
  // }));

  async function asyncPool(poolLimit, array, iteratorFn) {
    const ret = [];
    const executing = [];
    for (const item of array) {
      const p = Promise.resolve().then(() => iteratorFn(item));
      ret.push(p);

      if (poolLimit <= array.length) {
        const e = p.then(() => executing.splice(executing.indexOf(e), 1));
        executing.push(e);
        if (executing.length >= poolLimit) {
          await Promise.race(executing);
        }
      }
    }
    return Promise.all(ret);
  }

  function avatarTextFormatter(slug) {
    return slug.split("-")
      .slice(0, 3)
      .map(part => part.charAt(0).toUpperCase())
      .join("");
  }

  async function findCategoryByIdAndUpdate(id, fn) {
    let category = Category.findById(id);
    await sleep(100);
    category = await Category.reloadCategoryWithPermissions(
      { slug: Category.slugFor(category) },
      store,
      site
    );

    await fn(category);
    await category.save();
  }



  // await asyncPool(4, categories, async (category) => {
  //   try {
  //     if (category.parentCategory && category.predecessors.length === 1) {

  //       // 2. define base schema
  //       const newCustomData = {
  //         types: [],
  //         badges: [],
  //         whenToPost: "",
  //         genericSubcategories: [],
  //         technicalAreas: [],
  //         topicTags: [],
  //       };

  //       // 3. assign logic-driven values
  //       if (category.slug.includes("generic")) {
  //         newCustomData.types = ["hub", "generic"];
  //         newCustomData.avatarText = avatarTextFormatter(category.slug);
  //         newCustomData.badges = ["Generic Topics"];
  //       } else if (category.slug.includes("strategy")) {
  //         newCustomData.types = ["hub", "strategy"];
  //         newCustomData.avatarText = avatarTextFormatter(category.slug);
  //         newCustomData.badges = ["Strategy"];
  //       } else {
  //         newCustomData.types = ["hub", "software"];
  //         newCustomData.avatarText = avatarTextFormatter(category.slug);
  //         newCustomData.topicTags = getTopicTagsFromAll(category.name);
  //       }
  //       // 4. compare with existing data
  //       const isSynced =
  //         (await fastStableStringify(category.custom_fields.eas)) ===
  //         (await fastStableStringify(newCustomData));


  //       if (isSynced) {
  //         return;
  //       }

  //       // 5. reload latest version of category with delay
  //       await new Promise(resolve => setTimeout(resolve, 500));
  //       category = await Category.reloadCategoryWithPermissions(
  //         { slug: Category.slugFor(category) },
  //         store,
  //         site
  //       );

  //       // 6. assign the new object (always same schema)
  //       category.custom_fields.eas = newCustomData;

  //       // Add delay before save
  //       await new Promise(resolve => setTimeout(resolve, 500));
  //       await category.save();
  //     }
  //   } catch (error) {
  //     console.error(`Error processing category ${category.name}:`, error);
  //   }
  // });

});
