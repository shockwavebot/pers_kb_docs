# Categories

**DEV > INT > SYS > ACC > SIM > PROD**

- Unit tests (written by developer)
- Smoke testing (general health check up, "help you build the **thing right**")
- Regression testing (verification that no new bugs are introduced)
- Sanity testing (subset of regression testing, narrow, checking if bug is fixed)
- Functional testing (focus on feature, functionality, black box)
- Integration testing (integration between different units/parts/modules, relationship and communication between units)
- System testing (whole system)
- Acceptance testing (client perspective, before releasing, delivering to the customer, "help you build the **right thing**")
- Exploratory testing

- **Level (When?)**: UNIT -> INTEGRATION -> SYSTEM -> ACCEPTANCE
- **Method (How?)**: BLACK, WHITE, AGILE, AD-HOC(EXPLORATORY)
- **Type (What?)**: Smoke, Build/Deployment validation, Functional, Security, Usability, Regression, Performance, Complience, Non-Functional(Technical) 

**Const of quality** - if bug found later, it costs 10x more to repair it 

#### Smoke tests

**SMOKE TESTING**, also known as “Build Verification Testing”, is a type of software testing that comprises of a non-exhaustive set of tests that aim at ensuring that the most important functions work. The result of this testing is used to decide if a build is stable enough to proceed with further testing.

- *non-exhaustive*
- *critical functionalities*

#### Functional testing

**FUNCTIONAL TESTING** is a type of software testing whereby the system is tested against the functional requirements/specifications.
Functions (or features) are tested by feeding them input and examining the output. Functional testing ensures that the requirements are properly satisfied by the application.

- *Black Box testing* - focus on expected functionalities to work as expected

Steps:

- Identify functions that the software is expected to perform.
- Create input data based on the function’s specifications.
- Determine the output based on the function’s specifications.
- Execute the test case.
- Compare the actual and expected outputs.
