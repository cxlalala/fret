parser grammar CopilotParser;

options {
  tokenVocab = CopilotLexer;
}



listDef returns [ Copilot.Absyn.ListDef result ]
  :  /* empty */                                                           {} # ListDef_Empty
  | listDef def                                                            {} # ListDef_PrependFirst
  ;

def returns [ Copilot.Absyn.Def result ]
  : IDENT Surrogate_id_SYMB_0 stream                                       {} # MkDef
  ;
stream returns [ Copilot.Absyn.Stream result ]
  : Surrogate_id_SYMB_1 stream Surrogate_id_SYMB_2                         {} # Coercion_Stream
  | IDENT                                                                  {} # StreamIdent
  | Surrogate_id_SYMB_12 value                                             {} # ConstStream
  | Surrogate_id_SYMB_14 STRING sampleV                                    {} # ExternStream
  | valueList Surrogate_id_SYMB_3 stream                                   {} # StreamAppend
  | Surrogate_id_SYMB_13 VINT stream                                       {} # StreamDrop
  | OPOne stream                                                           {} # StreamOP
  | stream OPTwo stream                                                    {} # StreamOP
  | OPThree stream stream stream                                           {} # StreamOP
  | stream Surrogate_id_SYMB_4 IDENT                                       {} # StreamStruct
  ;
sampleV returns [ Copilot.Absyn.SampleV result ]
  : Surrogate_id_SYMB_10                                                   {} # SampleVNothing
  | Surrogate_id_SYMB_1 Surrogate_id_SYMB_9 valueList Surrogate_id_SYMB_2  {} # SampleVJust
  ;
valueList returns [ Copilot.Absyn.ValueList result ]
  : Surrogate_id_SYMB_5 listValue Surrogate_id_SYMB_6                      {} # MkValueList
  ;
listValue returns [ Copilot.Absyn.ListValue result ]
  : value                                                                  {} # ListValue_AppendLast
  | value Surrogate_id_SYMB_7 listValue                                    {} # ListValue_PrependFirst
  ;
value returns [ Copilot.Absyn.Value result ]
  : VBOOL                                                                  {} # ValueBool
  | VFLOAT                                                                 {} # ValueFloat
  | VINT                                                                   {} # ValueInt
  | Surrogate_id_SYMB_11 valueList                                         {} # ValueArray
  | IDENT listField                                                        {} # ValueUID
  ;

listField returns [ Copilot.Absyn.ListField result ]
  :  /* empty */                                                           {} # ListField_Empty
  | listField field                                                        {} # ListField_PrependFirst
  ;

field returns [ Copilot.Absyn.Field result ]
  : Surrogate_id_SYMB_1 Surrogate_id_SYMB_8 value Surrogate_id_SYMB_2      {} # MkField
  ;
