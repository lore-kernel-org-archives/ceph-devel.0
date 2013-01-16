From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: [PATCH] configure.ac: fix problem with --enable-cephfs-java
Date: Wed, 16 Jan 2013 12:30:49 -0800
Message-ID: <FF896BCD-EA01-4FC9-9C7B-DD461275C897@inktank.com>
References: <1358340017-26454-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:35932 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab3APUbB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 15:31:01 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so283793pbc.40
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 12:31:01 -0800 (PST)
In-Reply-To: <1358340017-26454-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Gregory Farnum <gregory.farnum@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Thanks Danny.  Patch has been merged into master.

Cheers,
Gary

On Jan 16, 2013, at 4:40 AM, Danny Al-Gaaf wrote:

> The AS_IF used to cover java related checks via --enable-cephfs-java
> didn't work correctly. Use a plain 'if/fi' instead to make sure this
> section is only executed if --enable-cephfs-java is used.
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
> configure.ac | 66 ++++++++++++++++++++++++++++++------------------------------
> 1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 32814b8..b67e5cd 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -263,15 +263,15 @@ AM_CONDITIONAL(WITH_TCMALLOC, [test "$HAVE_LIBTCMALLOC" = "1"])
> #   - this might become bigger. maybe should be own m4 file
> #
> AC_ARG_ENABLE(cephfs-java,
> -    AC_HELP_STRING([--enable-cephfs-java], [build libcephfs Java bindings]),
> +    [AC_HELP_STRING([--enable-cephfs-java], [build libcephfs Java bindings])],
>     [], [enable_cephfs_java=no])
> 
> -AM_CONDITIONAL(ENABLE_CEPHFS_JAVA, test "x$enable_cephfs_java" = "xyes")
> +AM_CONDITIONAL(ENABLE_CEPHFS_JAVA, [test "x$enable_cephfs_java" = "xyes"])
> 
> AC_ARG_WITH(jdk-dir,
>     AC_HELP_STRING([--with-jdk-dir(=DIR)], [Path to JDK directory]))
> 
> -AS_IF([test "x$enable_cephfs_java" = "xyes"], [
> +if test "x$enable_cephfs_java" = "xyes"; then
> 
> 	# setup bin/include dirs from --with-jdk-dir (search for jni.h, javac)
> 	AS_IF([test -n "$with_jdk_dir"], [
> @@ -293,36 +293,36 @@ AS_IF([test "x$enable_cephfs_java" = "xyes"], [
> 		   AS_IF([test -r "$jnih"], [
> 				  EXTRA_JDK_INC_DIR=`dirname $jnih`])])
> 
> -  # cephfs_java_test only makes sense if java is already turned on
> +        # cephfs_java_test only makes sense if java is already turned on
> 	# setup CLASSPATH for Debian default junit4.jar package 
> -    #
> -    # Configuring --with-debug and --enable-cephfs-java will throw an error if
> -    # JUnit4 cannot be found. While currently this works for users who have
> -    # installed via the package manager on Ubuntu, we need to expand this
> -    # check to 1) support other distrubtions and 2) allow users to influence
> -    # the search path.
> -  AS_IF([test "x$with_debug" = "xyes"], [
> -      dir='/usr/share/java'
> -      junit4_jar=`find $dir -name junit4.jar | head -n 1`
> -		  AS_IF([test -r "$junit4_jar"], [
> -	      EXTRA_CLASSPATH_JAR=`dirname $junit4_jar`/junit4.jar
> -      AC_SUBST(EXTRA_CLASSPATH_JAR)
> -      [have_junit4=1]], [
> -      AC_MSG_NOTICE([Cannot find junit4.jar (apt-get install junit4)])
> -      [have_junit4=0]])])
> -
> -      AC_CHECK_CLASSPATH
> -      AC_PROG_JAVAC
> -      AC_PROG_JAVAH
> -      AC_PROG_JAR
> -
> -      CLASSPATH=$CLASSPATH:$EXTRA_CLASSPATH_JAR
> -      export CLASSPATH
> -      AC_MSG_NOTICE([classpath - $CLASSPATH])
> -      AS_IF([test "$have_junit4" = "1"], [
> -	    AC_CHECK_CLASS([org.junit.rules.ExternalResource], [], [
> -	    AC_MSG_NOTICE(Could not find org.junit.rules.ExternalResource)
> -	    have_junit4=0])])
> +        #
> +        # Configuring --with-debug and --enable-cephfs-java will throw an error if
> +        # JUnit4 cannot be found. While currently this works for users who have
> +        # installed via the package manager on Ubuntu, we need to expand this
> +        # check to 1 support other distrubtions and 2 allow users to influence
> +        # the search path.
> +        AS_IF([test "x$with_debug" = "xyes"], [
> +        	dir='/usr/share/java'
> +	        junit4_jar=`find $dir -name junit4.jar | head -n 1`
> +		AS_IF([test -r "$junit4_jar"], [
> +		      EXTRA_CLASSPATH_JAR=`dirname $junit4_jar`/junit4.jar
> +		      AC_SUBST(EXTRA_CLASSPATH_JAR)
> +		      [have_junit4=1]], [
> +		      AC_MSG_NOTICE([Cannot find junit4.jar (apt-get install junit4)])
> +		      [have_junit4=0]])])
> +
> +        AC_CHECK_CLASSPATH
> +        AC_PROG_JAVAC
> +        AC_PROG_JAVAH
> +        AC_PROG_JAR
> +
> +        CLASSPATH=$CLASSPATH:$EXTRA_CLASSPATH_JAR
> +        export CLASSPATH
> +        AC_MSG_NOTICE([classpath - $CLASSPATH])
> +        AS_IF([test "$have_junit4" = "1"], [
> +		AC_CHECK_CLASS([org.junit.rules.ExternalResource], [], [
> +		AC_MSG_NOTICE(Could not find org.junit.rules.ExternalResource)
> +		have_junit4=0])])
> 
>         # Check for jni.h
> 	CPPFLAGS_save=$CPPFLAGS
> @@ -339,7 +339,7 @@ AS_IF([test "x$enable_cephfs_java" = "xyes"], [
> 
> 	# Setup output var
> 	AC_SUBST(JDK_CPPFLAGS)
> -])
> +fi
> AM_CONDITIONAL(HAVE_JUNIT4, [test "$have_junit4" = "1"])
> 
> # jni?
> -- 
> 1.8.1
> 

