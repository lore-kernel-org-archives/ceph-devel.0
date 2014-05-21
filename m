From: Noah Watkins <noah.watkins@inktank.com>
Subject: Packaging RFC for cephfs-java
Date: Wed, 21 May 2014 12:34:17 -0700
Message-ID: <CA+Hcz5_Fu=2e0o0oGeKpg7oAHdjtEBgq_W5z0k8uVe0L0jXJ=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:35701 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbaEUTeS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 May 2014 15:34:18 -0400
Received: by mail-qc0-f169.google.com with SMTP id e16so4057027qcx.28
        for <ceph-devel@vger.kernel.org>; Wed, 21 May 2014 12:34:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>

Hey ceph-devel,

In its current form deploying any software that depends on
`cephfs-java` can be a real pain! Users need to make sure they have
one of each of the following installed:

* platform-indep: libcephfs.jar
* platform-dep: libcephfs_jni.[so,dylib,...]
    - osx/linux * x86/x86-64 * etc...

We build RPM and Debian packages for both, but that doesn't solve the
following dependency problems. First, The JVM needs to be told about
the locations of the native library via a special "java.library.path"
property specified when the JVM starts, and the JVM doesn't always
look in the places that the RPM/Deb packages stick the binaries.
Projects like Hadoop invoke the JVM deep within shell scripts, so
getting these dependencies to resolve has been a continuous source of
frustration for users. The second problem is that users expect easy
dependency management using solutions like Maven Central, and so
currently dealing with the libcephfs.jar turns into a special case in
the deployment procedure.

We solve the second problem by publishing our artifacts into Maven
Central. That is pretty easy, but the problem of resolving the native
library dependencies remain. There are two ways to deal with this
challenge.

First, several projects (e.g. JNA and LevelDB-Java) embed everything,
including pre-built libraries for all supported platforms into a
single JAR file, and the native library is transparently loaded at
run-time. I've create a POC that shows how to do this:

   http://github.com/ceph/ceph wip-native-cephfs-java

This approach is ideal from a users approach, but means more
packaging/shipping complexity.

The second approach would depend on the current RPM/Deb installation,
and we could manually search for these in well-known places. This
could work I suppose, but it still requires that extra step to
rendezvous deps from Maven and yum/apt.

Any thoughts welcome!

-Noah
