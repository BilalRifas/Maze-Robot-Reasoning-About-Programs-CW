/* robot
 * Author: Bilal Rifas
 * Creation date: 2019/11/27
 */

MACHINE
    robot
    
USES mainMaze
            
VARIABLES         
         pointing,currentPosition,positionSeq,visitedPositions

INVARIANT         
    pointing : DIRECTIONS &
    currentPosition : maze &
    visitedPositions <: maze &
    positionSeq : seq( maze )

INITIALISATION    
    pointing,currentPosition,positionSeq,visitedPositions := North,startPos,[startPos],{}
    
OPERATIONS
message <-- MoveNorth (position) = 
    PRE position : maze & position /= currentPosition & message : RESPONSE & prj1(xAxis,yAxis)(position)=prj1(xAxis,yAxis)(currentPosition)
        & prj2(xAxis,yAxis)(position)=prj2(xAxis,yAxis)(currentPosition)+1
    THEN
        IF(position /: mazeWalls )
        THEN
            currentPosition := position ||
            visitedPositions := visitedPositions \/ {first(positionSeq)} || 
            positionSeq := position -> positionSeq ||
            pointing := North ||
            
            message := Moved_Sucessfully
        ELSIF (prj2(xAxis,yAxis)(currentPosition) > 5)
        THEN
            message := Boundry_Error
        ELSE
            message := MazeWall_Error
        END
            
    END;   

message <-- MoveSouth (position) = 
    PRE position : maze & position /= currentPosition & message : RESPONSE & prj1(xAxis,yAxis)(position)=prj1(xAxis,yAxis)(currentPosition)
        & prj2(xAxis,yAxis)(position)=prj2(xAxis,yAxis)(currentPosition)-1
    THEN
        IF(position /: mazeWalls )
        THEN 
            currentPosition := position ||
            visitedPositions := visitedPositions \/ {first(positionSeq)} || 
            positionSeq := position -> positionSeq ||
            pointing := South ||                            
            message := Moved_Sucessfully
        ELSIF (prj2(xAxis,yAxis)(currentPosition) <= 0)
        THEN
            message := Boundry_Error
        ELSE
            message := MazeWall_Error
        END
            
    END;
    
message <-- MoveEast (position) = 
    PRE position : maze & position /= currentPosition & message : RESPONSE & prj1(xAxis,yAxis)(position)=prj1(xAxis,yAxis)(currentPosition)+1
        & prj2(xAxis,yAxis)(position)=prj2(xAxis,yAxis)(currentPosition)
    THEN
        IF(position /: mazeWalls )
        THEN
            currentPosition := position ||
            visitedPositions := visitedPositions \/ {first(positionSeq)} || 
            positionSeq := position -> positionSeq ||
            pointing := East ||
            message := Moved_Sucessfully
            
        ELSIF (prj2(xAxis,yAxis)(currentPosition) > 7)
        THEN
            message := Boundry_Error
        ELSE
            message := MazeWall_Error
        END
            
    END;
    
message <-- MoveWest (position) = 
    PRE position : maze & position /= currentPosition & message : RESPONSE & prj1(xAxis,yAxis)(position)=prj1(xAxis,yAxis)(currentPosition)-1
        & prj2(xAxis,yAxis)(position)=prj2(xAxis,yAxis)(currentPosition) 
    THEN
        IF(position /: mazeWalls )
        THEN
            currentPosition := position ||
            visitedPositions := visitedPositions \/ {first(positionSeq)} ||
            positionSeq := position -> positionSeq ||
            pointing := West ||
            message := Moved_Sucessfully
        ELSIF (prj2(xAxis,yAxis)(currentPosition) <= 0)
        THEN
            message := Boundry_Error
        ELSE
            message := MazeWall_Error
        END
            
    END;

message <-- Teleport(position) =
    PRE 
        position : maze & position /= currentPosition & message : RESPONSE
    THEN
        IF(position /: mazeWalls & size(visitedPositions) >0)
        THEN
            currentPosition := position ||
            visitedPositions := visitedPositions \/ {first(positionSeq)} ||
            positionSeq := position -> positionSeq ||
            pointing := West ||
            message:= Moved_Sucessfully
        ELSIF (prj1(xAxis,yAxis)(currentPosition) > 7 & prj1(xAxis,yAxis)(currentPosition) < 0 & 
                prj2(xAxis,yAxis)(currentPosition) > 5 & prj2(xAxis,yAxis)(currentPosition) < 0)
        THEN
            message := Boundry_Error
        ELSIF (size(visitedPositions) <=0 )
        THEN
            message := Cannot_Teleport_First
        ELSE
            message := MazeWall_Error
        END
    END;

message <-- FoundExit =
    PRE 
        currentPosition : maze & currentPosition /: mazeWalls
    THEN
        IF(currentPosition = endPos)
        THEN
            message:=Yes
        ELSE
            message:=No
        END
    END;
     
message <-- GetPosition=
    PRE
        currentPosition : maze & currentPosition /: mazeWalls
    THEN
        message:=currentPosition
    END;

message <-- VisitedSquare(position) =
    PRE
        position : maze & position /: mazeWalls
    THEN
        IF(position : visitedPositions)
        THEN
            message:=Yes
        ELSE
            message:=No
        END
    END;

message <-- RobotsRoute =
PRE
    size(positionSeq) /= 0
THEN
    message:=rev(positionSeq)
END
   
END