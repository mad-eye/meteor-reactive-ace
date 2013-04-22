if (Meteor.isClient) {
  Template.aceEditor.rendered = function(){
    var editor = ace.edit("aceEditor");
  }
}
