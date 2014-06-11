generic
   Name : String;
   type Ada_Type is private;
package Lua.Ada_Types is

   procedure Push (State : Lua_State; Data : Ada_Type);
   --  Push an Ada_Type value as a UserData Lua Type. Note that the type name
   --  is saved as a user data value in order to be able to perform type check
   --  when reimporting to ada.

   function To_Ada (State : Lua_State; Index : Lua_Index) return Ada_Type;
   --  Get an Ada_Type value from the stack. In case of type error
   --  Lua_Type_Error is raised

end Lua.Ada_Types;
