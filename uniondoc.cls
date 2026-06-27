\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uniondoc}[2026/04/16 Rensselaer Union document class]

\LoadClass[11pt]{report}

%% Packages
\RequirePackage[
  top=1in,
  bottom=1in,
  left=1.2in,
  right=1.2in,
]{geometry}
\RequirePackage{fontspec}
\RequirePackage{xcolor}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{footmisc}
\RequirePackage{hyperref}
\RequirePackage{titlesec}
\RequirePackage{graphicx}
\RequirePackage{tocloft}
\RequirePackage{etoolbox}
\RequirePackage[skip=10pt]{parskip}

%% Branding (override with \orgname{...}, \orgshort{...}, \logopath{...}, \amendeddate{...})
\newcommand{\UnionDocOrgName}{Rensselaer Union}
\newcommand{\UnionDocOrgShort}{}
\newcommand{\UnionDocLogoPath}{{}}
\newcommand{\UnionDocAmendedDate}{}
\newcommand{\UnionDocType}{Bylaws}
\newcommand{\UnionDocTitle}{The \UnionDocType\ of the \UnionDocOrgName}
\newcommand{\orgname}[1]{\renewcommand{\UnionDocOrgName}{#1}}
\newcommand{\orgshort}[1]{\renewcommand{\UnionDocOrgShort}{#1}}
\newcommand{\logopath}[1]{\renewcommand{\UnionDocLogoPath}{#1}}
\newcommand{\amendeddate}[1]{\renewcommand{\UnionDocAmendedDate}{#1}}
\newcommand{\doctype}[1]{\renewcommand{\UnionDocType}{#1}}
\newcommand{\doctitle}[1]{\renewcommand{\UnionDocTitle}{#1}}

%% Colors
\definecolor{UnionBlack}{HTML}{000000}
\definecolor{UnionWhite}{HTML}{FFFFFF}
\definecolor{UnionRed}{HTML}{D6001C}
\definecolor{UnionGray}{HTML}{231F20}

\hypersetup{
  colorlinks=true,
  linkcolor=UnionRed,
  urlcolor=UnionRed,
  citecolor=UnionRed,
}

%% Font
\defaultfontfeatures{Ligatures=TeX}
\setmainfont{Lato}

\protected\def\fauxsc#1{%
  \begingroup\edef\x{\endgroup\noexpand\fauxschelper#1 \noexpand\relax\noexpand\relax}\x}
\protected\def\fauxschelper#1 #2\relax{%
  \fauxschelphelp#1\relax\relax%
  \if\relax#2\relax\else\ \fauxschelper#2\relax\fi%
}
\def\Hscale{.83}\def\Vscale{.72}\def\Cscale{1.00}
\protected\def\fauxschelphelp#1#2\relax{%
  \ifnum`#1=\lccode`#1\relax\scalebox{\Hscale}[\Vscale]{\char\uccode`#1}\else%
    \scalebox{\Cscale}[1]{#1}\fi%
  \ifx\relax#2\relax\else\fauxschelphelp#2\relax\fi}

%% Articles/sections
\makeatletter
\patchcmd{\chapter}{\clearpage}{}{}{}
\makeatother

\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thesection}{\arabic{section}}

\titleformat{\chapter}{\Large\bfseries\color{UnionRed}\center}
{\MakeUppercase{Article} \thechapter: }{0pt}{\MakeUppercase}

\titleformat{\section}{\normalsize\bfseries\color{UnionGray}}{Section \thesection. }{0pt}{}

\titlespacing*{\chapter}{0pt}{0pt}{0pt}
\titlespacing*{\section}{0pt}{2ex}{0.55em}

\newcommand{\article}{\chapter}

%% Enumeration
\setlist[enumerate,1]{label=(\arabic*), leftmargin=*, parsep=5pt}
\setlist[enumerate,2]{label=(\alph*)}
\setlist[enumerate,3]{label=(\roman*)}
\setlist[enumerate,4]{label=(\Alph*)}

%% Title page
\renewcommand{\maketitle}{
  \begin{titlepage}
    \centering

    \vspace*{2cm}
    \IfFileExists{\UnionDocLogoPath}{
      \includegraphics[width=2.85in]{\UnionDocLogoPath}
    }{
      {\huge\bfseries\color{UnionRed} Rensselaer Union\par}
    }

    \vspace{1.5cm}

    {\LARGE\bfseries\color{UnionBlack}\UnionDocTitle\par}

    \vspace{1cm}

    {\normalsize As amended: \UnionDocAmendedDate\par}

    \vspace{0.5cm}
  \end{titlepage}
}

%% TOC
\renewcommand{\cftchappresnum}{Article }
\setlength{\cftchapnumwidth}{6em}
\renewcommand{\cftchapdotsep}{\cftdotsep}
\setlength{\cftsecindent}{6em}
\renewcommand{\cfttoctitlefont}{\hfill\Large\bfseries\color{UnionBlack}}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftsecfont}{\color{UnionBlack}}
\renewcommand{\cftsecpagefont}{\color{UnionBlack}}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\setcounter{tocdepth}{0}

%% Header/footer
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\fauxsc{\UnionDocOrgName}}
\fancyhead[R]{\fauxsc{\UnionDocType}}
\fancyfoot[C]{\thepage}
\setlength{\headheight}{13.59999pt}
\addtolength{\topmargin}{-1.59999pt}

\fancypagestyle{plain}{\pagestyle{fancy}}

%% Amendments
\newcounter{amendmentctr}
\newcommand{\amendments}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Amendments}%
  {\centering\LARGE\bfseries\color{UnionRed} LIST OF AMENDMENTS\par}%
  \vspace{0.75em}%
}
\newcommand{\amendment}[1]{%
  \stepcounter{amendmentctr}%
  %\vspace{2ex}%
  {\Large\bfseries\color{UnionRed}\centering
    \MakeUppercase{Amendment \Roman{amendmentctr}}\par}%
  \vspace{0.25em}%
  {\large\bfseries\centering\MakeUppercase{#1}\par}%
  %\vspace{0.75em}%
  \setcounter{section}{0}%
}
\newcommand{\amendmentinfo}[1]{%
  \vspace{-\parskip}%
  {\centering\small #1\par}%
  \vspace{0.75em}%
}

%% Auto-emit front matter
\AtBeginDocument{%
  \maketitle
  \tableofcontents
  \newpage
}
