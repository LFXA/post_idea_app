class QueryMutation {
  String insertOnePost(String id, String name, String lastName, int age) {
    return """
      mutation{
          insertOnePost(data:{ content: "$name", excerpt: "$lastName", category: $age}){
            id
            name
            lastName
            age
          }
      }
    """;
  }

  String getAll(){
    return """
     {        
         posts{ 
           _id 
           title
           path
           lang
           image 
           created 
           image_caption        
           author 
           excerpt
           category
           tags
           content}
      }
    """;
  }

  String getNotInID(List id){
    return """
     {
         posts(query: {_id_nin: ${id}}){
           _id
           title
           path
           lang
           image
           created
           image_caption
           author
           excerpt
           category
           tags
           content}
      }
    """;
  }


  String deletePerson(id){
    return """
      mutation{
        deletePerson(id: "$id"){
          id
        }
      }
    """;
  }


  String editPerson(String id, String name, String lastName, int age){
    return """
      mutation{
          editPerson(id: "$id", name: "$name", lastName: "$lastName", age: $age){
            name
            lastName
          }
      }
     """;
  }
}