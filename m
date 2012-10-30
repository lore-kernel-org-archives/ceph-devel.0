From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Setup for building Java unit tests
Date: Mon, 29 Oct 2012 17:22:23 -0700
Message-ID: <CAPrxi5_jSv9Z-S-RNjF0mrFjgEnXuGt79=+JZx11G0PL=oaJcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64792 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab2J3AWY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 20:22:24 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so5974921vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 17:22:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Buck <buck@soe.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is my proposal for handling Java unit test compilation:

1. Go with Joe's suggestion to backport the unit tests to the oldest
version of JUnit shipping with the latest Ubuntu and Fedora.

2. Use --with-debug to enable unit test building:

 --enable-cephfs-java: no change
 --with-debug --enable-cephfs-java: builds Java tests

3. configure.ac tests for JUnit dependency in the --with-debug case
using (a) the common distribution paths (b) the CLASSPATH environment
variable. Stash location in an autoconf variable for Makefile.am to
use.

Running the tests from teuthology:

The two dependencies are JUnit (above approach) and a test runner.
Currently that runner is an Ant build script. Installing that script
for a --with-debug build in a place like /usr/share/.. is an option,
but seems like overkill just to get the teuthology tests going.

How about instead we either 1) write a simple runner (few lines of
java code) and include it in the test jar, or 2) stash a minimal
Ant-based runner in the teuthology setup script that creates the Ant
script at run time. Something like:

cat << EOF > build.xml
<target name="test>
   blah blah
</target>
EOF
