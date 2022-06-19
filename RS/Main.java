package yosif;

import java.io.File;
import java.util.Scanner;

public class Main {
    public static void getHelp(){
        System.out.println("""
                Available commands:
                     ADD (Adds a new phone to the phonebook)
                     REMOVE (Removes a phone from the phonebook)
                     GETNUMBER (Returns a phone number for given name)
                     PRINT (Returns all phones)
                     PRINTSORTED (Returns all phones sorted alphabetically)
                     RELOAD (Reloads the phonebook from the file)
                     SAVE (Saves the phonebook to the file)
                     HELP (Returns all possible commands)
                     END (TERMINATES THE PROGRAM)""");
    }
    public static void main(String[] args) throws Exception {
        PhoneBook phoneBook;
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter the absolute file path of the txt file that contains the phonebook: ");
        String filePath = sc.nextLine();
        phoneBook = PhoneBook.getPhoneBookFromFile(new File(filePath));
        System.out.println("The phonebook was successfully loaded!");
        System.out.println();
        getHelp();
        System.out.println();

        System.out.print("Enter a command: ");
        String command = sc.nextLine().toUpperCase().trim();
        while (!command.equals("END")){
            switch (command){
                case "ADD" -> {
                    System.out.print("Enter the name of the person: ");
                    String name = sc.nextLine().toUpperCase();
                    System.out.printf("Enter %s's number: ", name);
                    String number = sc.nextLine();
                    if(Phone.isValidNumber(number)){
                        phoneBook.add(new Phone(name,number));
                        System.out.printf("\n%s was successfully added!\n",name);
                    }else{
                        System.out.print("\nERROR! Invalid number.\n");
                    }
                }

                case "REMOVE" -> {
                    System.out.print("Enter the name of the person you want to remove: ");
                    String name = sc.nextLine().toUpperCase();
                    if (phoneBook.hasName(name)){
                        phoneBook.remove(name);
                        System.out.printf("\n%s was successfully removed!\n",name);
                    }else{
                        System.out.print("\nERROR! This name doesn't exist in this phonebook.\n");
                    }
                }

                case "GETNUMBER" -> {
                    System.out.print("Enter the name of the person's phone: ");
                    String name = sc.nextLine().toUpperCase();
                    if (phoneBook.hasName(name)){
                        System.out.printf("\n%s's number is: %s\n",name,phoneBook.getNumberFromName(name));
                    }else{
                        System.out.print("\nERROR! This name doesn't exist in this phonebook.\n");
                    }
                }

                case "PRINT" ->{
                    System.out.println();
                    phoneBook.print();
                }

                case "PRINTSORTED" ->{
                    System.out.println();
                    phoneBook.printAllPhonesSortedByNames();
                }

                case "SAVE" -> {
                    PhoneBook.savePhoneBookToFile(phoneBook,filePath);
                    System.out.printf("\nPhonebook was successfully saved to %s\n",filePath);
                }

                case "RELOAD" -> {
                    phoneBook = PhoneBook.getPhoneBookFromFile(new File(filePath));
                    System.out.print("\nPhonebook successfully loaded from the file\n");
                }

                case "HELP" -> {
                    System.out.println();
                    getHelp();
                }
                default -> System.out.print("\nINVALID COMMAND! Please enter HELP to get a list of valid commands.\n");
            }
            System.out.print("\nEnter a command: ");
            command = sc.nextLine().toUpperCase().trim();
        }
    }
}