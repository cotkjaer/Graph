//
//  Graph.swift
//  Graph
//
//  Created by Christian Otkjær on 06/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import Foundation

open class Graph<Vertex: Hashable>
{
    typealias Edge = (neighbor: Vertex, weight: Int)
    
    fileprivate var edges = Dictionary<Vertex, Array<Edge>>()
    
    public init()
    {
        
    }
    
    public convenience init<S:Sequence>(vertices: S) where S.Iterator.Element == Vertex
    {
        self.init()
        
        vertices.forEach { add(vertex: $0) }
    }
    
    @discardableResult
    open func add(vertex: Vertex) -> Bool
    {
        guard edges[vertex] == nil else { return false }
        
        edges[vertex] = []
        
        return true
    }
    
    open func has(vertex: Vertex) -> Bool
    {
        return edges[vertex] != nil
    }
    
    func addEdgeWithWeight(_ weight: Int, fromVertex: Vertex, toVertex: Vertex)
    {
        add(vertex: fromVertex)
        add(vertex: toVertex)
        edges[fromVertex]?.append((toVertex, weight))
    }
    
    func edges(from vertex: Vertex) -> [Edge]
    {
        return edges[vertex] ?? []
    }
    
    func edges(from fromVertex: Vertex, to toVertex:Vertex) -> [Edge]
    {
        return (edges[fromVertex] ?? []).filter({ $0.neighbor == toVertex })
    }
    
    func neighborsTo(vertex: Vertex) -> [Vertex]
    {
        return edges(from: vertex).map({ $0.neighbor }).uniques()
    }
    
    var vertices : Array<Vertex>  { return Array(edges.keys) }
}

// MARK: -  CustomDebugStringConvertible, CustomStringConvertible

extension Graph : CustomDebugStringConvertible, CustomStringConvertible
{
    public var debugDescription : String
    {
        var d: String = ""
        
        for v in self.vertices
        {
            d += "\(v):\n"
            
            for e in edges(from: v)
            {
                d += "\(v) -\(e.weight)-> \(e.neighbor)\n"
            }
        }
        
        return d
    }
    
    public var description: String
    {
        return debugDescription
    }
}

// MARK: - Path

struct Path<Vertex>
{
    typealias Edge = (neighbor: Vertex, weight: Int)
    
    let total : Int
    let edges : [Edge]
    let origin : Vertex
    
    var destination: Vertex { return edges.last!.neighbor }
    
    fileprivate init(origin: Vertex, edge: Edge)
    {
        self.origin = origin
        total = edge.weight
        edges = [edge]
    }
    
    init(path: Path, edge: Edge)
    {
        origin = path.origin
        total = path.total + edge.weight
        edges = path.edges + [edge]
    }
}

// MARK: - CustomDebugStringConvertible

extension Path : CustomDebugStringConvertible, CustomStringConvertible
{
    var debugDescription : String
    {
        let edgeStrings = edges.map { " -\($0.weight)-> \($0.neighbor)" }
        
        let edgesString = edgeStrings.joined(separator: "")
        
        return "\(origin)\(edgesString)"
    }
    
    var description: String { return debugDescription }
}


// MARK: - Search

extension Graph
{
    /// Find a route from one vertex to another using a breadth first search
    ///
    /// - parameter from: The starting vertex.
    /// - parameter to: The destination vertex.
    /// - returns: The shortest path from origin to destination, if one could be found, nil otherwise
    func shortestPath(from origin: Vertex, to destination: Vertex) -> Path<Vertex>?
    {
        guard has(vertex: origin) else { return nil }
        
        guard has(vertex: destination) else { return nil }
        
        guard origin != destination else { return nil }
        
        var visited = [origin : true]
        
        var frontier: BinaryHeap<Path<Vertex>> = Heap(isOrderedBefore: {$0.total < $1.total})
        
        for edge in edges(from: origin)
        {
            frontier.push(Path(origin: origin, edge: edge))
        }
        
        while let shortestPath = frontier.pop()
        {
            if shortestPath.destination == destination { return shortestPath }
            
            visited[shortestPath.destination] = true
            
            for edge in edges(from : shortestPath.destination).filter({ visited[$0.neighbor] == nil })
            {
                frontier.push(Path(path: shortestPath, edge: edge))
            }
        }
        
        return nil
    }
}
