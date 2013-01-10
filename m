From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Wed, 9 Jan 2013 20:32:04 -0800
Message-ID: <BB8FDF50-D01D-4B4A-A201-8AEA43FFFA2D@inktank.com>
References: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de> <CAPrxi58_D4PVhMAtABfKiRrXKZv0p4OUSfc+MuVkha0ndWPWxA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:63760 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab3AJEcJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 23:32:09 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so75948pbb.25
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 20:32:09 -0800 (PST)
In-Reply-To: <CAPrxi58_D4PVhMAtABfKiRrXKZv0p4OUSfc+MuVkha0ndWPWxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Danny Al-Gaaf <danny.al-gaaf@bisect.de>, ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

I have this patch, and the ones from Friday in the wip-rpm-update branc=
h.  Everything looks good except that we have the following new warning=
 from configure:

=85.
checking for kaffe... no
checking for java... java
checking for uudecode... no
WARNING: configure: I have to compile Test.class from scratch
checking for gcj... no
checking for guavac... no
checking for jikes=85 no
=85.

This may have to do with something in our build environment.

Cheers,
Gary

On Jan 9, 2013, at 1:54 PM, Noah Watkins wrote:

> I haven't tested this yet, but I like it. I think several of these
> macros can be used to simplify a bit more of the Java config bit. I
> also just saw the ax_jni_include_dir macro in the autoconf archive an=
d
> it looks like that can help clean-up too.
>=20
> On Wed, Jan 9, 2013 at 1:35 PM, Danny Al-Gaaf <danny.al-gaaf@bisect.d=
e> wrote:
>> The attached patch depends on the set of 6 patches I send some days =
ago.
>> See: http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/1179=
3
>>=20
>> Danny Al-Gaaf (1):
>>  configure.ac: check for org.junit.rules.ExternalResource
>>=20
>> autogen.sh                |   2 +-
>> configure.ac              |  29 ++++++-------
>> m4/ac_check_class.m4      | 108 ++++++++++++++++++++++++++++++++++++=
++++++++++
>> m4/ac_check_classpath.m4  |  24 +++++++++++
>> m4/ac_check_rqrd_class.m4 |  26 +++++++++++
>> m4/ac_java_options.m4     |  33 ++++++++++++++
>> m4/ac_prog_jar.m4         |  39 +++++++++++++++++
>> m4/ac_prog_java.m4        |  83 +++++++++++++++++++++++++++++++++++
>> m4/ac_prog_java_works.m4  |  98 ++++++++++++++++++++++++++++++++++++=
+++++
>> m4/ac_prog_javac.m4       |  45 +++++++++++++++++++
>> m4/ac_prog_javac_works.m4 |  36 ++++++++++++++++
>> m4/ac_prog_javah.m4       |  28 ++++++++++++
>> m4/ac_try_compile_java.m4 |  40 +++++++++++++++++
>> m4/ac_try_run_javac.m4    |  41 ++++++++++++++++++
>> 14 files changed, 615 insertions(+), 17 deletions(-)
>> create mode 100644 m4/ac_check_class.m4
>> create mode 100644 m4/ac_check_classpath.m4
>> create mode 100644 m4/ac_check_rqrd_class.m4
>> create mode 100644 m4/ac_java_options.m4
>> create mode 100644 m4/ac_prog_jar.m4
>> create mode 100644 m4/ac_prog_java.m4
>> create mode 100644 m4/ac_prog_java_works.m4
>> create mode 100644 m4/ac_prog_javac.m4
>> create mode 100644 m4/ac_prog_javac_works.m4
>> create mode 100644 m4/ac_prog_javah.m4
>> create mode 100644 m4/ac_try_compile_java.m4
>> create mode 100644 m4/ac_try_run_javac.m4
>>=20
>> --
>> 1.8.1
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
