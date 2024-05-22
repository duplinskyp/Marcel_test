describe("API Test Automation", () => {
  const baseUrl = "https://reqres.in/api";

  it("GET - List Users", () => {
    cy.request("GET", `${baseUrl}/users?page=2`).then((response) => {
      expect(response.status).to.eq(200);
      expect(response.body).to.have.property("total");
      
      // Assert "last_name" for the first and second User in "data"
      expect(response.body.data[0]).to.have.property("last_name");
      expect(response.body.data[1]).to.have.property("last_name");

      // Count number of received users in "data" and compare to "total"
      const totalUsers = response.body.data.length;
      expect(totalUsers).to.eq(response.body.total);

      // Optional: Create assertions for possible data types present in the response
      response.body.data.forEach((user) => {
        expect(user.id).to.be.a("number");
        expect(user.email).to.be.a("string");
        expect(user.first_name).to.be.a("string");
        expect(user.last_name).to.be.a("string");
        expect(user.avatar).to.be.a("string");
      });
    });
  });

  it("POST - Create User", () => {
    cy.request("POST", `${baseUrl}/users`, {
      name: "morpheus",
      job: "leader"
    }).then((response) => {
      expect(response.status).to.eq(201);
      expect(response.body).to.have.property("name", "morpheus");
      expect(response.body).to.have.property("job", "leader");
    });
  });
});
