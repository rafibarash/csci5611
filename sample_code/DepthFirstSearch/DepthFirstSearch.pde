//Graph Search - Depth-First Search (DFS)
//CSCI 5611 Search Sample Code
// Stephen J. Guy <sjguy@umn.edu>


//Initalize our graph 
int numNodes = 8;

//Reperersent our graph structure as 3 lists
ArrayList<Integer>[] neighbors = new ArrayList[numNodes];  //A list of neighbors can can be reached from a given node
Boolean[] visited = new Boolean[numNodes]; //A list which store if a given node has been visited
int[] parent = new int[numNodes]; //A list which stores the best previous node on the optimal path to reach this node
  
// Initalize the lists which represent our graph 
for (int i = 0; i < numNodes; i++) { 
    neighbors[i] = new ArrayList<Integer>(); 
    visited[i] = false;
    parent[i] = -1; //No partent yet
}

//Set which nodes are connected to which neighbors
neighbors[0].add(1); neighbors[0].add(2); //0 -> 1 or 2
neighbors[1].add(3); neighbors[1].add(4); //1 -> 3 or 4 
neighbors[2].add(5); neighbors[2].add(6); //2 -> 5 or 6
neighbors[4].add(7);                      //4 -> 7

println("List of Neghbors:");
println(neighbors);

//Set start and goal
int start = 0;
int goal = 7;

ArrayList<Integer> fringe = new ArrayList(); 

println("\nBeginning Search");

visited[start] = true;
fringe.add(start);
println("Adding node", start, "(start) to the fringe.");
println(" Current Fring: ", fringe);

while (fringe.size() > 0){
  int currentNode = fringe.get(0);
  fringe.remove(0);
  if (currentNode == goal){
    println("Goal found!");
    break;
  }
  for (int i = 0; i < neighbors[currentNode].size(); i++){
    int neighborNode = neighbors[currentNode].get(i);
    if (!visited[neighborNode]){
      visited[neighborNode] = true;
      parent[neighborNode] = currentNode;
      fringe.add(neighborNode);
      println("Added node", neighborNode, "to the fringe.");
      println(" Current Fringe: ", fringe);
    }
  } 
}

print("\nReverse path: ");
int prevNode = parent[goal];
print(goal, " ");
while (prevNode >= 0){
  print(prevNode," ");
  prevNode = parent[prevNode];
}
print("\n");
