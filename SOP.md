# SOP - Publishing Union Governing Documents

This document explains how to publish adopted changes to the Union's governing documents in the Git repositories that hold them.

## Scope 

This document covers **publication only**.
Only the Rensselaer Union Constitution and the bylaws of the relevant body determine whether an amendment or bill has been validly adopted.
This SOP does not define, interpret, or summarize those requirements. 
Nothing in a repository *establishes* that a body has adopted a change. 

The repositories are **records of acts that happened elsewhere**. 
Bodies draft, present, amend, and vote on motions outside of this version-control system.
Git is only used after final adoption, 
to publish the result and record who published it, 
who checked it, 
and where you can find the adopted motion. 

Where the repository and the official record of the adopting body disagree, said record takes precedence. 

## Definitions 

## Roles 

| **Role**   | **Who**                                              | **Responsibilities**                                                                                            | **Needs GitHub?** |
|------------|------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|-------------------|
| Preparer   | Secretary of the adopting body                       | Freezes the adopted source, updates `main.tex`, confirms nothing else changed, sends change to verifier, merges | Yes               |
| Verifier   | Designated officer of the adopting body (Appendix A) | Confirms the changed text matches the original motion                                                           | No                |
| Maintainer | Web Technologies Group Chair                         | Maintains the class file, build config, and workflows; acts as preparer when Secretary cannot                   | Yes               |

**The preparer and verifier must be separate people**. 
The verifier must be an officer of the body.
If the verifier is unavailable, or is also the preparer, the alternate verifier listed in Appendix A acts instead. 

Verification is a matter of proofreading, not approval.
The body has already acted.
A pending or unmerged pull request never means an amendment is not in effect. 

## Commit Types 

You must format every commit subject as follows: `<type>: <description>`.
The description must be imperative.

| **Type**       | **Use for**                                                                                                                                                                     | **Example**                                      |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| `amend:`       | Publishing an adopted amendment. One commit per motion.                                                                                                                         | `amend: reduce Senate quorum to simple majority` |
| `errata:`      | Correcting a publication error --- a place where the published text does not match the source.                                                                                  | `errata: restore omitted comma in Art. V §3`     |
| `ministerial:` | Changes to the text that you make without a motion, such as renumbering clauses, or correcting cross-references. Allowed *only* where governing documents grant that authority. | `ministerial: renumber Art. VI after 57-12`      |
| `build:`       | Class file, build config, workflow, or submodule changes                                                                                                                        | `build: bump union-docs-common to ...`           |
| `docs:`        | Repo docs like README or this SOP or                                                                                                                                            | `docs: add tagging steps to README`              |
| `[bot]`        | Automated commits by CI. Never used by people.                                                                                                                                  | `[bot]: update generated main.pdf`               |

### Errata vs. Ministerial 

`errata:` fixes the repository's own mistake; it needs no authority beyond the original source it adopts, which it must match. 
You cannot fix a mistake in the text *as adopted* (e.g. a typo in section numbering) as errata. 
It is either a ministerial --- change under authority the governing documents grant --- or it requires an amendment. 
If no such authority exists, the typo stays until the body acts. 

If a change is in doubt, treat it as substantive (i.e. requiring some authority).

## Publishing an amendment 

### Freeze the source 

Check the integrity of the motion document. 
Look at the version history and confirm no one made changes after the body voted. 
Ensure the motion is present in the official public record. 

Save the motion document as a PDF with the name `YYYY-MM-DD-<motion>.pdf`, 
where the date corresponds to the formal date of adoption, 
and `<motion>` is the motion identifier 
(e.g. `57-12` for the twelfth motion passed by the 57th Senate).

If any of these checks fail, stop and refer to [](#discrepancies).
  
### Prepare the change 

**Create the branch**

**Edit the document**

**Open pull request**

### Verify and publish 

## Commit message format 

## Discrepancies

