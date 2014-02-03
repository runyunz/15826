/* $Revision: 1.1 $ */
/* $Author: christos $ */
/* $Id: kdtree.h,v 1.1 2001/02/11 16:16:03 christos Exp $ */
/* Modified: runyunz - Fall 2013 */

#ifndef __kdtree_h
  #define __kdtree_h
  #include <stdio.h>
  #include <stdlib.h>
  #include <assert.h>
  #include "vector.h"
  #include "dfn.h"
  
  /* tree node */
  typedef struct TreeNode { 
     struct TreeNode *left;
     struct TreeNode *right;
     VECTOR *pvec;
  } TREENODE;
  
  /* insert a vector into the tree, and return the new root */
  TREENODE *insert(TREENODE *subroot, VECTOR *vp);

  /* recursive insert, using the level info */
  TREENODE *rinsert(TREENODE *subroot, VECTOR *vp, int level);

  TREENODE *talloc();
  void tfree();

  /* prints the whole tree - for debugging purposes */
  void tprint(TREENODE *subroot);
  void rtprint(TREENODE *subroot, int level);

  /* returns the 'count' nearest neighbors in the subtree */
  /* Modified: runyunz - Fall 2013 */
  void nnsearch(TREENODE *subroot, VECTOR *vp, int count);
  VECTOR *rnnsearch(TREENODE *subroot, VECTOR *vp, VECTOR *best, int level, VECTOR** bests, int count);
  
  /* Added: runyunz - Fall 2013 */
  void save_knn(VECTOR* best, VECTOR** bests, int count, VECTOR* vp);


  void rangesearch(TREENODE *subroot, VECTOR *vpLow, VECTOR *vpHigh);
  void rrangesearch(TREENODE *subroot, VECTOR *vpLow, VECTOR *vpHigh, int level);

   BOOLEAN contains( VECTOR *vpLow, VECTOR *vpHigh, VECTOR *vp);

   NUMBER myvecdist2( VECTOR *vp1, VECTOR *vp2);

#endif
