From: Joe Buck <jbbuck@gmail.com>
Subject: Re: Setup for building Java unit tests
Date: Mon, 29 Oct 2012 23:29:26 -0700
Message-ID: <508F73C6.2040700@gmail.com>
References: <CAPrxi5_jSv9Z-S-RNjF0mrFjgEnXuGt79=+JZx11G0PL=oaJcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65280 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab2J3G3c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 02:29:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4828494pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 23:29:32 -0700 (PDT)
In-Reply-To: <CAPrxi5_jSv9Z-S-RNjF0mrFjgEnXuGt79=+JZx11G0PL=oaJcA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Joe Buck <buck@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

On 10/29/2012 05:22 PM, Noah Watkins wrote:
> This is my proposal for handling Java unit test compilation:
>
> 1. Go with Joe's suggestion to backport the unit tests to the oldest
> version of JUnit shipping with the latest Ubuntu and Fedora.
>
> 2. Use --with-debug to enable unit test building:
>
>   --enable-cephfs-java: no change
>   --with-debug --enable-cephfs-java: builds Java tests
>
> 3. configure.ac tests for JUnit dependency in the --with-debug case
> using (a) the common distribution paths (b) the CLASSPATH environment
> variable. Stash location in an autoconf variable for Makefile.am to
> use.
>
> Running the tests from teuthology:
>
> The two dependencies are JUnit (above approach) and a test runner.
> Currently that runner is an Ant build script. Installing that script
> for a --with-debug build in a place like /usr/share/.. is an option,
> but seems like overkill just to get the teuthology tests going.
>
> How about instead we either 1) write a simple runner (few lines of
> java code) and include it in the test jar, or 2) stash a minimal
> Ant-based runner in the teuthology setup script that creates the Ant
> script at run time. Something like:
>
> cat << EOF > build.xml
> <target name="test>
>     blah blah
> </target>
> EOF
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
To backfill a conversation Noah and I had offline: it turns out that 
JUnit has a command line taskrunner, so we do not need to ship the 
build.xml around nor worry about rolling our own.
If we follow the steps Noah laid out (he's going to help me modify 
configure to find the JUnit jar) then a workunit can execute the tests 
in teuthology via command line invocations (I have this working in my 
branch now, save the smarter configuration/build (item #2 above)).
We still need to backport the test code to use the older library but 
that's just a bit of time.

-Joe Buck
