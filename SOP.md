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

- **Amendment:** 
  A change in the text of a document. 
  An amendment may require approval by more than one body, and so may involve more than one motion.
- **Adopting/owning body:** 
  The body who originates an amendment or publication of a governing document.
  For example, the Executive Board initiates amendments to its own bylaws.
- **Motion document:** 
  The written document containing a motion as passed by the body.
  The vote is recorded on it. 
- **Originating motion:**
  The motion whose motion document contains the adopted text of the amendment.
- **Approving motion:** 
  A motion by another body approving the originating motion, where the governing documents require it.
  It does not restate or change the text.
- **Adopted source:** 
  A PDF export of the originating motion's document as it stood when its vote concluded, committed to repository.
  There is exactly one adopted source per amendment. 
  Approving motions are cited, not committed.
  
  
## Roles 

| **Role**   | **Who**                                                                       | **Responsibilities**                                                                                            | **Needs GitHub?** |
|------------|-------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|-------------------|
| Preparer   | Secretary of the adopting body                                                | Freezes the adopted source, updates `main.tex`, confirms nothing else changed, sends change to verifier, merges | Yes               |
| Verifier   | Designated officer of the adopting body ([Appendix A](#appendix-a-verifiers)) | Confirms the changed text matches the original motion                                                           | No                |
| Maintainer | Web Technologies Group Chair                                                  | Maintains the class file, build config, and workflows; acts as preparer when Secretary cannot                   | Yes               |

**The preparer and verifier must be separate people**. 
The verifier must be an officer of the body.
If the verifier is unavailable, or is also the preparer, the alternate verifier listed in Appendix A acts instead. 

**Approving motions from other bodies:** 
The preparer obtains each approving motion's identifier, minutes citation, and archive location 
from that body's Secretary, and reads the approving motion to complete the checks in Section 5, step 3.
*The approving motion itself is not committed.*

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
| `tidy:`        | Changes to main.tex that leave the document's text exactly as it was, such as rewrapping lines (see [Formatting](#formatting-and-submodule-changes)                             | `tidy: run latexindent`                                                 |
| `build:`       | Class file, build config, workflow, or submodule changes                                                                                                                        | `build: bump union-docs-common to ...`           |
| `docs:`        | Repo docs like README or this SOP                                                                                                                                               | `docs: add tagging steps to README`              |
| `[bot]`        | Automated commits by CI. Never used by people.                                                                                                                                  | `[bot]: update generated main.pdf`               |

### Errata vs. Ministerial 

`errata:` fixes the repository's own mistake; it needs no authority beyond the original source it adopts, which it must match. 
You cannot fix a mistake in the text *as adopted* (e.g. a typo in section numbering) as errata. 
It is either a ministerial --- change under authority the governing documents grant --- or it requires an amendment. 
If no such authority exists, the typo stays until the body acts. 

If a change is in doubt, treat it as substantive (i.e. requiring some authority).

## Publishing an amendment 

### Freeze the source 

Check the integrity of the originating motion document. 
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
   
4. **Wait for the build check to pass** and complete the preparer checklist in [Checklists](#checklists).

### Verify and publish 

1. Send the verifier the adopted source PDF, plus either or both of:
   - the preview PDF, downloaded from the build check; or
   - a link to the pull request's "Files changed" tab, 
     which anyone can view without an account because the repository is public.
     
2. Tell the verifier which articles and sections the motion changes.
   Any channel is acceptable, such as email, Discord, or Webex.
   
3. The verifier compares them using the verifier [checklist](#checklists) and replies that the text matches, or explains what doesn't.

4. The preparer **squash-merges** and, in the merge dialog, 
   fills in the `Verified-by:` trailer with the verifier's name, role, channel, and date. 
   GitHub may append the PR number to the subject line. That is harmless and you may leave or remove it.
   
5. Wait for CI to commit the rebuilt `main.pdf` with a `[bot]` commit.

6. Create the release ([Releases and tags](#releases-and-tags)).

If one meeting adopts several amendments to the same document, each motion gets its own branch, PR, and commit. Publish them in the order the body adopted them.

## Commit message format 

The squash commit message has three parts: the subject line, a plain-language description, and a final block of trailers.
Trailers are `Key: value` lines in the last paragraph, with no blank lines between them. 
Follow the order shown below.

```
amend: reduce E-Board quorum to simple majority

Strikes the two-thirds quorum requirement in Article V §3 and
replaces it with a majority of voting members.

Motion: 20260422-3
Approval: Executive Board, 2026-04-22, 18-2-1
Approval: Student Senate, 2026-04-24, 13-0-2
Minutes: Executive Board, 2026-04-22
Minutes: Student Senate, 2026-04-21
Archive: Student Government public record, Executive Board, FY26, 2026-04-22, Motion 3
Archive: Student Government public record, Student Senate, 56th Senate, Motion 26
Source: adopted/2026-04-22-3.pdf
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

Use **full names and roles**, not usernames or RCS. Usernames change and are tied to a platform.

Cite documents in a way that survives a broken link.
You may add a link to the public Box folder, but always after a citation that identifies the document on its own: 
body, date, and item or identifier.

## Checklists

### Preparer checklist

The preparer checks the technical side, which requires GitHub.

- [ ] The integrity checks in [Freeze the source](#freeze-the-source) passed.
- [ ] The build check passed.
- [ ] The diff touches only the amended text, `\amendeddate`, and the new file in `adopted/`.
  The verifier checks only the passages the motion changes, 
  so this is the only check that catches an accidental change elsewhere in the document.
- [ ] `\amendeddate` equals the date of the final `Approval:` line.
- [ ] Pasted-text hazards are absent or correct: 
  smart quotes and apostrophes, 
  hyphens turned into dashes, 
  pasted symbols (§, ordinals, non-breaking spaces),
  unescaped `& % # _ $`, 
  manual numbering duplicating the class's automatic numbering, 
  and lost emphasis.
- [ ] All trailers except `Verified-by:` are filled in and in order, and no other `[FILL IN ...]` text remains.

### Verifier checklist

The verifier needs no technical knowledge. 
With the adopted source alongside the preview PDF or the text diff, they confirm:

- [ ] The adopted source is the motion as adopted, and shows the recorded vote.
- [ ] Every change the motion makes appears in the document, in the right place.
- [ ] The new text matches the motion word for word, including punctuation, capitalization, and numbering.
- [ ] Text the motion strikes no longer appears.

The verifier does not need to read the rest of the document; the preparer has already confirmed nothing else changed.
Formatting also does not need checking, since it comes from the shared class file and is outside the motion.

In the text diff, removed lines are marked in red and added lines in green. 
Commands beginning with a backslash, such as `\section{...}`, are markup and you can read past them.

## Discrepancies

The preparer and verifier **never resolve a disagreement about what a body adopts**. 
Stop publication, and refer the matter to the presiding officer of the adopting body whenever:

- someone edited the motion text after the vote, and you cannot recover the version at the time of the vote;
- the vote recorded on the motion document disagrees with the minutes;
- the motion is missing from the motion archive; or
- you cannot adopt an amendment cleanly, for example because it refers to text that a later amendment changed.

Publish any resolution under the commit type that fits it, citing whatever record documents the resolution.

## Releases and tags

Mark each publication of an amendment with a tag and a GitHub release. 

- **Tag name:** date of final approval in `YYYY-MM-DD` format. 
  If that tag already exists, append with `-2`, `-3`, and so on.
- **Tag target:** the `[bot]` commit that rebuilt `main.pdf` after the released amendment, so the tagged commit's PDF reflects the published text.
- **Release notes:** list each motion included, with its minutes and archive citations, and any errata or ministerial commits made since the previous release.

**The authoritative published copy is `main.pdf` at the tagged commit.** Since Git tracks it, it is preserved in every clone, and later formatting changes do not alter it.

You may create releases through the GitHub Releases page.
Everything legally relevant is already recorded in the commit trailers, 
so release notes are a convenience and you lose nothing if they are not carried to another platform.

The errata and ministerial commits do not get their own release. 
You must report each one to the adopting body at its next meeting, and list them in the next release.

## Formatting and submodule changes 

Formatting lives only in `uniondoc.cls`. 
Content repositories never work around formatting issues locally.
Fix any gaps in formatting and other common assets (e.g. fonts, images, etc.) in `union-docs-commons`.

- A submodule bump is always it's own `build:` commit. 
  Do not pair it with an amendment or any other edit.

- State any visible changes from a bump in the commit body (e.g. different pagination).

- When `union-docs-common` changes, bump every content repository to the same commit. 
  The maintainer checks at least once per semester that all repositories pin the same commit.
  
## Platform independence 

The repositories are hosted on GitHub, but the record must not depend on GitHub.

- Everything legally relevant lives in Git itself: 
  document text, adopted sources, compiled PDFs, commit trailers, and tags. 
  Pull request discussions, reviews, and build artifacts are working surfaces only.
  
- Build logic lives in `.latexmkrc`. 
  Workflow files only call `latexmk`, so the build can be moved to another CI system with little effort.

- Commit adopted sources to Git so the record survives even if you lose the motion archive. 

- A push mirror will exist in <https://github.rpi.edu>. 

## Repository configuration 

Configure every document repository as follows:

- **Merging:** squash merging only. 
  Set the default squash commit message to "Pull request title and description."
  
- **Branches:** automatically delete head branches after merge.

- **Protection on `main`:** block force pushes and branch deletion. 
  Do not require reviews or status checks, so an officer is never locked out of publishing.
  
- **Pull request template:** `.github/pull_request_template.md`, copied from the master copy in `union-docs-common/templates/`.

- **Workflows:** the publish workflow runs on main only. 
  A build-check workflow runs on pull requests, compiles the document, and uploads the preview PDF.
  It commits and publishes nothing. 
  The preview PDF is available to signed-in users for the preparer to download and send on.


## Changes to this SOP

Changes to this SOP are `docs:` commits to `union-docs-common`, approved by the Web Technologies Group Chair.

## Appendix A: Verifiers

| **Body**              | **Verifier**                                  | **Backup**             |
|-----------------------|-----------------------------------------------|------------------------|
| Student Senate        | Rules & Administration Committee Chair        | Grand Marshal          |
| Executive Board       | Vice President for Rules and Special Projects | President of the Union |
| Judicial Board        | J-Board Chair                                 |                        |
| Graduate Council      | Graduate President                            |                        |
| Undergraduate Council | Undergraduate President                       |                        |

