if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });
}

if (Meteor.isClient){
  Template.demo.helpers({
    lineNumber: function(){
      console.log("fetching line number");
      if (typeof editor !== "undefined" && typeof editor !== null)
        return editor.lineNumber;
      else
        return undefined
    }
  });
}

