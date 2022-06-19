package yosif;

public class Phone {
    private String name;
    private String number;

    public static String getNormalizedNumber(String number){
        if(number.startsWith("00")){
            number="+"+number.substring(2);
        }else if(number.charAt(0)=='0'){
            number="+359"+number.substring(1);
        }

        return number;
    }
    public static boolean isValidNumber(String number){
        number = getNormalizedNumber(number);

        final int numLength = 13;

        if(number.length() != numLength){
            return false;
        }

        if(!number.startsWith("+359")){
            return false;
        }

        if(!number.startsWith("87", 4) && !number.startsWith("88", 4) && !number.startsWith("89", 4)){
            return false;
        }

        if(!(number.charAt(6)>='2' && number.charAt(6)<='9')){
            return false;
        }

        for(int i=7 ; i<numLength ; i++){
            if(!(number.charAt(i)>='0' && number.charAt(i)<='9')){
                return false;
            }
        }

        return true;
    }

    public void setName(String name){
        this.name = name.toUpperCase();
    }
    public void setNumber(String num){
        num = getNormalizedNumber(num);
        if(isValidNumber(num)){
            this.number = num;
        }else{
            throw new IllegalArgumentException("Invalid number!");
        }
    }
    public String getName(){
        return this.name;
    }
    public String getNumber(){
        return this.number;
    }

    public Phone(String name, String number){
        setName(name);
        setNumber(number);
    }
    public Phone(){
        name = "";
        number = "";
    }
}
