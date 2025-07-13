@ResponseStatus(HttpStatus.NOT_FOUND)
public class CountryNotFoundException extends Exception {
    public CountryNotFoundException(String message) {
        super(message);
    }
}
