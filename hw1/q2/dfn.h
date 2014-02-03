/* $Revision: 1.2 $ */
/* $Author: christos $ */
/* $Id: dfn.h,v 1.2 2001/02/11 16:17:03 christos Exp $ */

#ifndef HUGE
    #define HUGE 10000000
#endif


#ifndef _dfn_h
    #define _dfn_h

   #ifndef NULL
   #define NULL 0
   #endif

   #ifndef __NUMBER
      typedef double NUMBER;
   #endif
   #ifndef __BOOLEAN
      typedef int BOOLEAN;
      #define TRUE 1
      #define FALSE 0
   #endif

    #define MAXLEN 200
    #define EOS '\0'
    #define MYHUGE HUGE

    #include <stdio.h>
    #include <string.h>
    #include <assert.h>
    #include <math.h>
#endif

