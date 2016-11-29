package Semant;

import Symbol.Table, Symbol.Symbol;

class Env {
	Table vEnv;
	Table tEnv;
	ErrorMsg.ErrorMsg errorMsg;

	Env(ErrorMsg.ErrorMsg err) {
		errorMsg = err;

		tEnv = new Table();
		tEnv.put(Symbol.symbol("int"),new Types.INT());
		tEnv.put(Symbol.symbol("string"), new Types.STRING());

		vEnv = new Table();
		Types.RECORD formals = null;
		Types.Type result = null;
		
		formals = new Types.RECORD(Symbol.symbol("s"), (Types.Type) tEnv.get(Symbol.symbol("string")), null);
		result = new Types.VOID();
		vEnv.put(Symbol.symbol("print"), new FunEntry(formals, result));
		vEnv.beginScope();
		vEnv.put(Symbol.symbol("s"), new VarEntry((Types.Type) tEnv.get(Symbol.symbol("string"))));
		vEnv.endScope();

		formals = new Type.RECORD(Symbol.symbol("i"), (Types.Type) tEnv.get(Symbol.symbol("int")), null);
		result = new Types.VOID();
		vEnv.put(Symbol.symbol("printi"), new FunEntry(formals, result));
		vEnv.beginScope();
		vEnv.put(Symbol.symbol("i"), new VarEntry((Types.Type) tEnv.get(Symbol.symbol("int"))));
		vEnv.endScope();
		
		formals = null;
		result = new Types.VOID();
		vEnv.put(Symbol.symbol("flush"), new FunEntry(formals, result));

		formals = null;
		result = new Types.STRING();
		vEnv.put(Symbol.symbol("getchar"), new FunEntry(formals, result));

		formals = new Types.RECORD(Symbol.symbol("s"), (Types.Type) tEnv.get(Symbol.symbol("string")), null);
		result = new Types.INT();
		vEnv.put(Symbol.symbol("ord"), new FunEntry(formals, result));
		vEnv.beginScope();
		vEnv.put(Symbol.symbol("s"), new VarEntry((Types.Type) tEnv.get(Symbol.symbol("string"))));
		vEnv.endScope();

		formals = new Types.RECORD(Symbol.symbol("i"), (Types.Type) tEnv.get(Symbol.symbol("int")), null);
		result = new Types.STRING();
		vEnv.put(Symbol.symbol("chr"), new FunEntry(formals, result));
		vEnv.beginScope();
		vEnv.put(Symbol.symbol("i"),  new VarEntry((Types.Type) tEnv.get(Symbol.symbol("int"))));
		vEnv.endScope();

		formals = new Types.RECORD(Symbol.symbol("s"), (Types.Type) tEnv.get(Symbol.symbol("string")), null);
		result = new Types.INT();
		vEnv.put(Symbol.symbol("size"), new FunEntry(formals, result));
		vEnv.beginScope();
		vEnv.put(Symbol.symbol("s"), new VarEntry((Types.Type) tEnv.get(Symbol.symbol("string"))));
		vEnv.endScope();

		formals = new Types.RECORD(Symbol.symbol("n"), (Types.Type) tEnv(Symbol.symbol("int")), null);
		formals.tail = new Types.RECORD(Symbol.symbol("f"), (Types.Type) tEnv(Symbol.symbol("int")), null);
		formals.tail.tail = new Types.RECORD(Symbol.symbol("s"), (Types.Type) tEnv(Symbol.symbol("string")), null)
		result = new Types.STRING();
		vEnv.put(Symbol.symbol("substring"), new FunEntry(formals, result));
		vEnv.beginScope();
		vEnv.put(Symbol.symbol("n"), new VarEntry((Types.Type) tEnv.get(Symbol.symbol("int"))));
		vEnv.put(Symbol.symbol("f"), new VarEntry((Types.Type) tEnv.get(Symbol.symbol("int"))));
		vEnv.put(Symbol.symbol("s"), new VarEntry((Types.Type) tEnv.get(Symbol.symbol("string"))));
		vEnv.endScope();
		
		formals = new Types.RECORD(Symbol.symbol("s2"), (Types.Type) tEnv.get(Symbol.symbol("string")), null);
		formals.tail = new Type.RECORD(Symbol.symbol("s1"), (Types.Type) tEnv.get(Symbol.symbol("string")), null);
		resutl = new Types.STRING();
		vEnv.put(Symbol.symbol("concat"), new FunEntry(formals, result));
		vEnv.beginScope();
		vEnv.put(Symbol.symbol("s2"), new VarEntry((Types.Type) tEnv.get(Symbol.symbol("string"))));
		vEnv.put(Symbol.symbol("s1"), new VarEntry((Types.Type) tEnv.get(Symbol.symbol("string"))));
		vEnv.endScope();

		formals = new Types.RECORD(Symbol.symbol("i"), (Types.Type) tEnv.get(Symbol.symbol("int")), null);
		result = new Types.INT();
		vEnv.put(Symbol.symbol("not"), new FunEntry(formals, result));
		vEnv.beginScope();
		vEnv.put(Symbol.symbol("i"), new VarEntry((Types.Type) tEnv(Symbol.symbol("int"))));
		vEnv.endScope();

		formals = new Types.RECORD(Symbol.symbol("i"), (Types.Type) tEnv.get(Symbol.symbol("int")), null);
		result = new Types.VOID();
		vEnv.put(Symbol.symbol("exit"), new FunEntry(formals, result));
		vEnv.beginScope();
		vEnv.put(Symbol.symbol("i"), new VarEntry((Types.Type) tEnv.get(Symbol.symbol("int"))));
		vEnv.endScope();
	}
}
