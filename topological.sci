function order = topologicalSort(vertices, edges)
    inDegree = zeros(1, vertices); // Array to store in-degrees of all vertices
    adjList = cell(vertices, 1); // Adjacency list representation
    
    // Build adjacency list and calculate in-degrees
    for i = 1:size(edges, 1)
        u = edges(i, 1);
        v = edges(i, 2);
        adjList{u} = [adjList{u}, v];
        inDegree(v) = inDegree(v) + 1;
    end

    // Initialize a queue with all vertices having in-degree 0
    queue = [];
    for i = 1:vertices
        if inDegree(i) == 0 then
            queue = [queue, i];
        end
    end

    order = []; // To store the topological order
    while ~isempty(queue)
        u = queue(1); // Dequeue
        queue(1) = [];
        order = [order, u];
        for v = adjList{u}
            inDegree(v) = inDegree(v) - 1; // Reduce in-degree
            if inDegree(v) == 0 then
                queue = [queue, v]; // Add to queue if in-degree becomes 0
            end
        end
    end

    // Check if the graph contains a cycle
    if length(order) != vertices then
        error("Graph is not a DAG; topological sorting is not possible.");
    end
end

// Main Program
clc;
disp("Topological Sorting");

vertices = input("Enter the number of vertices: ");
edgesCount = input("Enter the number of edges: ");
edges = [];
disp("Enter edges (u, v): ");
for i = 1:edgesCount
    u = input("Enter source vertex: ");
    v = input("Enter destination vertex: ");
    edges = [edges; u, v];
end

order = topologicalSort(vertices, edges);
disp("Topological Order: " + string(order));
