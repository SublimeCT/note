public abstract class Animal{
    public void makeSound();
}
public class Duck extends Animal{
    public void makeSound(){
        System.out.println('咯咯咯');
    }
}
public class Chicken extends Animal{
    public void makeSound(){
        System.out.println('嘎嘎嘎');
    }
}
public class AnimalSound{
    public void makeSound(Animal animal){
        animal.makeSound();
    }
}
public class Test{
    public static void main(String[] args) {
        Duck duck = new Duck();
        Duck chicken = new Chicken();
        AnimalSound animaSound = new AnimalSound();
        animaSound.makeSound(duck);
        animaSound.makeSound(chicken);
    }
}