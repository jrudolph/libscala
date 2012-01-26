Tools for scala developers.

    source /path/to/libscala.sh   # add to your .profile or similar
    ./git-java/install.sh         # run this one time

If you're lucky, that's it.

    gh-commit <sha|svn> # accepts sha-1 or rev, shows in browser.  Completion on svn!
    java -XX:           # completes on java -XX: options
    scala -J-XX:        # also completes on -J-XX: options
    gco <tab>           # a git checkout which completes on local branches only
    gh-find Global      # open a browser to those files in trunk matching Global

The git-java part enables you to check jars and *.class files into a
git repository and see a useful diff.  After you run ./git-java/install.sh,
run ./git-java/demo.sh to see it in action.  If it worked, you will see this.

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

There's a lot more in my stable, but I'm still trying to organize.