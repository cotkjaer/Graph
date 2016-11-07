//
//  GraphTests.swift
//  GraphTests
//
//  Created by Christian Otkjær on 06/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import XCTest
@testable import Graph

class GraphTests: XCTestCase
{
    
    func test_init_Graph()
    {
        let _ = Graph<String>()
        let _ = Graph<Int>()
        let f = Graph<Float>()
        
        XCTAssertEqual(f.vertices.count, 0)
        
        let g = Graph(vertices: [2, 3, 4, 5, 6, 2, 34, 5])
        
        XCTAssertEqual(g.vertices.count, 6)
    }
    
    func test_addVertex()
    {
        let g = Graph(vertices: ["A", "B", "C", "D"])
        
        XCTAssertEqual(g.vertices.count, 4)
        
        XCTAssert(g.add(vertex: "E"))
        
        XCTAssertEqual(g.vertices.count, 5)
        
        XCTAssertFalse(g.add(vertex: "E"))
        
        XCTAssertEqual(g.vertices.count, 5)
    }
    
    /*
     func test_addEdges()
     {
     let g = Graph(vertices: ["A", "B", "C", "D", "E"])
     
     g.addEdgeWithWeight(1, fromVertex: "A", toVertex: "B")
     g.addEdgeWithWeight(4, fromVertex: "A", toVertex: "D")
     g.addEdgeWithWeight(5, fromVertex: "B", toVertex: "D")
     g.addEdgeWithWeight(2, fromVertex: "B", toVertex: "C")
     g.addEdgeWithWeight(8, fromVertex: "D", toVertex: "E")
     
     XCTAssertEqual(g.edgesForVertex("A").count, 2)
     XCTAssertEqual(g.edgesForVertex("B").count, 2)
     XCTAssertEqual(g.edgesForVertex("C").count, 0)
     XCTAssertEqual(g.edgesForVertex("D").count, 1)
     XCTAssertEqual(g.edgesForVertex("E").count, 0)
     
     }
     
     func test_paths()
     {
     let g = Graph(vertices: ["A", "B", "C", "D", "E"])
     
     g.addEdgeWithWeight(1, fromVertex: "A", toVertex: "B")
     g.addEdgeWithWeight(4, fromVertex: "A", toVertex: "D")
     g.addEdgeWithWeight(5, fromVertex: "B", toVertex: "D")
     g.addEdgeWithWeight(2, fromVertex: "B", toVertex: "C")
     g.addEdgeWithWeight(8, fromVertex: "D", toVertex: "E")
     
     var p = g.bfs(from: "A", to: "C")
     
     XCTAssertNotNil(p)
     
     XCTAssertEqual(p?.total, 3)
     
     // Add more expensive routes
     g.addEdgeWithWeight(4, fromVertex: "A", toVertex: "C")
     g.addEdgeWithWeight(3, fromVertex: "B", toVertex: "C")
     
     p = g.bfs(from: "A", to: "C")
     
     XCTAssertNotNil(p)
     
     XCTAssertEqual(p?.total, 3)
     
     // Add less expensive routes
     g.addEdgeWithWeight(1, fromVertex: "A", toVertex: "D")
     g.addEdgeWithWeight(1, fromVertex: "D", toVertex: "C")
     
     p = g.bfs(from: "A", to: "C")
     
     XCTAssertNotNil(p)
     
     XCTAssertEqual(p?.total, 2)
     
     
     p = g.bfs(from: "A", to: "E")
     
     XCTAssertNotNil(p)
     
     XCTAssertEqual(p?.total, 12)
     
     //Add cycles
     g.addEdgeWithWeight(1, fromVertex: "D", toVertex: "A")
     g.addEdgeWithWeight(1, fromVertex: "A", toVertex: "A")
     g.addEdgeWithWeight(1, fromVertex: "B", toVertex: "A")
     
     p = g.bfs(from: "A", to: "E")
     
     XCTAssertNotNil(p)
     
     XCTAssertEqual(p?.total, 12)
     
     }
     */
    
}
