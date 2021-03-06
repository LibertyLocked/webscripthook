﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GTA;
using GTA.Math;
using GTA.Native;
using Newtonsoft.Json;

namespace WebScriptHook
{
    delegate object WebFunction(string arg, params object[] args);

    class WebInput
    {
        public string Cmd { get; set; } 
        public string Arg { get; set; }
        public object[] Args { get; set; }
        public string UID { get; private set; }

        [JsonConstructor]
        public WebInput(string Cmd, string Arg, object[] Args, string UID)
        {
            this.Cmd = Cmd;
            this.Arg = Arg;
            this.Args = Args;
            this.UID = UID;
        }

        public object Execute()
        {
            if (string.IsNullOrEmpty(Cmd)) return null;

            WebFunction func = FunctionConvert.GetFunction(Cmd);
            if (func != null)
            {
                return func(Arg, Args);
            }
            else
            {
                return null;
            }
        }
    }
}
