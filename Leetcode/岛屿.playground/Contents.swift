import UIKit

var str = "Hello, playground"

class Solution{
    
    func infect(_ grid: inout [[Character]], i:Int, j:Int, n:Int, m:Int) -> [[Character]]{
        if i < 0 || i >= n || j < 0 || j >= m  || grid[i][j] != "1"{
            return grid;
        }
        
        grid[i][j] = "2"
        infect(&grid, i: i+1, j: j, n: n, m: m)
        infect(&grid, i: i-1, j: j, n: n, m: m)
        infect(&grid, i: i, j: j+1, n: n, m: m)
        infect(&grid, i: i, j: j-1, n: n, m: m)
        
        return grid
    }
    
    func numIslands(_ grid: inout [[Character]]) -> Int {
        if grid.isEmpty || grid[0].isEmpty{
            return 0
        }
        
        let n = grid.count
        let m = grid[0].count
        var res = 0
        
        // 深度优选搜索
        for i in 0...n{
            for j in 0...m{
                if grid[i][j] == "1" {
                    res += 1
                    grid = infect(&grid, i: i, j: j, n: n, m: m)
                }
            }
        }

        return res
    }
}

let so = Solution()
let charaters = [["1","1","1","1","0"],
                 ["1","1","1","1","0"],
                 ["1","1","1","1","0"],
                 ["1","1","1","1","0"]]
so.numIslands(&charaters)

