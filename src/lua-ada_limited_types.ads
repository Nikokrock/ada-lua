--  Generic package that ease export and import to Lua of Ada limited types.
--  Note that because of limitation of limited types, the To_Ada function
--  returns an access to the value instead of the value itself.
--
--  One approach to import a value from Lua is to do the following
--
--  declare
--    Var : Ada_Type renames To_Ada (State, -1);
--  begin
--
--  Note also that internally we are using light user data. In that case no
--  user data can be associated with the Lua object, so we cannot perform any
--  type checks when importing from Lua.

generic
   type Ada_Type is limited private;
package Lua.Ada_Limited_Types is

   procedure Push (State : Lua_State; Data : access Ada_Type);
   --  Push an Ada_Type value as a LightUserData Lua Type.

   function To_Ada
     (State  : Lua_State;
      Index  : Lua_Index)
      return access Ada_Type;
   --  Get an Ada_Type value from the stack at position Index. No type check
   --  is performed.

   function New_Instance (State : Lua_State) return Integer;
   --  Function that can be registered in Lua to create new instance of
   --  Ada_Type
   pragma Convention (C, New_Instance);

end Lua.Ada_Limited_Types;
