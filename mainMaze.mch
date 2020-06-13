/* mainMaze
 * Author: Bilal Rifas
 * Creation date: 2019/11/27
 */

MACHINE
    mainMaze

SETS             
    DIRECTIONS = {North,South,East,West};
    RESPONSE={Yes,No,Boundry_Error,MazeWall_Error,Moved_Sucessfully,Cannot_Teleport_First}
    
    
CONSTANTS        
        startPos,mazeWalls,maze,xAxis,yAxis,endPos

PROPERTIES 
        xAxis <: NATURAL1 &
        yAxis <: NATURAL1 &
        xAxis={1,2,3,4,5,6,7} &
        yAxis={1,2,3,4,5} &

        
        startPos =(1|->1) &
        endPos = (1|->5) &
        maze : xAxis <-> yAxis &  
        maze = xAxis * yAxis &
        
        mazeWalls = {(2|->1),(6|->1),(4|->2),(6|->2),(1|->3),
            (2|->3),(3|->3),(4|->3),(4|->4),(6|->4),(7|->4),(2|->5)}  &
           
        mazeWalls <: maze &
        startPos : maze &
        endPos : maze 

END