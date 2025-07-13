//Exercise 5

@RestController
public class AuthenticationController {
    private static final Logger LOGGER = LoggerFactory.getLogger(AuthenticationController.class);

    @GetMapping("/authenticate")
    public Map<String, String> authenticate(@RequestHeader("Authorization") String authHeader) {
        LOGGER.info("START");
        LOGGER.debug("AuthHeader: {}", authHeader);
        String user = getUser(authHeader);
        String token = generateJwt(user);
        Map<String, String> map = new HashMap<>();
        map.put("token", token);
        LOGGER.info("END");
        return map;
    }

    private String getUser(String authHeader) {
        String encoded = authHeader.substring(6); // remove "Basic "
        String decoded = new String(Base64.getDecoder().decode(encoded));
        return decoded.split(":")[0]; // user
    }

    private String generateJwt(String user) {
        JwtBuilder builder = Jwts.builder()
            .setSubject(user)
            .setIssuedAt(new Date())
            .setExpiration(new Date(System.currentTimeMillis() + 20 * 60 * 1000)) // 20 mins
            .signWith(SignatureAlgorithm.HS256, "secretkey");
        return builder.compact();
    }
}

