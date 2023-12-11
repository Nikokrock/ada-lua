with System.Address_To_Access_Conversions;

package body Lua.Ada_Limited_Types is

   package Conv is new System.Address_To_Access_Conversions (Ada_Type);

   ------------------
   -- New_Instance --
   ------------------

   function New_Instance (State : Lua_State) return Integer is
      Arg_Num : constant Lua_Index := Get_Top (State);
      Result  : constant access Ada_Type := new Ada_Type;
   begin
      if Arg_Num /= 0 then
         Push (State, "no argument expected");
         return Error (State);
      end if;

      Push (State, Result);
      return 1;
   end New_Instance;

   ----------
   -- Push --
   ----------

   procedure Push (State : Lua_State; Data : access Ada_Type) is
   begin
      Push (State, Lua_Light_User_Data (Data.all'Address));
   end Push;

   ------------
   -- To_Ada --
   ------------

   function To_Ada
     (State  : Lua_State;
      Index  : Lua_Index)
      return access Ada_Type
   is
      User_Data : constant Lua_User_Data := To_Ada (State, Index);
      Result    : constant access Ada_Type :=
                    Conv.To_Pointer (System.Address (User_Data));

   begin
      return Result;
   end To_Ada;

end Lua.Ada_Limited_Types;
