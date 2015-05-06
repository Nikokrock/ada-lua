ada-lua
=======

An Ada binding for lua

Example
-------

This Ada program shows how to execute a Lua script from Ada

~~~ada
--  The example show how to create a new lua state and launch a lua script

with Lua; use Lua;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

function Main return Integer is
   S      : constant Lua_State := New_State;
   --  Here we create a new state using New_State function

   Status : Lua_Return_Code;

begin
   Open_Libs (S);
   --  Load the lua "standard" libraries

   Ada.Text_IO.Put_Line ("Load script");
   Load_File (S, "../example1.lua");
   --  Load a script. Note that loading a script does not execute it. This
   --  includes toplevel code.

   Ada.Text_IO.Put_Line ("Execute script");
   Status := Lua.PCall (S);

   if Status /= LUA_OK then
      --  An error occurs during the execution
      Put_Line (Status'Img);
      Put_Line (To_Ada (S, -1));
      return 1;
   end if;

   return 0;
exception
   when E : Lua_Error =>
      Put_Line (Exception_Message (E));
      return 1;
end Main;
~~~
