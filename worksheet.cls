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

% No header or footer
\pagestyle{empty}

% Define counters for questions and parts
\newcounter{questioncounter}
\newcounter{partcounter}[questioncounter]

% Width of the question number column
\newlength{\questionIndent}
\setlength{\questionIndent}{1cm}

% Parts block with specified number of columns
\NewDocumentCommand{\parts}{O{3} m}{%
  \hspace*{\questionIndent}%
  \begin{minipage}[t]{\dimexpr\linewidth-\questionIndent\relax}%
    \begin{multicols}{#1}\raggedcolumns
      #2
    \end{multicols}%
  \end{minipage}%
}

% Format for question numbers
\renewcommand{\thequestioncounter}{\arabic{questioncounter}.}

% Format for part letters
\renewcommand{\thepartcounter}{(\alph{partcounter})}

% Helper command for question parts
\RenewDocumentCommand{\part}{m}{%
  \stepcounter{partcounter}%
  \noindent
  \makebox[0cm][l]{\thepartcounter}%
  \hspace{1cm}#1\par%
}


% Question block with indented content and number
\NewDocumentEnvironment{question}{+b}{%
  \stepcounter{questioncounter}%
  \setcounter{partcounter}{0}%
  \noindent
  \begin{tabularx}{\textwidth}{@{}p{1cm}@{}X@{}}
    \thequestioncounter &
    \begin{minipage}[t]{\dimexpr\linewidth-\questionIndent\relax}%
      #1
    \end{minipage}%
  \end{tabularx}%
  \vspace{1\baselineskip}%
}

% Removed obsolete \endquestion