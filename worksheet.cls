\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{worksheet}[2025/03/15 Custom class for mathematics worksheets]

% Base this class on the standard article class
\LoadClass[a4paper]{article}

% Required packages
\RequirePackage[margin=2cm]{geometry} % Page geometry
\RequirePackage{array}                % Enhanced table features
\RequirePackage{amsmath}              % For math environments
\RequirePackage{multicol}             % For multiple columns
\RequirePackage{calc}                 % For width calculations

% No header or footer
\pagestyle{empty}

% Define counters for questions and parts
\newcounter{questioncounter}
\newcounter{partcounter}[questioncounter]

% Format for question numbers
\renewcommand{\thequestioncounter}{\arabic{questioncounter}.}

% Format for part letters
\renewcommand{\thepartcounter}{(\alph{partcounter})}

% Command to set the number of columns for parts
\newcommand{\setpartcolumns}[1]{\def\partcolumns{#1}}
\setpartcolumns{3} % Default to 3 columns

% Helper command for question parts
\renewcommand{\part}[1]{%
  \stepcounter{partcounter}%
  \noindent%
  \makebox[1cm][l]{\thepartcounter}#1\par%
}

% For backward compatibility
\newcommand{\questionpart}[1]{%
  \stepcounter{partcounter}%
  \makebox[1cm][l]{\thepartcounter}#1\par%
}

% Basic question without parts
\makeatletter
\def\question{\@ifnextchar[{\@questionopt}{\@questionnoopt}}

\def\@questionopt[#1]#2{%
  \stepcounter{questioncounter}%
  \setcounter{partcounter}{0}%
  \noindent%
  \makebox[1cm][l]{\thequestioncounter}%
  \def\partcolumns{#1}%
  \setlength{\columnsep}{10pt}% Set column separation
  \setlength{\columnseprule}{0pt}% No rule between columns
  \begin{multicols}{\partcolumns}%
  #2%
  \end{multicols}%
  \par\vspace{\baselineskip}%
}

\def\@questionnoopt#1{%
  \@ifnextchar\bgroup{\@questionwithintro{#1}}{\@questionbasic{#1}}%
}

\def\@questionbasic#1{%
  \stepcounter{questioncounter}%
  \setcounter{partcounter}{0}%
  \noindent%
  \makebox[1cm][l]{\thequestioncounter}#1\par\vspace{\baselineskip}%
}

\def\@questionwithintro#1#2{%
  \stepcounter{questioncounter}%
  \setcounter{partcounter}{0}%
  \noindent%
  \makebox[1cm][l]{\thequestioncounter}#1\par%
  \noindent\hspace{1cm}%
  \setlength{\columnsep}{10pt}% Set column separation
  \setlength{\columnseprule}{0pt}% No rule between columns
  \begin{multicols}{\partcolumns}%
  #2%
  \end{multicols}%
  \par\vspace{\baselineskip}%
}
\makeatother

% Question with introduction and parts (backward compatibility)
\newcommand{\questionwithintro}[2]{%
  \stepcounter{questioncounter}%
  \setcounter{partcounter}{0}%
  \noindent%
  \makebox[1cm][l]{\thequestioncounter}#1\par%
  \noindent\hspace{1cm}%
  \setlength{\columnsep}{10pt}% Set column separation
  \setlength{\columnseprule}{0pt}% No rule between columns
  \begin{multicols}{\partcolumns}%
    #2%
  \end{multicols}%
  \par\vspace{\baselineskip}%
}