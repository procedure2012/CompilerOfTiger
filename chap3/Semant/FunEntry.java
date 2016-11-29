package Semant;

class FunEnrty extends Entry {
	Types.RECORD formals;
	Types.Type result;
	public FunEnrty(Types.RECORD f, Types.Type r) {formals = f; result = r;}
}
