\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{worksheet}[2025/03/15 Custom class for mathematics worksheets]

% Base this class on the standard article class
\LoadClass[a4paper]{article}

% Required packages
\RequirePackage[margin=2cm]{geometry}
\RequirePackage{amsmath}
\RequirePackage{multicol}
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage{tabularx}

% Width of the question-number column
\newlength{\questionIndent}
\setlength{\questionIndent}{1cm}

% Helper to indent & typeset the parts block
% #1 = number of columns, #2 = the \part{…} code
\newcommand{\wsc@printparts}[2]{%
  \hspace*{\questionIndent}%
  \begin{minipage}[t]{\dimexpr\linewidth-\questionIndent\relax}%
    \begin{multicols}{#1}\raggedcolumns
      #2
    \end{multicols}%
  \end{minipage}%
}

% No header or footer
\pagestyle{empty}

% Define counters for questions and parts
\newcounter{questioncounter}
\newcounter{partcounter}[questioncounter]

% Format for question numbers
\renewcommand{\thequestioncounter}{\arabic{questioncounter}.}

% Format for part letters
\renewcommand{\thepartcounter}{(\alph{partcounter})}

% Helper command for question parts
\RenewDocumentCommand{\part}{m}{%
  \stepcounter{partcounter}%
  \noindent
  \makebox[1cm][l]{\thepartcounter}%
  #1\par%
}

% Command to set the number of columns for parts
\newcommand{\setpartcolumns}[1]{\def\partcolumns{#1}}
\setpartcolumns{3} % Default to 3 columns

% Two-column container for every question:
\NewDocumentCommand{\question}{O{\partcolumns} m m}{%
  \stepcounter{questioncounter}%
  \setcounter{partcounter}{0}%
  % Begin a 2-col box:
  \noindent
  \begin{tabularx}{\textwidth}{@{}p{1cm}@{}X@{}}
    % Col 1: question number
    \thequestioncounter
    &
    % Col 2: either intro+parts or parts-only
    \ifblank{#2}{
      \wsc@printparts{#1}{#3}
    }{
      % intro+parts
      #2\par
      \wsc@printparts{#1}{#3}
    }
  \end{tabularx}%
  \vspace{1\baselineskip}%
}