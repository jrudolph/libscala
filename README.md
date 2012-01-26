Tools for scala developers.  I have a lot more but it is going to take
me some time to organize everything.

Usage:

    source /path/to/libscala.sh   # add to your .profile or similar
    ./git-java/install.sh         # run this one time

If you're lucky, that's it.  Examples of available things:

    gh-commit <sha|svn> # accepts sha-1 or rev, shows in browser.  Tab-completion on svn revs!
    java -XX:           # tab-completion on java -XX: options (a tad verbose at the moment)
    scala -J-XX:        # also completes on -J-XX: options
    gco <tab>           # a git checkout which completes on local branches only
    gh-find Global      # open a browser to those files in trunk matching Global

The git-java part enables you to check jars and *.class files into a
git repository and see a useful diff.  After you run ./git-java/install.sh,
it will tell you to run git-java/demo.sh.  Do so.  You should see this:

```diff
diff --git c/A.class w/A.class
index eb57cde27f..ec9040dd7d 100644
--- c/A.class
+++ w/A.class
@@ -16,14 +16,19 @@ public final class A extends java.lang.Object implements scala.ScalaObject{
 public scala.Option f(int);
   Signature: (I)Lscala/Option;
   Code:
-##:    new     ###; //class A$$anonfun$f$##
-##:    dup
 ##:    iload_1
-##:    invokespecial   ###; //Method A$$anonfun$f$##."<init>":(LA;I)V
-##:    new     ###; //class A$$anonfun$f$##
+##:    iconst_5
+##:    if_icmple       ##
+##:    iconst_1
+##:    goto    ##
+##:    ifeq    ##
+##:    new     ###; //class scala/Some
 ##:    dup
 ##:    iload_1
-##:    invokespecial   ###; //Method A$$anonfun$f$##."<init>":(LA;I)V
+##:    invokestatic    ###; //Method scala/runtime/BoxesRunTime.boxToInteger:(I)Ljava/lang/Integer;
+##:    invokespecial   ###; //Method scala/Some."<init>":(Ljava/lang/Object;)V
+##:    goto    ##
+##:    getstatic       ###; //Field scala/None$.MODULE$:Lscala/None$;
 ##:    areturn
```

And for the hotspot junkie in your life:

```bash
% java -XX:<tab>
Display all 998 possibilities? (y or n)
% java -XX:+Print<tab>
-XX:+PrintAdaptiveSizePolicy              -XX:+PrintJavaStackAtFatalState
-XX:+PrintClassHistogram                  -XX:+PrintJNIGCStalls
-XX:+PrintClassHistogramAfterFullGC       -XX:+PrintJNIResolving
-XX:+PrintClassHistogramBeforeFullGC      -XX:+PrintOldPLAB
-XX:+PrintCMSInitiationStatistics         -XX:+PrintOopAddress
-XX:+PrintCommandLineFlags                -XX:+PrintParallelOldGCPhaseTimes
-XX:+PrintCompilation                     -XX:+PrintPLAB
-XX:+PrintConcurrentLocks                 -XX:+PrintPreciseBiasedLockingStatistics
-XX:+PrintFlagsFinal                      -XX:+PrintPromotionFailure
-XX:+PrintFlagsInitial                    -XX:+PrintReferenceGC
-XX:+PrintGC                              -XX:+PrintRevisitStats
-XX:+PrintGCApplicationConcurrentTime     -XX:+PrintSafepointStatistics
-XX:+PrintGCApplicationStoppedTime        -XX:+PrintSharedSpaces
-XX:+PrintGCDateStamps                    -XX:+PrintTenuringDistribution
-XX:+PrintGCDetails                       -XX:+PrintTieredEvents
-XX:+PrintGCTaskTimeStamps                -XX:+PrintTLAB
-XX:+PrintGCTimeStamps                    -XX:+PrintVMOptions
-XX:+PrintHeapAtGC                        -XX:+PrintVMQWaitTime
-XX:+PrintHeapAtGCExtended                -XX:+PrintWarnings
-XX:+PrintHeapAtSIGBREAK                  
```
