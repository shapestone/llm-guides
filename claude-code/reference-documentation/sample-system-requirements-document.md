# Sample System Requirements Document

**Author:** Alistair A.R. Cockburn  
**Date:** 1/8/1998  
**Category:** Humans and Technology

## Chapter 1. Purpose and Scope

### Chapter 1a. What is the overall scope and goal?

The Purchase Request Tracking System has two goals. The first and most essential is to provide a basic system for the official Buyers of the company to track what they have ordered from Vendors against what has been delivered. The second is to simplify the lives of people who wish to order things, who must sign purchase requests, and who are to track the purchases against budgets.

In simplest form the story to be supported is that a Requestor creates a request, which is sent to an Approver who signs it, adds accounting codes and forwards it to the Buyer. The Buyer double checks item part numbers, vendors, and the Approvers signature authorization, then issues one or more Purchase Orders (PO) from Vendors. When goods are delivered, the Receiver at the Receiving Dock enters the amounts received against the POs. The Buyer and Receiver can adjust the amounts received against those ordered, and see what still is missing from the order. The Requestor signs that the goods were received in good condition. At this point the Request is considered to be delivered. Invoicing and payment will make use of the information, but are out of scope of this system.

At any point in time, any of the people or their managers can check on the state of the request and the POs, and the overall buying patterns of the person, department or company.

### Chapter 1b. Stakeholders (who cares?)

- Each direct user cares: Requestor, Approver, Authorizer, Buyer, Receiver, and Manager.
- Accounting department cares, because they create the approval / authorization rules.
- Each manager cares, because they may wish to set up simpler or more complex approval rules.
- The requestor's manager cares about security, so that his/her signature is not forged.
- The manager's management line cares about security, so that improperly authorized people do not sign requests, and they cause the auditing department to care, to make sure that lower-level managers are not exceeding budget, and also to provide proper record keeping for the tax authorities, who care how businesslike some of the purchases are.

### Chapter 1c. What is in scope, what is out of scope

| In/Out | Item |
|--------|------|
| Out | Invoicing in any form |
| In | Producing reports about requests, e.g. by vendor, by part, by person |
| In | Merging requests to one PO |
| In | Partial deliveries, late deliveries, wrong deliveries |
| In | All new system services, software |
| Out | Any non-software parts of the system |
| In | Identification of any pre-existing software that can be used |
| In | Requisitions |

## Chapter 2. The Use Cases

### Chapter 2a. The primary actors and their general goals

**Actors:**
- **Requestor** - Person putting in a request to buy goods
- **Approver** - Typically Requestor's manager, who must approve the purchase
- **Manager** - Person responsible for a department's budget
- **Buyer** - Person who manages the order, talking with the Vendor
- **Authorizer** - Person who validates signature of approver
- **Receiver** - Person who receives the goods from the Vendor
- **(Vendor** - Person or company who sells and delivers goods – is a secondary actor)

**Outermost Goals:**

| Actor | Outermost Goal | Level | Use-case nr. |
|-------|---------------|-------|--------------|
| Requestor | Buy something | Summary | 1 |
| Any | Check on requests | Task | 2 |
| Authorizor | Change authorizations | Task | 3 |
| Buyer | Change vendor contacts | Task | 4 |

**Task-level goals:**

| Actor | Task-level Goal | Priority | Use-case nr. |
|-------|----------------|----------|--------------|
| Any | Check on requests | 1 | 2 |
| Authorizor | Change authorizations | 2 | 3 |
| Buyer | Change vendor contacts | 3 | 4 |
| Requestor | Initiate an request | 1 | 5 |
| Requestor | Change a request | 1 | 6 |
| Requestor | Cancel a request | 4 | 7 |
| Requestor | Mark request delivered | 4 | 8 |
| Requestor | Refuse delivered goods | 4 | 9 |
| Approver | Complete request for submission | 2 | 10 |
| Buyer | Complete request for ordering | 1 | 11 |
| Buyer | Initiate PO with vendor | 1 | 12 |
| Buyer | Alert of non-delivery | 4 | 13 |
| Authorizer | Validate approver's signature | 3 | 14 |
| Receiver | Register delivery | 1 | 15 |

### Chapter 2b. The business use cases

#### Use Case 1: Buy something

