const fs = require('fs');
const path = require('path');

const inputJson = 'strudel.json';
const outputFile = 'strudel.md';

function generateDocumentation() {
  try {
    const data = JSON.parse(fs.readFileSync(inputJson, 'utf8'));
    const categories = Object.keys(data).filter(key => key !== '_base');

    // 1. Start with the main heading and an anchor for "Back to top"
    let md = '# Included Samples\n\n';
    
    // 2. Generate Table of Contents
    md += '## Table of Contents\n';
    categories.forEach(cat => {
      // Create a slug for the link (lowercase, replace spaces with hyphens)
      const slug = cat.toLowerCase().replace(/\s+/g, '-');
      md += `* [${cat}](#${slug})\n`;
    });
    md += '\n---\n\n';

    // 3. Generate Sections for each category
    categories.forEach(category => {
      md += `## ${category}\n\n`;
      md += '| sample | file name |\n';
      md += '| :--- | :--- |\n';

      const files = data[category];
      if (Array.isArray(files)) {
        files.forEach((filePath, index) => {
          const fileName = path.basename(filePath);
          const sampleTag = `\`${category}:${index}\``;
          md += `| ${sampleTag} | ${fileName} |\n`;
        });
      }

      // 4. Add "Back to top" link
      md += `\n[↑ Back to top](#included-samples)\n\n`;
    });

    // Write to file
    fs.writeFileSync(outputFile, md);
    console.log(`Successfully created: ${outputFile}`);

  } catch (err) {
    console.error('Error:', err.message);
  }
}

generateDocumentation();