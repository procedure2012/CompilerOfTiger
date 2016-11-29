package Semant;

import Absyn.*;

public class Semant {
	Env env;
	public Semant(ErrorMsg.ErrorMsg err) {this(new Env(err));}
	Semant(Env e) {env = e;}

	ExpTy transVar(Var e) {}
	ExpTy transExp(Exp e) {}
	Exp transDec(Exp e) {}
	Ty transTy(Ty e) {}
}
