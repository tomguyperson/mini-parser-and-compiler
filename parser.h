/*
 * Copyright (C) Rida Bazzi, 2019
 *
 * Do not share this file with anyone
 */
#ifndef __PARSER_H__
#define __PARSER_H__

#include <string>
#include "lexer.h"
#include "compiler.h"
#include <map>

using namespace std;

std::vector<string> varNames;
std::vector<int> values;

int findConst(int search);

int findVar(string& search);

struct toBuild
{
	bool isDefault;
	int num;
	struct InstructionNode* body;
	toBuild* next;
};

class Parser
{
	public:
		void ConsumeAllInput();
		void parse_input();
		struct InstructionNode* parse_program();

	private:
		LexicalAnalyzer lexer;
		void syntax_error();
		Token expect(TokenType expected_type);

		void parse_var_section();
		void parse_id_list();
		struct InstructionNode* parse_body();
		struct InstructionNode* parse_stmt_list();
		struct InstructionNode* parse_stmt();
		struct InstructionNode* parse_assign_stmt();
		void parse_expr(struct InstructionNode& inst);
		int parse_prim();
		ArithmeticOperatorType parse_op();
		struct InstructionNode* parse_output_stmt();
		struct InstructionNode* parse_input_stmt();
		struct InstructionNode* parse_while_stmt();
		struct InstructionNode* parse_if_stmt();
		struct InstructionNode* parse_condition();
		ConditionalOperatorType parse_relop();
		struct InstructionNode* parse_switch_stmt();
		struct InstructionNode* parse_for_stmt();
		struct toBuild * parse_case_list();
		struct toBuild * parse_case();
		struct toBuild *  parse_def_case();
		void parse_inputs();
		void parse_num_list();
};

#endif
