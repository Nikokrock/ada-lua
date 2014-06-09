--  The example show how to create a new lua state and launch a lua script

with Lua; use Lua;
with Lua.Utils; use Lua.Utils;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

function Main return Integer is
   S      : constant Lua_State := New_State;
   --  Here we create a new state using New_State function

begin
   Open_Libs (S);
   --  Load the lua "standard" libraries

   Put_Line ("Load script");
   Load_File (S, "../example2.lua");
   --  Load a script. Note that loading a script does not execute it. This
   --  includes toplevel code.

   Put_Line ("Execute script");
   PCall (S);
   --  A first execution is needed (kind of elaboration)

   --  Call a function declared in the script that return a string
   Put_Line (Call_Function (S, "example2_fun"));
   return 0;

exception
   when E : Lua_Error =>
      Put_Line ("exception: " & Exception_Message (E));
      return 1;
end Main;
