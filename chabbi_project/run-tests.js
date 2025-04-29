#!/usr/bin/env node

// Define polyfills for File and Blob
class Blob {
  constructor(blobParts = [], options = {}) {
    this.type = options.type || '';
    this._buffer = Buffer.concat(
      Array.isArray(blobParts) 
        ? blobParts.map(bit => bit instanceof Buffer ? bit : Buffer.from(bit)) 
        : [Buffer.from(blobParts)]
    );
  }
  
  get size() {
    return this._buffer.length;
  }
  
  slice(start, end, contentType) {
    return new Blob(
      [this._buffer.slice(start, end)],
      { type: contentType || this.type }
    );
  }
}

class File extends Blob {
  constructor(fileBits, fileName, options = {}) {
    super(fileBits, options);
    this.name = fileName;
    this.lastModified = options.lastModified || Date.now();
  }
}

// Add to global scope
global.Blob = Blob;
global.File = File;

console.log('Successfully loaded Blob and File polyfills');

// Load required modules
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Run tests
try {
  // Path to environment file
  const envFile = path.resolve(__dirname, 'env.json');
  
  // Path to collection file
  const collectionFile = path.resolve(__dirname, 'auth', 'auth.json');
  
  // Check if files exist
  if (!fs.existsSync(envFile)) {
    console.error(`Environment file not found: ${envFile}`);
    process.exit(1);
  }
  
  if (!fs.existsSync(collectionFile)) {
    console.error(`Collection file not found: ${collectionFile}`);
    process.exit(1);
  }
  
  // Create a temporary environment file with the expected format
  const originalEnv = JSON.parse(fs.readFileSync(envFile, 'utf8'));
  
  // Convert environment format if needed
  let formattedEnv = originalEnv;
  
  // If the format is already correct (has variables as object), use it directly
  // Otherwise, convert from array format to object format
  if (Array.isArray(originalEnv.variables)) {
    formattedEnv = {
      name: originalEnv.name || 'environment',
      variables: {}
    };
    
    originalEnv.variables.forEach(v => {
      if (v.active !== false) {
        formattedEnv.variables[v.key] = v.value;
      }
    });
  }
  
  // Write the temp environment file
  const tempEnvFile = path.resolve(__dirname, 'temp-env.json');
  fs.writeFileSync(tempEnvFile, JSON.stringify(formattedEnv, null, 2));
  
  console.log('Created temporary environment file with correct format');
  
  // Determine if we should generate JUnit report
  const generateJUnit = process.argv.includes('--junit');
  
  // Build the command
  let command = `hopp test ${collectionFile} -e ${tempEnvFile}`;
  
  if (generateJUnit) {
    command += ' --reporter-junit auth/test-results.xml';
  }
  
  // Run the command
  console.log(`Running: ${command}`);
  execSync(command, { stdio: 'inherit' });
  
  // Clean up
  fs.unlinkSync(tempEnvFile);
  console.log('Tests completed successfully');
  
  // Exit with success
  process.exit(0);
} catch (error) {
  console.error('Error running tests:', error.message);
  process.exit(1);
} 