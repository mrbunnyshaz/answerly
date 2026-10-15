Access the AI Agent here: answerly-taupe.vercel.app

# Answerly

Photograph a question from an exam paper and see the correct answer, the full working with a mark on every step, and what went wrong in your own working. When there is more than one valid way to solve it, every method is shown.

Answerly is built for students who redo whole topics without knowing why they lost marks. It works with British (GCSE / A-Level), IB, Indian (CBSE / ICSE) and American (AP / SAT) marking styles.

## What it does

- **Reads the question from a photo** and writes a model answer as numbered steps, each labelled with the mark it earns (M1, A1, B1 or a plain mark, depending on the curriculum) and a one-line reason.
- **Shows what went wrong.** It finds the first wrong step in the student's working and names the cause: concept gap, careless error, time pressure or misread question.
- **Shows every valid method**, each in its own tab.
- **Solves every question twice, separately.** The second solve never sees the first answer or the student's work. If the two final answers differ, the student sees both and a warning instead of a confident answer.
- **Teaches instead of dumping the answer.** The working stays hidden until the student has tried. They reveal it one step at a time, and an "I don't get this step" button on each line asks for a short explanation.
- **Sends doubtful answers to a teacher.** The student approves the exact text first. The teacher approves, corrects or sends back with a note, and every decision is recorded on the review.

## Safety by design

| Control | How it works |
|---|---|
| Consent | Nothing can be uploaded until the student ticks three boxes (age or guardian, photo goes to Claude, answers are AI-written). Consent is versioned and can be withdrawn at any time. |
| Data minimisation | The photo is sent only when the student presses the button. Answerly does not store it. Photo metadata is stripped before it is sent. |
| Approval gate | Copying an answer sheet and sending a review each show exactly what will leave the page and wait for a yes. Teacher decisions go through the same gate. |
| Least privilege | A student can read only their own reviews. A teacher can read what students send. The page never gets a student's photo. |
| Audit log | Every action is recorded with who, what, why, consent version, model tier and outcome. Each line carries the hash of the line before it, and a Verify button flags any line that was changed. Paper content is never logged. |
| Prompt injection | Text inside a photo is treated as exam content, never as instructions. |
| Honest labelling | Every answer says it is AI-generated study help and not an official mark scheme. |

## What runs where

Answerly is written as a single self-contained page. Three of its features use services that exist only inside the Claude app, where the page is published as an artifact:

| Feature | In the Claude app | On GitHub Pages (this repo's preview) |
|---|---|---|
| Consent screen, examples, Safety tab, audit log | Works | Works |
| Reading a photo and the two-pass check | Works, using the viewer's own Claude account | Shows "not available" |
| "I don't get this step" explanations | Works | Shows "not available" |
| Teacher queue and My reviews | Works, using the artifact's shared database | Hidden |

The preview shows the interface and the worked examples. A standalone version that works outside the Claude app needs a small server that holds the Claude API key and calls the API for the page, plus its own sign-in and database. The key must never be placed in the page itself.

## Project layout

```
src/              the page, split into parts
  part1.html      styles
  part2.html      page structure
  part3a.html     consent, audit log, tabs
  part3b.html     answer cards, step reveal, approval gate, examples
  part3c.html     photo handling and the two-pass check
  part3d.html     teacher review queue and My reviews
  part3e.html     Safety tab and demo
  preview-notice.html   notice shown outside the Claude app
build.sh          joins src/ into index.html
index.html        the built page (served by GitHub Pages)
```

## Build and run

```sh
./build.sh
python3 -m http.server 8000   # then open http://localhost:8000
```

Edit the files in `src/`, then run `./build.sh` again.

## Demo in five steps

1. Open the Audit log tab and press "Withdraw consent and clear log" to show the consent screen.
2. Upload a marked paper. Watch the two solves run, reveal the working one step at a time and press "I don't get this step".
3. In the Safety tab, press "Show a caught error". It loads a case where the second solve disagrees with the first.
4. Press "Send to my teacher" and read the approval screen. In the Teacher queue, approve, correct or send it back.
5. Open My reviews to see the decision, then the Audit log and press "Verify the log".

Steps 2 and 4 need the Claude app.

## Known limits

- The audit log lives in the student's browser, so a student can clear it. The verify button shows if a line was changed, but it cannot show a log that was wiped.
- Teacher and student roles come from the page's share settings, not from a school directory.
- Answerly can still be wrong. That is why every answer shows whether two separate solves agree, and anything doubtful is marked for a teacher.
- Two solves per question means about double the usage per photo.

## Planned

- Guardian accounts for under-18 students
- Wellbeing signals routed to a trained person
- School-level data separation and UAE data residency
- Server-side append-only audit log
- Teacher-set hint-only mode
- Arabic interface and Arabic question reading
- Crop and rotate before sending a photo
