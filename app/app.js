var express = require('express')
  , app = express.createServer();

app.configure(function(){
  app.use(express.static(__dirname));
});

app.listen(3000, function(){
  console.log(
    "Express server listening on port %d in %s mode",
    app.address().port,
    app.settings.env
  );
});
