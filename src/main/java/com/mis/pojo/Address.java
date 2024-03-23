/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mis.pojo;

import java.sql.ResultSet;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author zheng
 */
public class Address {
    private String street;
    private String postcode;
    private String city;
    private String state;
    private static Map<String, List<String>> stateToCities;
    private static Map<String, List<String>> cityToPostcode;

    // Constructor
    public Address() {
    }

    public Address(String address) {
        String[] parts = address.split(", ");

        street = parts[0].trim() + ", " + parts[1].trim();  // 108, JALAN WONG FOOK
        String[] cityPostcode = parts[2].split(" "); // 分割城市和邮编
        if (cityPostcode.length == 3) {
            postcode = cityPostcode[0].trim(); // 10050
            city = cityPostcode[1].trim() + " " + cityPostcode[2].trim(); // GEORGE TOWN
        }
        else {
            postcode = cityPostcode[0].trim();
            city = cityPostcode[1].trim();
        }
        state = parts[3].trim(); // PENANG
    }

    public Address(String street, String postcode, String city, String state) {
        this.street = street;
        this.postcode = postcode;
        this.city = city;
        this.state = state;
    }

    // Method
    static {
        stateToCities = new LinkedHashMap<>();
        stateToCities.put("PERLIS", Arrays.asList("KANGAR", "ARAU", "PADANG BESAR", "KUALA PERLIS", "JEJAWI", "BESERI"));
        stateToCities.put("KEDAH", Arrays.asList("ALOR SETAR", "KUAH", "KULIM", "YAN", "PADANG SERAI", "SUNGAI PETANI"));
        stateToCities.put("PENANG", Arrays.asList("GEORGE TOWN", "JELUTONG", "BATU FERRINGHI", "BUTTERWORTH", "KEPALA BATAS", "TASEK GELUGOR", "BUKIT MERTAJAM", "BAYAN LEPAS", "BATU KAWAN"));
        stateToCities.put("PERAK", Arrays.asList("IPOH", "BATU GAJAH", "TAIPING", "TELUK INTAN", "SITIAWAN"));
        stateToCities.put("SELANGOR", Arrays.asList("KUALA LUMPUR", "SHAH ALAM", "PETALING JAYA", "SUBANG JAYA", "KLANG", "SELAYANG"));
        stateToCities.put("NEGERI SEMBILAN", Arrays.asList("SEREMBAN", "PORT DICKSON", "REMBAU", "SRI JEMPOL", "TAMPIN", "JELEBU"));
        stateToCities.put("MALACCA", Arrays.asList("MALACCA CITY", "AYER KEROH", "KUALA LINGGI", "ALOR GAJAH", "JASIN"));
        stateToCities.put("JOHOR", Arrays.asList("JOHOR BAHRU", "ISKANDAR PUTERI", "MUAR", "BATU PAHAT", "SEGAMAT", "KOTA TINGGI"));
        stateToCities.put("KELANTAN", Arrays.asList("KOTA BHARU", "PASIR MAS", "TUMPAT", "TANAH MERAH"));
        stateToCities.put("TERENGGANU", Arrays.asList("KUALA TERENGGANU", "KUALA BESUT", "BUKIT BESI", "DUNGUN"));
        stateToCities.put("PAHANG", Arrays.asList("KUANTAN", "CAMERON HIGHLANDS", "JERANTUT", "KEMAYAN"));

        cityToPostcode = new LinkedHashMap<>();
        // Perlis
        cityToPostcode.put("KANGAR", Arrays.asList("01000", "02400", "02500"));
        cityToPostcode.put("ARAU", Arrays.asList("02600", "02607", "02609"));
        cityToPostcode.put("PADANG BESAR", Arrays.asList("02000", "02100", "02200"));
        cityToPostcode.put("PADANG SERAI", Arrays.asList("09400", "09410"));
        cityToPostcode.put("JEJAWI", Arrays.asList("01000"));
        cityToPostcode.put("BESERI", Arrays.asList("02400", "02450"));

        // Kedah
        cityToPostcode.put("ALOR SETAR", Arrays.asList("05400", "05150", "05594", "05700", "05710", "05720", "06250"));
        cityToPostcode.put("KUAH", Arrays.asList("07000"));
        cityToPostcode.put("KULIM", Arrays.asList("09000", "09010", "09020"));
        cityToPostcode.put("YAN", Arrays.asList("06900"));
        cityToPostcode.put("PADANG SERAI", Arrays.asList("09400", "09410"));
        cityToPostcode.put("SUNGAI PETANI", Arrays.asList("08000", "08010"));

        // Penang
        cityToPostcode.put("GEORGE TOWN", Arrays.asList("10000", "10050", "10100", "10150", "10200"));
        cityToPostcode.put("JELUTONG", Arrays.asList("11600"));
        cityToPostcode.put("BATU FERRINGHI", Arrays.asList("11100"));
        cityToPostcode.put("BUTTERWORTH", Arrays.asList("12100", "12200", "13000", "13400", "13800"));
        cityToPostcode.put("KEPALA BATAS", Arrays.asList("13200", "13210"));
        cityToPostcode.put("TASEK GELUGOR", Arrays.asList("13300", "13310"));
        cityToPostcode.put("BUKIT MERTAJAM", Arrays.asList("14000", "14007", "14009", "14020"));
        cityToPostcode.put("BAYAN LEPAS", Arrays.asList("11900", "11920", "11950"));
        cityToPostcode.put("BATU KAWAN", Arrays.asList("14100", "14110"));

        // Perak
        cityToPostcode.put("IPOH", Arrays.asList("30000", "30010", "31350", "31400"));
        cityToPostcode.put("BATU GAJAH", Arrays.asList("31000", "31007", "31009"));
        cityToPostcode.put("TAIPING", Arrays.asList("34000", "34020", "34030", "34300", "34600", "34700"));
        cityToPostcode.put("TELUK INTAN", Arrays.asList("36000", "36008", "36030", "36400"));
        cityToPostcode.put("SITIAWAN", Arrays.asList("32000", "32400", "32700"));

        // Selangor
        cityToPostcode.put("KUALA LUMPUR", Arrays.asList("64000", "68100"));
        cityToPostcode.put("SHAH ALAM", Arrays.asList("40150", "40160", "40170", "40470", "40610", "40800"));
        cityToPostcode.put("PETALING JAYA", Arrays.asList("46050", "47301", "47400", "47410", "47800"));
        cityToPostcode.put("SUBANG JAYA", Arrays.asList("46150", "47300", "47301", "47410", "47500", "47650"));
        cityToPostcode.put("KLANG", Arrays.asList("41100", "41150", "41200", "41300", "42100", "42600", "68000"));
        cityToPostcode.put("SELAYANG", Arrays.asList("68100"));

        // Negeri Sembilan
        cityToPostcode.put("SEREMBAN", Arrays.asList("70000", "70100", "70200", "70300", "70400", "70450", "71000"));
        cityToPostcode.put("PORT DICKSON", Arrays.asList("71000", "71010", "71960"));
        cityToPostcode.put("REMBAU", Arrays.asList("71300", "71400"));
        cityToPostcode.put("SRI JEMPOL", Arrays.asList("72100", "72120", "72127", "72129"));
        cityToPostcode.put("TAMPIN", Arrays.asList("70450", "71150", "71200", "71300", "71450", "72100", "72200", "73000", "73300"));
        cityToPostcode.put("JELEBU", Arrays.asList("70100", "70400", "71500", "71600", "71650", "71750", "71770"));

        // Malacca
        cityToPostcode.put("MALACCA CITY", Arrays.asList("75000", "75200", "75250", "75300", "75460"));
        cityToPostcode.put("AYER KEROH", Arrays.asList("75450"));
        cityToPostcode.put("KUALA LINGGI", Arrays.asList("78200"));
        cityToPostcode.put("ALOR GAJAH", Arrays.asList("78000", "78009"));
        cityToPostcode.put("JASIN", Arrays.asList("77000", "77007", "77008", "77009"));

        // Johor
        cityToPostcode.put("JOHOR BAHRU", Arrays.asList("80100", "80150", "80200", "80250", "80300", "81200", "81300"));
        cityToPostcode.put("ISKANDAR PUTERI", Arrays.asList("79000", "79100", "79250", "79504", "79505", "79511", "79570"));
        cityToPostcode.put("MUAR", Arrays.asList("81850", "84000", "84200"));
        cityToPostcode.put("BATU PAHAT", Arrays.asList("83000"));
        cityToPostcode.put("SEGAMAT", Arrays.asList("85000"));
        cityToPostcode.put("KOTA TINGGI", Arrays.asList("81900"));

        // Kelantan
        cityToPostcode.put("KOTA BHARU", Arrays.asList("15000", "15050", "15200", "15300", "15350", "16100"));
        cityToPostcode.put("PASIR MAS", Arrays.asList("17000", "17010"));
        cityToPostcode.put("TUMPAT", Arrays.asList("16080", "16200", "16210"));
        cityToPostcode.put("TANAH MERAH", Arrays.asList("17500"));

        // Terengganu
        cityToPostcode.put("KUALA TERENGGANU", Arrays.asList("20500", "21000", "21080", "21100", "21200", "21300"));
        cityToPostcode.put("KUALA BESUT", Arrays.asList("22300"));
        cityToPostcode.put("BUKIT BESI", Arrays.asList("23200"));
        cityToPostcode.put("DUNGUN", Arrays.asList("23000", "23007", "23009", "23050"));

        // Pahang
        cityToPostcode.put("KUANTAN", Arrays.asList("25000", "25150", "25200", "25250", "25300", "26060", "26080", "26100"));
        cityToPostcode.put("CAMERON HIGHLANDS", Arrays.asList("69000"));
        cityToPostcode.put("JERANTUT", Arrays.asList("27000", "27040", "27050", "27070", "27090"));
        cityToPostcode.put("KEMAYAN", Arrays.asList("28340", "28380"));
    }

