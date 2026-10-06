# SOP - Publishing Union Governing Documents

This document explains how to publish adopted changes to the Union's governing documents in the Git repositories that hold them.

## 1. Scope 

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

## 2. Definitions 

## 3. Roles 

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

## 4. Commit Types 

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

## 5. Publishing an amendment 

### Freeze the source 

Check the integrity of the motion document. 
Look at the version history and confirm no one made changes after the body voted. 
Ensure the motion is present in the official public record. 

Save the motion document as a PDF with the name `YYYY-MM-DD-<motion>.pdf`, 
where the date corresponds to the formal date of adoption, 
and `<motion>` is the motion identifier 
(e.g. `57-12` for the twelfth motion passed by the 57th Senate).

If any of these checks fail, stop and refer to [Discrepancies](#discrepancies).
  
### Prepare the change 

You can do all these steps in the GitHub web interface; you don't need any local software. 

1. **Create the branch** named `amend/<motion>` (e.g. `amend/57-13`).

2. **Edit the document** in the new branch:

   1. Make the change in `main.tex`.
   2. Update `\amendeddate` to the date of final approval.
      - *For the Constitution, update the appendix of amendments.*
   3. Uploaded the source PDF to the `adopted/` folder.
   
3. **Open a pull request.** 
   The PR title is the commit subject, e.g. `amend: reduce E-Board quorum to simple majority`.
   Fill in the template, replacing every `[FILL IN ...]` placeholder except `Verified-by:`.
   The PR description becomes the permanent commit message, so write it as a record.
   
4. **Wait for the build check to pass** and complete the preparer checklist in Section 7.

### Verify and publish 

1. Send the verifier the adopted source PDF, plus either or both of:
   - the preview PDF, downloaded from the build check; or
   - a link to the pull request's "Files changed" tab, 
     which anyone can view without an account because the repository is public.
2. Tell the verifier which articles and sections the motion changes.
   Any channel is acceptable, such as email, Discord, or Webex.
3. The verifier compares them using the verifier checklist in Section 7 and replies that the text matches, or explains what doesn't.
4. The preparer **squash-merges** and, in the merge dialog, 
   fills in the `Verified-by:` trailer with the verifier's name, role, channel, and date. 
   GitHub may append the PR number to the subject line. That is harmless and you may leave or remove it.
5. Wait for CI to commit the rebuilt main.pdf with a [bot] commit.
6. Create the release (Section 9).

## 6. Commit message format 

The squash commit message has three parts: the subject line, a plain-language description, and a final block of trailers.
Trailers are `Key: value` lines in the last paragraph, with no blank lines between them. 
Follow the order shown below.

```
amend: reduce E-Board quorum to simple majority

Strikes the two-thirds quorum requirement in Article V §3 and
replaces it with a majority of voting members.

Motion: 20260422-3
Motion: 56-26
Approval: Executive Board, 2026-04-22, 18-2-1
Approval: Student Senate, 2026-04-24, 13-0-2
Minutes: Executive Board, 2026-04-22
Minutes: Student Senate, 2026-04-21
Archive: Student Government public record, Executive Board, FY26, 2026-04-22, Motion 3
Archive: Student Government public record, Student Senate, 56th Senate, Motion 26
Source: adopted/2026-04-22-3.pdf
Source: adopted/2026-04-24-57-26.pdf
Prepared-by: Jane Doe (E-Board Secretary)
Verified-by: John Roe (VP, Rules & Special Projects), by email, 2026-04-25
```

### Trailer reference 

| **Trailer**    | **Meaning**                                                                                                | `amend`  | `errata` | `ministerial` |
|----------------|------------------------------------------------------------------------------------------------------------|----------|----------|---------------|
| `Motion:`      | Motion identifier as appears on the motion doc                                                             | Required | -        | -             |
| `Approval:`    | `Body, YYYY-MM-DD, vote`. One line per required approval, in order.                                        | Required | -        | -             |
| `Minutes:`     | Citation of the minutes recording each approval: body, meeting date. A link may follow the citation. | Required | -        | -             |
| `Archive:`     | Where the motion is filed in the archive (path/url)                                                             | Required | -        | -             |
| `Authority:`   | Citation of provision granting authority for the change                                                    | -        | -        | Required      |
| `Source:`      | Path to the adopted source                                                                                 | Required | Required | -             |
| `Corrects:`    | Hash of the commit where error was introduced                                                              | -        | Optional | -             |
| `Prepared-by:` | Full name and role                                                                                         | Required | Required | Required      |
| `Verified-by:` | Full name, role, channnel, and date of verification                                                        | Required | Required | Required      |

## 7. Checklist

## Discrepancies

