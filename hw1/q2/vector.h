/* $Revision: 1.1 $ */
/* $Author: christos $ */
/* $Id: vector.h,v 1.1 2001/02/11 16:16:03 christos Exp $ */

#ifndef __vector_h
  #define __vector_h
  #include <stdio.h>
  #include <assert.h>
  #include "dfn.h"
  
  
  /* 1-d vector, with size */
  typedef struct Vector { 
     int len;
     NUMBER *vec;
  } VECTOR;
  
  
  
  VECTOR *vecalloc(int n);
  
  void vecfree( VECTOR *);
  
  NUMBER vecdist2( VECTOR *, VECTOR *); /* squared Eucl. distance */
  
  void vecput( VECTOR *pvec, int pos, NUMBER val);
  
  NUMBER vecget( VECTOR *pvec, int pos );
  
  VECTOR *veccopy( VECTOR *p);
  
  void vecprint( VECTOR *p);

#endif
