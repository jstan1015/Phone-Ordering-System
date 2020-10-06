#include <iostream>
#include <iomanip>
#include <stdlib.h>
#include <stdio.h>    
#include <ctime>
#pragma warning(disable : 4996) 

using namespace std;


extern "C" {
	void asmcode();
	void login();
	void menu();
	void phone();
	void mod1();
	void mod2();
	void mod3();
	void mod4();
	void mod5();
	void receipt();

}

int main()
{
	asmcode();
	return 0;
}



void login()
{
	system("cls");
	printf("==========================================\n");
	printf("IPHONE POS SYSTEM\n");
	printf("==========================================\n");
	printf("Please login to continue >>\n");
}

void menu() {
	system("cls");
	printf("===================MENU =================\n");
	printf("Welcome to the user menu\n");
	printf("1) View Phone Type\n");
	printf("2) Make Order\n");
	printf("3) Log Out\n");
	printf("*) Exit Program\n\n");

}

void phone() {
	system("cls");
	printf("***********************\n");
	printf("Available Phone Model :\n");
	printf("***********************\n");
	printf("MODEL      NAME                 PRICE(MYR)\n");
	printf("*****  *********************    **********\n");
	printf("X001   iPhone X SILVER			3000   \n");
	printf("X002   iPhone X SPACE GREY		3050	\n");
	printf("XR001  iPhone XR RED		  	2500   \n");
	printf("XR002  iPhone XR YELLOW			2450   \n");
	printf("E001   iPhone 11 BLACK			3100   \n");

}

void mod1() {
	printf("\n");
	printf("==============Description===========\n");
	printf("Type	: IPHONE X\n");
	printf("Color	: Silver\n");
	printf("Price	: RM3000.00 (NOT INCLUDED TAX)\n");

}

void mod2() {
	printf("\n");
	printf("==============Description===========\n");
	printf("Type	: IPHONE X\n");
	printf("Color	: Space Gray\n");
	printf("Price	: RM3050.00 (NOT INCLUDED TAX)\n");

}

void mod3() {
	printf("\n");
	printf("==============Description===========\n");
	printf("Type	: IPHONE XR\n");
	printf("Color	: RED\n");
	printf("Price	: RM2500.00 (NOT INCLUDED TAX)\n");
}

void mod4() {
	printf("\n");
	printf("==============Description===========\n");
	printf("Type	: IPHONE XR\n");
	printf("Color	: YELLOW\n");
	printf("Price	: RM2450.00 (NOT INCLUDED TAX)\n");

}

void mod5() {
	printf("\n");
	printf("==============Description===========\n");
	printf("Type	: IPHONE 11\n");
	printf("Color	: BLACK\n");
	printf("Price	: RM3100.00 (NOT INCLUDED TAX)\n");

}

void receipt() {



	time_t t = time(NULL);
	struct tm tm = *localtime(&t);

	printf("\n================================================\n");
	printf("***********THANK YOU FOR PURCHASING*************\n");
	printf("================================================\n");
	printf("Date:	%d-%02d-%02d\n", tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
	printf("Time:	%02d:%02d:%02d\n\n", tm.tm_hour, tm.tm_min, tm.tm_sec);


}
