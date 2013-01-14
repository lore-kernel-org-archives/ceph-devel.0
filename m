From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Mon, 14 Jan 2013 12:41:38 -0800
Message-ID: <973BE144-8E8E-4076-97C3-ACB74D84F63A@inktank.com>
References: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de> <CAPrxi58_D4PVhMAtABfKiRrXKZv0p4OUSfc+MuVkha0ndWPWxA@mail.gmail.com> <BB8FDF50-D01D-4B4A-A201-8AEA43FFFA2D@inktank.com> <50EE73F3.6050705@bisect.de> <3EC7678C-6C3D-4E59-A5ED-FC9B2DC28C08@inktank.com> <50F1DCAA.8020802@bisect.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:49061 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756868Ab3ANUlm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 15:41:42 -0500
Received: by mail-pa0-f41.google.com with SMTP id bj3so2431027pad.14
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 12:41:42 -0800 (PST)
In-Reply-To: <50F1DCAA.8020802@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Noah Watkins <jayhawk@cs.ucsc.edu>, Sage Weil <sage@inktank.com>


On Jan 12, 2013, at 1:59 PM, Danny Al-Gaaf wrote:

> Am 11.01.2013 06:13, schrieb Gary Lowell:
> [...]
>> Thanks Danny.  Installing sharutils solved that minor issue.  We now
>> get though the build just fine on opensuse 12, but sles 11sp2 gives
>> more warnings (pasted below).  Should we be using a newer version of
>> autoconf  on sles?  I've tried moving AC_CANONICAL_TARGET earlier in
>> the file, but that causes some other issues with the new java
>> macros.
>> 
>> Thanks, Gary
> 
> I'll take a look at it, I guess it's a problem in configure.ac.
> 
> I see the same warnings in our build system at SUSE for SLES (see: e.g.
> logs at
> https://build.opensuse.org/project/monitor?project=home%3Adalgaaf%3Abranches%3Afilesystems),
> but the package builds just fine for openSUSE, SLES, Fedora, RHEL and
> CentOS there

Looks like it is the usage of AC_CANONICAL_SYSTEM in ac_prog_javah.m4 that cause the warning on centos and sles.  Using AC_CANONICAL_HOST fixed the warning.  I'm not sure if that's the real solution, or if something should be changed in the configure.ac file.
The diff of the change I tried is below.

Thanks,
Gary

diff --git a/m4/ac_prog_javah.m4 b/m4/ac_prog_javah.m4
index 0cc93f9..118e02f 100644
--- a/m4/ac_prog_javah.m4
+++ b/m4/ac_prog_javah.m4
@@ -10,7 +10,7 @@ dnl @version 2002-03-25
 dnl @license AllPermissive
 
 AC_DEFUN([AC_PROG_JAVAH],[
-AC_REQUIRE([AC_CANONICAL_SYSTEM])dnl
+AC_REQUIRE([AC_CANONICAL_HOST])dnl
 AC_REQUIRE([AC_PROG_CPP])dnl
 AC_PATH_PROG(JAVAH,javah)
 if test x"`eval 'echo $ac_cv_path_JAVAH'`" != x ; then