- **Goal in Context:** Requestor buys something through the system, gets it.
- **Scope:** Corporate – The overall purchasing mechanism, electronic and non-electronic, as seen by the people in the company.
- **Level:** Summary
- **Preconditions:** none
- **Success End Condition:** Requestor has goods, correct budget ready to be debited.
- **Failed End Condition:** Either order not sent or goods not being billed for.
- **Primary Actor:** Requestor
- **Trigger:** Requestor decides to buy something.

**Main Success Scenario:**

1. Requestor: initiate a request
2. Approver: complete request for submission
3. Buyer:
4. Authorizer: validate approver's signature
5. Buyer: complete request for ordering (UC12)
6. Vendor:
7. Receiver: register delivery
8. Requestor: mark request delivered

**Extensions:**

- **1a.** Requestor does not know vendor or price: leave those parts blank and continue.
- **1b.** At any time prior to receiving goods, Requestor can change or cancel the request. Canceling it removes it from any active processing. (delete from system?) Reducing price leaves it intact in process. Raising price sends it back to Approver.
- **2a.** Approver does not know vendor or price: leave blank and let Buyer fill in or call back.
- **2b.** Approver is not Requestor's manager: still ok, as long as approver signs
- **2c.** Approver declines: send back to Requestor for change or deletion
- **3a.** Buyer finds goods in storage: send those up, reduce request by that amount and carry on.
- **3b.** Buyer fills in Vendor and price, which were missing: gets resent to Approver.
- **4a.** Authorizer declines Approver: send back to Requestor and remove from active processing. (what does this mean exactly?)
- **5a.** Request involves multiple Vendors: Buyer generates multiple POs.
- **5b.** Buyer merges multiple requests: same process, but mark PO with the requests being merged.
- **6a.** Vendor does not deliver on time: System does alert of non-delivery
- **7a.** Partial delivery: Receiver marks partial delivery on PO and continues
- **7b.** Partial delivery of multiple-request PO: Receiver assigns quantities to requests and continues.
- **8a.** Goods are incorrect or improper quality: Requestor does refuse delivered goods. (what does this mean?)
- **8b.** Requestor has quit the company: Buyer checks with Requestor's manager, either reassign Requestor, or return goods and cancel request.

**Data Variations:** none

**Project Information:**

| Priority | Release | Due | Response time | Freq of use |
|----------|---------|-----|---------------|-------------|
| Various | Several | Various | | 3 / day |

- **Superordinate Use Case:** none
- **Subordinate Use Cases:** see text
- **Channel to primary actor:** Internet browser, mail system, or equivalent
- **Secondary Actors:** Vendor
- **Channels to Secondary Actors:** fax, phone, car

**Open issues:**
- When is a canceled request deleted from the system?
- What authorization is needed to cancel a request?
- Who can alter a request's contents?
- What change history must be maintained on requests?
- What happens when Requestor refuses delivered goods?
- How exactly does a Requisition work, differently from an order?
- How does ordering reference and make use of the internal storage (Lager)?

### Chapter 2c. The system use cases

| Task-level Goal | Business Need (Notes) | Technical Difficulty | Priority | Use-case nr. |
|----------------|----------------------|---------------------|----------|--------------|
| Check on requests | Top (need to find a request) | Large job in general case | 1 | 2 |
| Change authorizations | High (can work by hand) | Simple | 2 | 3 |
| Change vendor contacts | Medium (can work by hand) | Simple | 3 | 4 |
| Initiate an request | Top | Medium | 1 | 5 |
| Change a request | Top | Simple | 1 | 6 |
| Cancel a request | Low (can simply ignore) | Simple | 4 | 7 |
| Mark request delivered | Low (can use delivery register) | Simple | 4 | 8 |
| Refuse delivered goods | Low (can simply ignore) | Unknown | 4 | 9 |
| Complete request for submission | High (can work by hand) | Complex | 2 | 10 |
| Complete request for ordering | Top | Complex | 1 | 11 |
| Initiate PO with vendor | Top | Complex | 1 | 12 |
| Alert of non-delivery | Low (can work by hand) | Medium | 4 | 13 |
| Validate approver's signature | Medium (can work by hand) | Hard | 3 | 14 |
| Register delivery | Top | Medium | 1 | 15 |

#### Use Case 2: Check on requests

