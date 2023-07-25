const mkdirp = require('mkdirp');
const fs = require('fs');

mkdirp('./public',  (err) => {
  if (err) {
    console.error(err);
    throw (error)
  }
  
  let content = fs.readFileSync('web/index.html').toString();
  content = content.replace('Anonymous', process.env.USERNAME || 'Nobody')

  fs.writeFileSync('public/index.html', content);

})

