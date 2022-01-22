\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{layout/SLIITeXFormalReport}[22-01-2022 v0.1.0 SLIITeX Formal Report Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[12pt, oneside]{book}

%%%%%%%%%%%%%%%%%%%%% Main packages in the document %%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{amsmath}                % Mathematics
\RequirePackage{amssymb}                % Symbols
\RequirePackage{siunitx}                % Various functions, e.g. \num{}

\RequirePackage{tabularx}               % Additional functions to tables
\RequirePackage{booktabs}               % Adds more line functionality to tables
\RequirePackage{longtable}              % Lets tables break over page
\RequirePackage{multirow}               % Counterpart of multi columns
\RequirePackage{enumitem}               % Customise the list spacing

\RequirePackage{geometry}               % Document geometry
\RequirePackage{titlesec}               % Custom titles
\RequirePackage{titletoc}               % Custom table of contents
\RequirePackage{fancyhdr}               % Custom header/footer
\RequirePackage[hidelinks]{hyperref}    % Improved referencing/links

\RequirePackage{graphicx}               % Adding images
\RequirePackage{float}                  % Additional float parameters
\RequirePackage[
    labelfont=bf,
    justification=centering,
    footnotesize
]{caption}                              % Captions
\RequirePackage{subcaption}             % Subfigures and subcaptions
\RequirePackage{xcolor}                 % Using colours in documents
\RequirePackage{tikz}                   % Create graphic elements

\RequirePackage[
    style=ieee,
    backend=biber
]{biblatex}                             % Manages bibliography
\RequirePackage{datetime}               % Used in preface for monthname
\RequirePackage{microtype}              % Refinements towards typographical perfection
\RequirePackage[nottoc]{tocbibind}      % Add the lists to the table of contents
\RequirePackage{xspace}                 % Ensures correct spacing after macros like \deg
\RequirePackage{etoolbox}               % General toolbox (i.e. \ifdefvoid)
\RequirePackage{iftex}                  % Adds if-else statements to support multiple compilers
\RequirePackage{kantlipsum}             % For placeholder text generation
\RequirePackage[export]{adjustbox}      % Image positioning

%%%%%%%%%%%%%%%%%%%%% General Definitions %%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\title}[1]{
    \def\@title{#1}
    \hypersetup{pdftitle=#1}
}

\renewcommand{\author}[1]{
    \def\@author{#1}
    \hypersetup{pdfauthor=#1}
}

\newcommand\registrationno[1]{\def\@registrationno{#1}}
\newcommand\specialization[1]{\def\@specialization{#1}}
\newcommand\supervisorname[1]{\def\@supervisorname{#1}}
\newcommand\department[1]{\def\@department{#1}}
\newcommand\modulename[1]{\def\@modulename{#1}}

\geometry{a4paper,hscale=0.75,vscale=0.75}

\def\sectionautorefname{Section}
\def\chapterautorefname{Chapter}
\let\subsectionautorefname\sectionautorefname
\let\subsubsectionautorefname\sectionautorefname

%%%%%%%%%%%%%%%%%%%%% Bibliography %%%%%%%%%%%%%%%%%%%%%%%

\addbibresource{main.bib} % Specifying the .bib file
\setlength\bibitemsep{0.7\itemsep} % More spacing to improve readability

%% Prevent urls running into margins in bibliography
\setcounter{biburlnumpenalty}{7000}
\setcounter{biburllcpenalty}{7000}
\setcounter{biburlucpenalty}{7000}

%%%%%%%%%%%%%%%%%%%%% Fonts Configuration %%%%%%%%%%%%%%%%%%%%%%%

\ifPDFTeX
    %% pdfLaTeX is only available for compatibility, but not recommended.
    \RequirePackage[T1]{fontenc} % Fixes possible encoding issues

    %% Defining commands to be used in layout
    \renewcommand{\rmdefault}{phv}
    \renewcommand{\sfdefault}{phv}
    \def\largetitlestyle{}
    \def\titlestyle{}

    %% Warning when using pdfLaTeX
    \@latex@warning@no@line{You are using pdfLaTeX as compiler. Consider changing the compiler to XeLaTeX or LuaLaTeX to adhere to the SLIITeX style}
\else
    %% If XeLaTeX or LuaLaTeX is set as the compiler, the SLIITeX style fonts are used
    \RequirePackage{fontspec} % Custom fonts

    %% Adding the various fonts
    \setmainfont{Times New Roman}
    \setmathsf{Times New Roman}
    \setmathtt{Times New Roman}

    \newfontfamily\quotefont{Georgia}

    %% Changing the quote environment to use Georgia
    \AtBeginEnvironment{quote}{\quotefont}
\fi

%% Common font size definitions
\newcommand\SizeA{
    \fontsize{24pt}{24pt}\selectfont
}
\newcommand\SizeB{
    \fontsize{20pt}{20pt}\selectfont
}
\newcommand\SizeC{
    \fontsize{16pt}{16pt}\selectfont
}
\newcommand\SizeD{
    \fontsize{14pt}{14pt}\selectfont
}


%%%%%%%%%%%%%%%%%%%%% Header/Footer Configuration %%%%%%%%%%%%%%%%%%%%%%%

%% Adding a head rule to pages
% \renewcommand*\headrule{%
%     {\hrule\@height\headrulewidth\@width\headwidth}%
%     \vskip-\headrulewidth}

% %% Page style for title pages
% \fancypagestyle{plain}{%
%     \fancyhf{}
%     \renewcommand*\headrulewidth{0pt}
%     \fancyfoot[C]{\thepage}}

% %% Fancy style for the main matter, depends on oneside/twoside option
% \if@twoside%
%     \fancyhf{}
%     \fancyhead[LE,RO]{\titlestyle\thepage}
%     \fancyhead[RE]{\titlestyle\nouppercase{\leftmark}}
%     \fancyhead[LO]{\titlestyle\nouppercase{\rightmark}}
%     \RequirePackage{emptypage} % Clears empty pages
% \else%
%     \fancyhf{}
%     \fancyhead[R]{\titlestyle\thepage}
%     \fancyhead[L]{\titlestyle\nouppercase{\rightmark}}
% \fi

% \pagestyle{fancy} % Setting it to default

%% Center chapter titles
\titleformat{\chapter}[display]
  {\normalfont\huge\bfseries\centering}
  {\chaptertitlename\ \thechapter}{20pt}{\SizeB\uppercase}

% %% Customize ToC title
\renewcommand{\contentsname}{\uppercase{Table of Contents}}
\dottedcontents{chapter}[2.3em]{}{2.3em}{5pt} % Dotted-lines for Book class

%%%%%%%%%%%%%%%%%%%%% Cover Page %%%%%%%%%%%%%%%%%%%%%%%

%% Date format
\newdateformat{monthyeardate}{\monthname[\THEMONTH] \THEYEAR}

\newcommand*\makecover{
    \begin{titlepage}
        % Clearing the page and removing page number
        \clearpage
        \thispagestyle{empty}

        \begin{center}
            \includegraphics{layout/assets/sliit-logo-color}

            \SizeA
            \vspace{1cm}
            \textbf{\@title}

            \vfill

            \SizeA\text{\@author}                     \\
            \SizeC\text{(Reg. No.: \@registrationno)} \\
            \SizeB\text{\@specialization}

            \vfill

            \SizeC
            \textnormal{Supervisor: \@supervisorname}

            \vfill

            \SizeC
            \text{\monthyeardate\today}

            \vfill

            \SizeD
            \textbf{Department of \@department}         \\
            \textbf{Sri Lanka Institute of Information Technology}
        \end{center}
    \end{titlepage}
}

%%%%%%%%%%%%%%%%%%%%% Declaration Page %%%%%%%%%%%%%%%%%%%%%%%

\newcommand*\makedeclaration{
    \chapter{Declaration}
    I declare that this is my own research proposal, and this proposal does not incorporate without acknowledgement any material previously published submitted for a Degree or Diploma in any other university or institute of higher learning and to the best of my knowledge and belief it does not contain any material previously published or written by another person except where the acknowledgement is made in the text.

    \vspace{1cm}
    \renewcommand{\arraystretch}{2}
    \begin{tabular}{@{}p{2cm}p{10cm}@{}}
        Name:      & \@author \\
        Signature: & \dotfill \\
        Date:      & \dotfill
    \end{tabular}

    \vspace{1cm}
    \noindent
    I have read the proposal and it is in accordance with the approved university proposal outline. I am willing to supervise the research work of the above candidate on the proposed area.

    \vspace{1cm}
    \renewcommand{\arraystretch}{2}
    \begin{tabular}{@{}p{2cm}p{10cm}@{}}
        Name:      & \@supervisorname   \\
        Signature: & \dotfill           \\
        Date:      & \dotfill
    \end{tabular}
}

%%%%%%%%%%%%%%%%%%%%% Acknowledgement Page %%%%%%%%%%%%%%%%%%%%%%%

\newcommand*\makeacknowledgement{
    \chapter{Acknowledgement}
    This document is intended for the {\@modulename} module of the degree program of {\@specialization}. This is the output of my work with the sincere support of others.\\
    
    \noindent I sincerely express my gratitude to my supervisor, {\@supervisorname}, who guided me throughout this proposal. I would also like to thank my friends and family who supported me and offered deep insight into the study.
}