- **Goal in Context:** Requestor, manager or buyer wants to see the state of the system.
- **Scope:** System
- **Level:** Task
- **Preconditions:** none
- **Success End Condition:** Nothing changed in system
- **Failed End Condition:** Nothing changed in system
- **Primary Actor:** Reader: Requestor or manager or Buyer or Receiver or anyone authorized to peek
- **Trigger:** Actor decides to look into the system.

**Main Success Scenario:**

1. Reader: asks to see any one or any multiple requests sorted by any imaginable criteria.
2. System: shows purchases
3. Reader: asks to get report printed

**Extensions:**

- **1a.** Known searches by requestor, by approver, by vendor, by item ordered, by date, by past-due

**Data Variations:** none

**Project Information:**

| Priority | Release | Due | Response time | Freq of use |
|----------|---------|-----|---------------|-------------|
| 2 | 1 | | 7 seconds | 2 / day / person |

High priority is find one request, by some index. Each search request to be prioritized separately.

- **Superordinate Use Case:** none
- **Subordinate Use Cases:** none
- **Channel to primary actor:** Internet browser, window-based program, paper
- **Secondary Actors:** none

**Open issues:**
- Need list of all the search criteria, formats needed.
- Need to prioritize which searches get developed first.

#### Use Case 3: Change authorizations

- **Goal in Context:** Change who can approve purchases, what purchase limits they have
- **Scope:** System
- **Level:** Task
- **Primary Actor:** Authorizer

#### Use Case 4: Change vendor contacts

- **Goal in Context:** Add, delete, change name, address, phone number of vendors
- **Scope:** System
- **Level:** Task

#### Use Case 5: Initiate an request

- **Goal in Context:** Create a request in the system
- **Scope:** System
- **Level:** Task
- **Preconditions:** none
- **Success End Condition:** request has requestor's name and what is to be purchased
- **Primary Actor:** Requestor

#### Use Case 6: Change a request

- **Goal in Context:** Change any part of a request
- **Scope:** System
- **Level:** Task
- **Preconditions:** request exists
- **Success End Condition:** request changed
- **Failed End Condition:** request unchanged
- **Primary Actor:** any

#### Use Case 7: Cancel a request

- **Goal in Context:** Cause processing on a request to stop
- **Scope:** System
- **Level:** Task
- **Preconditions:** request exists

#### Use Case 8: Mark request delivered

- **Goal in Context:** Finalize a request as delivered OK, no more work need be done on it
- **Scope:** System
- **Level:** Task

#### Use Case 9: Refuse delivered goods

- **Goal in Context:** Initiate process to return goods, keep from paying for them
- **Scope:** System
- **Level:** Task

#### Use Case 10: Complete request for submission

- **Goal in Context:** Complete approval process for a request
- **Scope:** System
- **Level:** Task
- **Primary Actor:** Approver

#### Use Case 11: Complete request for ordering

- **Goal in Context:** Complete all parts of request and initiate POs
- **Scope:** System
- **Level:** Task
- **Primary Actor:** Buyer

#### Use Case 12: Initiate PO with vendor

- **Goal in Context:** From one or more Requests, generate PO to a single vendor
- **Scope:** System
- **Level:** Task
- **Primary Actor:** Buyer

#### Use Case 13: Alert of non-delivery

- **Goal in Context:** Notify Buyer that a delivery did not arrive on time.
- **Scope:** System
- **Level:** Task
- **Trigger:** PO due date passed

#### Use Case 14: Validate approver's signature

- **Goal in Context:** Establish that the request approver really has the needed signature authority
- **Scope:** System
- **Level:** Task

#### Use Case 15: Register delivery

- **Goal in Context:** Mark actual delivery against one or more POs
- **Scope:** System
- **Level:** Task
- **Primary Actor:** Receiver

## Chapter 3. The Terms Used / Glossary

- **Request** – The bit of paper or electronic form carrying the idea of some things to be bought, with at least the name of the person who should receive the goods, various approvals, the list of goods, their prices, the vendors.
- **PO** – Purchase Order. The bit of paper or electronic form communicating to a vendor what is being bought. A legal document establishing the terms of purchase.
- **Approval** – The signature or legally significant mark asserting that a person in the company has seen the request, has authority to OK the request, and OK's it.
- **Authorization** – The legally significant mark asserting that a person has the right to approve requests within some constraints, such as a cost limit.

## Chapter 4. The Technology to Be Used

**Q. What technology requirements are there for this system?**

Prefer to use internet or intranet technology, or an advanced mail system. The system should do as much checking as possible, should alert the people involved when their work is needed.