    public String getAddress() {
        return street.toUpperCase() + ", " + postcode + " " + city.toUpperCase() + ", " + state.toUpperCase();
    }

    public boolean checkAddressDuplicate(ResultSet result, String searchThing) {
        try {
            while (result.next()) {
                String address = result.getString(searchThing);

                if (getAddress().equals(address)) {
                    result.close();
                    return true;
                }
            }
            result.close();

            return false;
        }
        catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean checkEditAddressDuplicate(ResultSet result, String searchThing, String orgAddress) {
        try {
            while (result.next()) {
                String address = result.getString(searchThing);

                if (getAddress().equals(address)) {
                    if (getAddress().equals(orgAddress)) {
                        result.close();
                        return false;
                    }
                    else {
                        result.close();
                        return true;
                    }
                }
            }
            result.close();

            return false;
        }
        catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // Setter
    public void setStreet(String street) {
        this.street = street;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setState(String state) {
        this.state = state;
    }

    // Getter
    public String getStreet() {
        return street;
    }

    public String getPostcode() {
        return postcode;
    }

    public String getCity() {
        return city;
    }

    public String getState() {
        return state;
    }

    public static Map<String, List<String>> getStateToCities() {
        return stateToCities;
    }

    public static Map<String, List<String>> getCityToPostcode() {
        return cityToPostcode;
    }
}
