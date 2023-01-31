/*
 * Copyright (C) Rida Bazzi, 2020
 *
 * Do not share this file with anyone
 *
 * Do not post this file or derivatives of
 * of this file online
 *
 */
#include <iostream>
#include <cstdlib>
#include "parser.h"

using namespace std;

void Parser::syntax_error()
{
    cout << "SYNTAX ERROR !!&%!!\n";
    exit(1);
}

// this function gets a token and checks if it is
// of the expected type. If it is, the token is
// returned, otherwise, synatx_error() is generated
// this function is particularly useful to match
// terminals in a right hand side of a rule.
// Written by Mohsen Zohrevandi
Token Parser::expect(TokenType expected_type)
{
    Token t = lexer.GetToken();

    // cout << "consuming token " << t.token_type << endl;

    if (t.token_type != expected_type)
        syntax_error();
    return t;
}

// Parsing

struct InstructionNode *Parser::parse_program()
{
    // cout << "parse_program" << endl;

    parse_var_section();

    struct InstructionNode *inst = parse_body();

    parse_inputs();

    expect(END_OF_FILE);

    return inst;
}

void Parser::parse_var_section()
{
    // cout << "varsec" << endl;
    parse_id_list();
    expect(SEMICOLON);
}

void Parser::parse_id_list()
{
    // cout << "idlist" << endl;
    Token t = expect(ID);

    varNames.push_back(t.lexeme);
    mem[next_available++] = 0;

    t = lexer.peek(1);

    if (t.token_type == COMMA)
    {
        expect(COMMA);
        parse_id_list();
    }
}

struct InstructionNode *Parser::parse_body()
{
    // cout << "parsebod" << endl;
    struct InstructionNode *inst1;

    expect(LBRACE);
    // cout << "lbrace" << endl;
    inst1 = parse_stmt_list();
    // cout << "got rbrace" << endl;
    expect(RBRACE);

    return inst1;
}

struct InstructionNode *Parser::parse_stmt_list()
{
    // cout << "stmtlis" << endl;
    struct InstructionNode *inst1;
    struct InstructionNode *instTemp;

    inst1 = parse_stmt();

    Token t = lexer.peek(1);

    if (t.token_type == FOR || t.token_type == WHILE || t.token_type == IF || t.token_type == SWITCH || t.token_type == INPUT || t.token_type == OUTPUT || t.token_type == ID) // page 10
    {
        struct InstructionNode *inst2;
        inst2 = parse_stmt_list();

        instTemp = inst1;

        while (instTemp->next != NULL)
        {
            // cout << "goign going gone" << endl;
            instTemp = instTemp->next;
        }

        instTemp->next = inst2;
    }

    return inst1;
}

struct InstructionNode *Parser::parse_stmt()
{
    struct InstructionNode *inst;

    Token t = lexer.peek(1);
    // cout << "stmt type : " << t.token_type<<endl;

    if (t.token_type == WHILE)
    {
        // cout << "stmt type : " << t.token_type<<endl;
        inst = parse_while_stmt();
    }
    else if (t.token_type == IF)
    {
        // cout << "stmt type : " << t.token_type<<endl;
        inst = parse_if_stmt();
    }
    else if (t.token_type == SWITCH)
    {
        // cout << "stmt type : " << t.token_type<<endl;
        inst = parse_switch_stmt();
    }
    else if (t.token_type == ID)
    {
        // cout << "stmt type : " << t.token_type<<endl;
        inst = parse_assign_stmt();
    }
    else if (t.token_type == INPUT)
    {
        // cout << "stmt type : " << t.token_type<<endl;
        inst = parse_input_stmt();
    }
    else if (t.token_type == OUTPUT)
    {
        // cout << "stmt type : " << t.token_type<<endl;
        inst = parse_output_stmt();
    }
    else if (t.token_type == FOR)
    {
        inst = parse_for_stmt();
    }

    return inst;
}

struct InstructionNode *Parser::parse_assign_stmt()
{
    // cout << "ass" << endl;
    struct InstructionNode *inst = new struct InstructionNode;
    inst->next = NULL;
    inst->type = ASSIGN;

    Token t = expect(ID);
    inst->assign_inst.left_hand_side_index = findVar(t.lexeme);

    expect(EQUAL);

    t = lexer.peek(2);

    if (t.token_type == PLUS || t.token_type == MINUS || t.token_type == MULT || t.token_type == DIV)
    {
        parse_expr(*inst);
    }
    else
    {
        inst->assign_inst.operand1_index = parse_prim();
        inst->assign_inst.op = OPERATOR_NONE;
    }

