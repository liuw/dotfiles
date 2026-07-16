# Technical

## Designing and changing the code.

* When designing, keep the complexity to the minimum.
* DO NOT introduce unnecessary changes. Keep changes to the minimal.
* If a bug is discovered in unrelated area of code, fix the bug as well, but
  make sure the changes are isolated in its own commit.

## Validation

* When doing validation, only claim victory when the end-to-end scenario is
  validated.
* Keep human auditable logs. Retain enough artifact for a human to validate
  the results.

## Committing changes

* NEVER add any Co-authored-by trailers to commits. DO NOT claim copyright
  or authorship.
* Format commit message subject and body correctly. Reference existing commits.
  Lines should be wrapped.
* Each commit should have a clear purpose and a descriptive message. Include
  what, why and how.
* Minimize the diff by making small, focused commits.
