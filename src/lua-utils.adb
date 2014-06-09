package body Lua.Utils is

   -------------------
   -- Call_Function --
   -------------------

   function Call_Function (State : Lua_State; Name : String) return String
   is
   begin
      Get_Global (State, Name);
      PCall (State, 0, 1);

      declare
         Result : constant String := To_Ada (State, -1);
      begin
         Pop (State);
         return Result;
      end;
   end Call_Function;

   function Call_Function
     (State : Lua_State;
      Name  : String;
      Arg   : String)
      return String
   is
   begin
      Get_Global (State, Name);
      Push (State, Arg);
      PCall (State, 1, 1);

      declare
         Result : constant String := To_Ada (State, -1);
      begin
         Pop (State);
         return Result;
      end;
   end Call_Function;

end Lua.Utils;