    expect(SEMICOLON);

    // cout << "ASSIGN" << inst->assign_inst.left_hand_side_index << " = " << mem[inst->assign_inst.operand1_index] << " " << inst->assign_inst.op << " " << mem[inst->assign_inst.operand2_index] << endl;

    return inst;
}

void Parser::parse_expr(struct InstructionNode &inst)
{
    // cout << "expr" << endl;
    inst.assign_inst.operand1_index = parse_prim();
    inst.assign_inst.op = parse_op();
    inst.assign_inst.operand2_index = parse_prim();
}

int Parser::parse_prim()
{
    // cout << "prim" << endl;
    Token t = lexer.peek(1);
    int result;

    if (t.token_type == ID)
    {
        // if(std::find(varNames.begin(), varNames.end(), t.lexeme) != varNames.end())
        // {
        //     varNames.push_back(t.lexeme);
        //     mem[next_available++] = 0;
        // }

        result = findVar(t.lexeme);

        expect(ID);
    }
    else
    {
        result = findConst(std::stoi(t.lexeme));

        if (std::stoi(t.lexeme) == 0)
            next_available++;

        // cout << " int value pls " << std::stoi(t.lexeme) << endl;
        // cout << " value is at " << result << endl;

        if (result == -1)
        {
            mem[next_available] = std::stoi(t.lexeme);
            result = next_available;
            next_available++;
        }

        expect(NUM);
    }

    return result;
}

ArithmeticOperatorType Parser::parse_op()
{
    // cout << "op" << endl;
    Token t = lexer.peek(1);

    if (t.token_type == PLUS)
    {
        expect(PLUS);
        return OPERATOR_PLUS;
    }
    else if (t.token_type == MINUS)
    {
        expect(MINUS);
        return OPERATOR_MINUS;
    }

    else if (t.token_type == MULT)
    {
        expect(MULT);
        return OPERATOR_MULT;
    }
    else if (t.token_type == DIV)
    {
        expect(DIV);
        return OPERATOR_DIV;
    }
}

struct InstructionNode *Parser::parse_output_stmt()
{
    // cout << "out" << endl;
    struct InstructionNode *inst = new struct InstructionNode;
    inst->next = NULL;
    inst->type = OUT;

    expect(OUTPUT);
    Token var = expect(ID);

    int index = findVar(var.lexeme);
    // printf("%d\t", mem[index]);

    inst->output_inst.var_index = index;

    expect(SEMICOLON);

    return inst;
}

struct InstructionNode *Parser::parse_input_stmt()
{
    // cout << "in" << endl;
    struct InstructionNode *inst = new struct InstructionNode;
    inst->next = NULL;
    inst->type = IN;

    expect(INPUT);
    Token var = expect(ID);

    inst->input_inst.var_index = findVar(var.lexeme);

    // inst->assign_inst.left_hand_side_index =

    // int index =
    //  mem[index] = 0;

    // mem[index] = -1;

    expect(SEMICOLON);

    return inst;
}

struct InstructionNode *Parser::parse_while_stmt()
{
    struct InstructionNode *inst;
    struct InstructionNode *instNoop = new struct InstructionNode;
    struct InstructionNode *instJmp = new struct InstructionNode;
    struct InstructionNode *instTemp;

    expect(WHILE);

    inst = parse_condition();
    inst->type = CJMP;
    inst->cjmp_inst.target = instNoop;
    inst->next = parse_body();

    instNoop->next = NULL;
    instNoop->type = NOOP;

    instTemp = inst;

    while (instTemp->next != NULL)
    {
        instTemp = instTemp->next;
    }

    instTemp->next = instJmp;

    instJmp->next = instNoop;
    instJmp->type = JMP;
    instJmp->jmp_inst.target = inst;

    return inst;
}

struct InstructionNode *Parser::parse_if_stmt()
{
    struct InstructionNode *inst;
    struct InstructionNode *instNoop = new struct InstructionNode;
    struct InstructionNode *instTemp;

    expect(IF);

    inst = parse_condition();
    inst->type = CJMP;
    inst->cjmp_inst.target = instNoop;
    inst->next = parse_body();
    // instTemp = parse_body;

    instTemp = inst;

    while (instTemp->next != NULL)
    {
        instTemp = instTemp->next;
    }

    instTemp->next = instNoop;

    instNoop->next = NULL;
    instNoop->type = NOOP;

    return inst;
}

struct InstructionNode *Parser::parse_condition()
{
    struct InstructionNode *inst = new struct InstructionNode;
    inst->next = NULL;

