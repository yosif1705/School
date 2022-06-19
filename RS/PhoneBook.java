package yosif;

import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

public class PhoneBook {
    private final List<Phone> phonesList;
    public List<Phone> getPhones(){
        return this.phonesList;
    }
    public PhoneBook(List<Phone> phones){
        phonesList = phones;
    }
    public boolean hasName(String name){
        for (Phone p: phonesList) {
            if (p.getName().equals(name.toUpperCase())){
                return true;
            }
        }
        return false;
    }
    public void add(Phone phone){
        phonesList.add(phone);
    }
    public void remove(String name){
        for (int i = 0; i < phonesList.size(); i++) {
            if (phonesList.get(i).getName().equals(name.toUpperCase())){
                phonesList.remove(i);
                return;
            }
        }
    }
    public String getNumberFromName(String name){
        for (Phone phone : phonesList) {
            if (phone.getName().equals(name.toUpperCase())) {
                return phone.getNumber();
            }
        }
        throw new NoSuchElementException("This name doesn't exist in this book.");
    }

    public void printAllPhonesSortedByNames(){
        List<Phone> sortedListOfPhones = phonesList;
        sortedListOfPhones.sort(Comparator.comparing(Phone::getName));
        for (Phone phone:sortedListOfPhones) {
            System.out.printf("Name %s / Number %s\n",phone.getName(),phone.getNumber());
        }
    }
    public void print(){
        for (Phone phone:phonesList) {
            System.out.printf("Name: %s / Number: %s\n",phone.getName(),phone.getNumber());
        }
    }
    static String attributeSeparator = "/";
    static String attributeValueSeparator = " ";
    private static List<List<String>> readFileAsListOfLists(File file) throws IOException {
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            return br.lines().map(line -> Arrays.asList(line.split(attributeSeparator))).collect(Collectors.toList());
        }
    }
    public static void savePhoneBookToFile(PhoneBook phoneBook, String fileSavePath) throws IOException {
        File file = new File(fileSavePath);
        List<Phone> phones = phoneBook.getPhones();
        BufferedWriter bw = new BufferedWriter(new FileWriter(file));

        for (Phone phone : phones) {
            String currLine =
                    "NAME" + attributeValueSeparator + phone.getName() + " " + attributeSeparator + " NUMBER" + attributeValueSeparator + phone.getNumber();
            bw.write(currLine);
            bw.newLine();
        }

        bw.close();
    }
    public static PhoneBook getPhoneBookFromFile(File file) throws IOException {
        List<List<String>> fileAsList = readFileAsListOfLists(file);
        List<Phone> phones = new ArrayList<>();
        for (List<String> strings : fileAsList) {
            phones.add(new Phone());
            for (String string : strings) {
                boolean isEntryValid = true;
                List<String> currAttribute = Arrays.asList(string.toUpperCase().trim().split(attributeValueSeparator));
                String attributeName = currAttribute.get(0);
                if (!attributeName.equals("NAME") && !attributeName.equals("NUMBER")) {
                    isEntryValid = false;
                }
                String value = "";
                for (int k = 1; k < currAttribute.size(); k++) {
                    if (!currAttribute.get(k).contains(attributeSeparator)) {
                        value += currAttribute.get(k);
                        if (k != currAttribute.size() - 1) {
                            value += " ";
                        }
                    } else {
                        break;
                    }
                }
                if (value.isBlank()) {
                    isEntryValid = false;
                }
                if (phones.size() > 0) {
                    if (isEntryValid) {
                        switch (attributeName) {
                            case "NAME" -> phones.get(phones.size() - 1).setName(value);
                            case "NUMBER" -> {
                                if (Phone.isValidNumber(value)) {
                                    phones.get(phones.size() - 1).setNumber(value);
                                } else {
                                    phones.remove(phones.size() - 1);
                                }
                            }
                        }
                    } else {
                        phones.remove(phones.size() - 1);
                    }
                }
            }
            if (phones.get(phones.size() - 1).getName().isBlank() || phones.get(phones.size() - 1).getNumber().isBlank()) {
                phones.remove(phones.size() - 1);
            }
        }
        return new PhoneBook(phones);
    }
}
