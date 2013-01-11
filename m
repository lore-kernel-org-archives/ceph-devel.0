From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Thu, 10 Jan 2013 21:13:11 -0800
Message-ID: <3EC7678C-6C3D-4E59-A5ED-FC9B2DC28C08@inktank.com>
References: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de> <CAPrxi58_D4PVhMAtABfKiRrXKZv0p4OUSfc+MuVkha0ndWPWxA@mail.gmail.com> <BB8FDF50-D01D-4B4A-A201-8AEA43FFFA2D@inktank.com> <50EE73F3.6050705@bisect.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58153 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab3AKFNQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jan 2013 00:13:16 -0500
Received: by mail-pb0-f49.google.com with SMTP id un15so731874pbc.22
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 21:13:16 -0800 (PST)
In-Reply-To: <50EE73F3.6050705@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Noah Watkins <jayhawk@cs.ucsc.edu>, Sage Weil <sage@inktank.com>


On Jan 9, 2013, at 11:55 PM, Danny Al-Gaaf wrote:

> Am 10.01.2013 05:32, schrieb Gary Lowell:
>> I have this patch, and the ones from Friday in the wip-rpm-update br=
anch.  Everything looks good except that we have the following new warn=
ing from configure:
>>=20
>> =85.
>> checking for kaffe... no
>> checking for java... java
>> checking for uudecode... no
>> WARNING: configure: I have to compile Test.class from scratch
>> checking for gcj... no
>> checking for guavac... no
>> checking for jikes=85 no
>> =85.
>>=20
>> This may have to do with something in our build environment.
>=20
> I assume you have no uudecode installed. It should be part of sharuti=
ls
> (http://www.gnu.org/software/sharutils/)

Thanks Danny.  Installing sharutils solved that minor issue.  We now ge=
t though the build just fine on opensuse 12, but sles 11sp2 gives more =
warnings (pasted below).  Should we be using a newer version of autocon=
f  on sles?  I've tried moving AC_CANONICAL_TARGET earlier in the file,=
 but that causes some other issues with the new java macros.

Thanks,
Gary

+ ./autogen.sh
warning: configure.ac:274: AC_ARG_PROGRAM was called before AC_CANONICA=
L_TARGET
=2E./../lib/autoconf/general.m4:1795: AC_CANONICAL_TARGET is expanded f=
rom...
=2E./../lib/autoconf/general.m4:1819: AC_CANONICAL_SYSTEM is expanded f=
rom...
m4/ac_prog_javah.m4:12: AC_PROG_JAVAH is expanded from...
=2E./../lib/m4sugar/m4sh.m4:505: AS_IF is expanded from...
configure.ac:274: the top level
aclocal: installing `m4/libtool.m4' from `/usr/share/aclocal/libtool.m4=
'
aclocal: installing `m4/ltoptions.m4' from `/usr/share/aclocal/ltoption=
s.m4'
aclocal: installing `m4/ltsugar.m4' from `/usr/share/aclocal/ltsugar.m4=
'
aclocal: installing `m4/ltversion.m4' from `/usr/share/aclocal/ltversio=
n.m4'
aclocal: installing `m4/lt~obsolete.m4' from `/usr/share/aclocal/lt~obs=
olete.m4'
aclocal: installing `m4/pkg.m4' from `/usr/share/aclocal/pkg.m4'
warning: configure.ac:274: AC_ARG_PROGRAM was called before AC_CANONICA=
L_TARGET
=2E./../lib/autoconf/general.m4:1795: AC_CANONICAL_TARGET is expanded f=
rom...
=2E./../lib/autoconf/general.m4:1819: AC_CANONICAL_SYSTEM is expanded f=
rom...
m4/ac_prog_javah.m4:12: AC_PROG_JAVAH is expanded from...
=2E./../lib/m4sugar/m4sh.m4:505: AS_IF is expanded from...
configure.ac:274: the top level




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