    inst->cjmp_inst.operand1_index = parse_prim();
    inst->cjmp_inst.condition_op = parse_relop();
    inst->cjmp_inst.operand2_index = parse_prim();

    return inst;
}

ConditionalOperatorType Parser::parse_relop()
{
    Token t = lexer.peek(1);

    if (t.token_type == GREATER)
    {
        expect(GREATER);
        return CONDITION_GREATER;
    }
    else if (t.token_type == LESS)
    {
        expect(LESS);
        return CONDITION_LESS;
    }
    else
    {
        expect(NOTEQUAL);
        return CONDITION_NOTEQUAL;
    }
}

struct InstructionNode* Parser::parse_switch_stmt()
{
    struct InstructionNode* inst;
    struct InstructionNode* instTemp1;
    struct InstructionNode* instTempBody;

    struct toBuild* basic;

    struct InstructionNode* instNoop = new struct InstructionNode;
    struct InstructionNode* instJmp = new struct InstructionNode;

    // instJmp->type = JMP;
    // instJmp->next = NULL;
    // instJmp->jmp_inst.target = instNoop;

    expect(SWITCH);
    string id = expect(ID).lexeme;
    int val = findVar(id);
    expect(LBRACE);

    instNoop->type = NOOP;
    instNoop->next = NULL;

    basic = parse_case_list();

    //prints()((((((((()))))))))

    // cout << "basic nodes " << endl;

    // do
    // {
    //     cout << basic->num << endl;
    //     basic = basic->next;
    // }while(basic != NULL);

    // cout << "done" << endl;

    //prints((((((((((()))))))))))

    inst = new struct InstructionNode;

    instTemp1 = inst;

    while(basic != NULL)
    {
        if(!basic->isDefault)
        {
            instJmp = new struct InstructionNode;
            instJmp->type = JMP;
            instJmp->next = NULL;
            instJmp->jmp_inst.target = instNoop;

            instTemp1->type = CJMP;
            instTemp1->cjmp_inst.operand1_index = val;
            instTemp1->cjmp_inst.operand2_index = basic->num;
            instTemp1->cjmp_inst.condition_op = CONDITION_NOTEQUAL;

            instTemp1->cjmp_inst.target = basic->body;

            instTempBody = instTemp1->cjmp_inst.target;

            while (instTempBody->next != NULL)
            {
                instTempBody = instTempBody->next;
            }

            instTempBody->next = instJmp;
        }
        else
        {
            instTemp1 = basic->body;
        }

        if(basic->next != NULL)
        {
            instTemp1->next = new struct InstructionNode;
            instTemp1 = instTemp1->next;
        }

        basic = basic->next;
    }

    instTemp1->next = instNoop;

    expect(RBRACE);

    return inst;

    //(((()I)(I)(())(())))
}

struct InstructionNode * Parser::parse_for_stmt()
{
    // cout << "for loop time" << endl;

    struct InstructionNode *inst;
    struct InstructionNode *assign1;
    struct InstructionNode *assign2 = new struct InstructionNode;
    struct InstructionNode *instNoop = new struct InstructionNode;
    struct InstructionNode *instJmp = new struct InstructionNode;
    struct InstructionNode *instTemp;

    expect(FOR);
    expect(LPAREN);

    assign1 = parse_assign_stmt();

    inst = parse_condition();
    inst->type = CJMP;
    inst->cjmp_inst.target = instNoop;

    assign1->next = inst;

    expect(SEMICOLON);

    assign2 = parse_assign_stmt();

    expect(RPAREN);

    inst->next = parse_body();

    instNoop->next = NULL;
    instNoop->type = NOOP;

    instTemp = inst;

    while (instTemp->next != NULL)
    {
        instTemp = instTemp->next;
    }

    instTemp->next = assign2;
    assign2->next = instJmp;

    instJmp->next = instNoop;
    instJmp->type = JMP;
    instJmp->jmp_inst.target = inst;

    return assign1;
}

struct toBuild* Parser::parse_case_list()
{
    struct toBuild* inst;
    struct toBuild* instTemp;
    
    inst = parse_case();

    Token t = lexer.peek(1);

    if (t.token_type == CASE)
    {
        struct toBuild * inst2;
        inst2 = parse_case_list();

        instTemp = inst;

        while (instTemp->next != NULL)
        {
            instTemp = instTemp->next;
        }

        instTemp->next = inst2;
    }
    else if(t.token_type == DEFAULT)
    {
        struct toBuild * inst2;
        inst2 = parse_def_case();

        instTemp = inst;

        while (instTemp->next != NULL)
        {
            instTemp = instTemp->next;
        }

        instTemp->next = inst2;
    }

