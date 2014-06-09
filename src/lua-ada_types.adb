package body Lua.Ada_Types is

   ------------
   -- To_Ada --
   ------------

   function To_Ada
     (State : Lua_State; Index : Lua_Index)
      return Ada_Type
   is

      User_Data : constant Lua_User_Data := To_Ada (State, Index);

   begin
      Get_User_Value (State, Index);
      if Get_Type (State, -1) /= LUA_TTABLE then
         raise Lua_Type_Error with "not an ada type";
      end if;

      Get_Field (State, -1, "ada_type");

      declare
         Ada_Type_Name : constant String := To_Ada (State, -1);
      begin
         if Ada_Type_Name /= Name then
            raise Lua_Type_Error
              with "expect type " & Name & " but found " & Ada_Type_Name;
         end if;
      end;

      Pop (State, 2);

      declare
         Result : Ada_Type;
         for Result'Address use System.Address (User_Data);
         pragma Import (C, Result);
      begin
         return Result;
      end;
   end To_Ada;

   ----------
   -- Push --
   ----------

   procedure Push (State : Lua_State; Data : Ada_Type)
   is
      Result_Addr : constant System.Address :=
                      New_User_Data (State, Data'Size);
      Result      : Ada_Type;
      pragma Import (C, Result);
      for Result'Address use Result_Addr;
   begin
      Result := Data;
      Create_Table (State);
      Push (State, Name);
      Set_Field (State, -2, "ada_type");
      Set_User_Value (State, -2);
   end Push;

end Lua.Ada_Types;
