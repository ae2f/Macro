# ae2f::Macro
> Template programming utility in C/CMake.  

# Requirements
- cmake >= 3.20
- gcc

# ae2f_MAC 
> defined in ae2f/Macro.h

> A hint for creating a macro from void-returning function.  
> Its parameters will be additional template parameters you could customise.

# Example
input.c  
```c
#include <stdio.h>

ae2f_MAC(int) Hello(int a, const int *b, int c) {
  *(b) = a;
  /** haha i got you */
}
```

output.c  
```c
#include <stdio.h>

#define _Hello( \
	/** tparam */ \
		int, \
 \
	/** param */ \
		/*  int */ a, \
		/*   const int* */ b, \
		/*   int */ c \
) { \
  *(b) = a; \
  /** haha i got you */ \
}
```

# Cmake macro
> This utility could be dynamically compiled on configuration.  

## ae2f_Macro_init
> Compiles the utility with your cmake settings.  

- prm_CMT_REQUIRED  [0/1]
    > For better-looking comments, you set it 1.  
    > Otherwise, you set it 0.

- prm_SZPARAM       [Integer]
    > Maximum size of each qualifier or type on parameters.

- prm_SZTPARAM      [Integer]
    > Maximum size of ae2f_MAC's template parameters.

## ae2f_Macro_one
> Make one file macrofied.

- prm_in    [File Path]
    > input file path

- prm_out   [File Path]
    > output file path

## ae2f_Macro_autoname
> Calls ae2f_Macro_one.

- prm_in    [File Path]
    > Its output file will be something like `/path/name.ext1.ext2.auto.extlast`