    return inst;
}

struct toBuild* Parser::parse_case()
{
    struct toBuild* inst = new struct toBuild;
    //struct toBuild* instNoop = new struct toBuild;

    expect(CASE);
    Token var =  expect(NUM);
    expect(COLON);

    inst->body = parse_body();
    inst->num = findConst(stoi(var.lexeme));
    if(inst->num == -1)
    {
        mem[next_available] = stoi(var.lexeme);
        inst->num = next_available;
        next_available++;
    }
    inst->isDefault = false;
    inst->next = NULL;

    return inst;

    //this section was cut
    // inst->cjmp_inst.condition_op = CONDITION_NOTEQUAL;
    // inst->cjmp_inst.operand1_index = val;
    // inst->cjmp_inst.operand2_index = findConst(stoi(var.lexeme));
    // if(inst->cjmp_inst.operand2_index == -1)
    // {
    //     mem[next_available] = stoi(var.lexeme);
    //     inst->cjmp_inst.operand2_index = next_available;
    //     next_available++;
    // }
    // // cout << "var is " << inst->cjmp_inst.operand2_index << endl;

    // inst->type = CJMP;
    // inst->cjmp_inst.target = parse_body();
    // inst->next = NULL;    
    //this section was cut


    // inst->next = NULL;
    // while(var.token_type == CASE)
    // {
    //     expect (CASE);

    //     struct InstructionNode *inst;
    //     struct InstructionNode *instNoop = new struct InstructionNode;
    //     struct InstructionNode *instTemp;

    // //build condition
    //     //inst = 

    //     inst->cjmp_inst.operand1_index = stoi(var.lexeme);

    //     inst->cjmp_inst.condition_op = CONDITION_NOTEQUAL;
    //     inst->cjmp_inst.operand2_index = parse_prim();

    //     expect(COLON);
    //     inst->type = CJMP;
    //     inst->cjmp_inst.target = parse_body();
    //     inst->next = instNoop;
    //     // instTemp = parse_body;

    //     instTemp = inst;

    //     while (instTemp->next != NULL)
    //     {
    //         instTemp = instTemp->next;
    //     }

    //     instTemp->next = instNoop;

    //     instNoop->next = NULL;
    //     instNoop->type = NOOP;

    //     return inst;
    // }

    // inst = parse_condition();
    // inst->type = CJMP;
    // inst->cjmp_inst.target = instNoop;
    // inst->next = parse_body();
    // // instTemp = parse_body;

    // instTemp = inst;

    // while (instTemp->next != NULL)
    // {
    //     instTemp = instTemp->next;
    // }

    // instTemp->next = instNoop;

    // instNoop->next = NULL;
    // instNoop->type = NOOP;


}

struct toBuild*  Parser::parse_def_case()
{
    struct toBuild * inst = new struct toBuild;
    expect(DEFAULT);
    expect(COLON);
    inst->body = parse_body();
    inst->isDefault = true;
    inst->num = -1;
    inst->next = NULL;

    return inst;
}

void Parser::parse_inputs()
{
    parse_num_list();
}

void Parser::parse_num_list()
{
    // cout << "numlists" << endl;

    Token num = expect(NUM);

    inputs.push_back(stoi(num.lexeme));

    Token t = lexer.peek(1);

    if (t.token_type == NUM)
        parse_num_list();
}

// int main()
// {
// 	// note: the parser class has a lexer object instantiated in it. You should not be declaring
//     // a separate lexer object. You can access the lexer object in the parser functions as shown in the
//     // example method Parser::ConsumeAllInput
//     // If you declare another lexer object, lexical analysis will not work correctly
//     Parser parser;

// 	parser.parse_input();
// }


int findConst(int search)
{
    for (int i = varNames.size(); i < 1000; i++)
    {
        if (search == mem[i])
            return i;
    }

    return -1;
}

int findVar(string &search)
{
    for (int i = 0; i < varNames.size(); i++)
    {
        if (search == varNames[i])
        {
            return i;
        }
    }

    return -1;
}



struct InstructionNode *parse_generate_intermediate_representation()
{
    // cout << "inter" << endl;
    next_available = 0;

    Parser *parser = new Parser;
    struct InstructionNode *inst = parser->parse_program();

    // cout << "inst->type" << endl;

    // do
    // {
    //     cout << inst->type << endl;
    //     inst = inst->next;
    // }while(inst != NULL);

    // cout << "done" << endl;

    return inst;
}