public class JwtAuthorizationFilter extends BasicAuthenticationFilter {
    public JwtAuthorizationFilter(AuthenticationManager authenticationManager) {
        super(authenticationManager);
    }

    @Override
    protected void doFilterInternal(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        String header = req.getHeader("Authorization");
        if (header == null || !header.startsWith("Bearer ")) {
            chain.doFilter(req, res);
            return;
        }
        UsernamePasswordAuthenticationToken auth = getAuthentication(req);
        SecurityContextHolder.getContext().setAuthentication(auth);
        chain.doFilter(req, res);
    }

    private UsernamePasswordAuthenticationToken getAuthentication(HttpServletRequest request) {
        String token = request.getHeader("Authorization").replace("Bearer ", "");
        try {
            Jws<Claims> jws = Jwts.parser().setSigningKey("secretkey").parseClaimsJws(token);
            String user = jws.getBody().getSubject();
            return new UsernamePasswordAuthenticationToken(user, null, new ArrayList<>());
        } catch (JwtException e) {
            return null;
        }
    }
}