**Q. What systems will this system interface with, with what requirements?**

Internet browser or mail system. Printers. Can a commercial contact database be used?

## Chapter 5. Other Various Requirements

### Chapter 5a. Development process

**Q. Who are the project participants?**

A sampling of the existing managers, buyers, and authorizers.

**Q. What values will be reflected in the project (simple, soon, fast, or flexible)?**

- Sacrifice others for this: Simple to use
- Retain if possible: Soon
- Sacrifice these first: Performance, Flexibility

**Q. What feedback or project visibility do the users and sponsors wish?**

Prototypes and demos

**Q. What can we buy, what must we build, what is our competition to this system?**

Build everything but browsers and email. Competition is a monolithic purchase system, or a spreadsheet.

**Q. What other requirements are there on the development process (e.g. testing, installation)?**

Must be installed company wide – look for an easy solution. Project involves only loss of comfort or discretionary moneys, therefore can keep the development process light.

**Q. What dependencies does the project operate under?**

Part time developers with little time, therefore need to work with maximum efficiency (keep process light).

### Chapter 5b. Business rules

1. Initially, assume no signature limits, anyone with authority can approve anything.
2. Initially, assume only one person can approve a request, if that is useful to assume. Eventually, any approver can approve for any requestor.
3. One PO can merge items from several requests.
4. Receiver gets to decide how to split a partial delivery across requests.

### Chapter 5c. Operations, security, documentation

1. Security is important. Initially work from the natural log-on protection. Next use one-way function encoding of a special purchasing password. Eventually consider digital signatures if that helps.
2. Need to be able to update this application easily across several hundred workstations.
3. Needs online help, a tutorial should be created for the various users.

### Chapter 5d. Use and usability

1. Simple to use is the top project priority. Therefore, not only must it be clear and straightforward in use, it should also have good on-line help.
2. Acceptance of usability is up to the Buyer community.

### Chapter 5e. Unresolved or deferred

1. How to do electronic signature security
2. The exact number of searches and reports
3. What does it mean to cancel an order?
4. Who gets to change an order in process – just the requestor, or anyone?

### Chapter 5f. Maintenance and portability

1. Likely to have to port to a different email system or browser.

## Chapter 6. Human Backup, Legal, Political, Organizational Issues

**Q. What is the human backup to system operation?**

Paper still works very well :-)

**Q. What legal, what political requirements are there?**

Tax authorities may request copies of purchases to verify correct accounting for entertainment-based purchases.

**Q. What are the human consequences of completing this system?**

Everyone in the company will have to work with this system.

**Q. What are the training requirements?**

The Buyers, Approvers, Authorizers, and Receivers will have to have a training class. Requestors should be able to work from online documentation

**Q. What assumptions, what dependencies are there on the human environment?**

That people can always pick up the phone and call each other. That some people will submit and even approve requests without all the purchase information being in place. The system should tolerate this, allowing information to be put in as late as possible.

## Chapter 7. Possible Project Plan

- **M0. Investigation.** Requirements and Technology investigation. Completed when (1) a plausible set of technological elements are found which can implement the system, (2) a screen mockup or prototype is shown to a selected subset of the primary actors and they approve.

- **M1. Increment 1.** Demo of technology. 1 request obtains 1 vendor address, notifies 1 person (any) and is updated by that person.

- **M2. Increment 2.** Demo of simplistic system, showing 1 request for 1 item from 1 known vendor being created and modified. It shall notify 1 approver, collect an OK, and notify 1 Buyer, and generate 1 PO. A delivery against the PO will be reflected in the request. No errors detected.

- **M3. Increment 3.** First usable system function. Allows Buyer to enter a request that was completed and signed on paper, and generate POs that can be printed. Allows Receiver to mark delivery against PO and request. Supports split and partial deliveries.

- **M4. Increment 4.** First reports. Searches, collects and prints selected reports.

- **M5. Increment 5.** First security functions. Allows Requestor to create request, collects approval from Approver, notifies Buyer.

- **M6. Increment 6.** Full database functions. Allows Authorizers, Buyers to maintain approval, vendor contact databases.

- **M7. Increment 7.** Full security function. Special passwords with 1-way functions.

- **M8. Increment 8.** Full function, including order refusal and cancelation, alert of non-delivery.

---

*Thanks, Artur Badretdinov, for cleaning up the tables!*  
*Alistair*