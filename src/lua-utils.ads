package Lua.Utils is

   function Call_Function (State : Lua_State; Name : String) return String;
   --  call a lua function that takes no parameter and return a string

   function Call_Function
     (State : Lua_State;
      Name  : String;
      Arg   : String)
      return String;
   --  call a lua function that takes a string as parameter and return a
   --  string
end Lua.Utils;
