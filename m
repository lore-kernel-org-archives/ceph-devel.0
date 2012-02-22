From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: v0.42 not compiling .deb's (but v0.41 can)
Date: Wed, 22 Feb 2012 11:33:14 -0800
Message-ID: <CAORUGqAQL-1VeBzgigRMup76bBdg9BZq1zQrnf9eYyML85zfFQ@mail.gmail.com>
References: <81C477727102DA4E9B2605AC748C495407E36DF7D7@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:35483 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab2BVTdf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Feb 2012 14:33:35 -0500
Received: by wgbgn7 with SMTP id gn7so5212755wgb.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2012 11:33:34 -0800 (PST)
In-Reply-To: <81C477727102DA4E9B2605AC748C495407E36DF7D7@exch10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Feb 21, 2012 at 00:05, Paul Pettigrew
<Paul.Pettigrew@mach.com.au> wrote:
> Looking forward to upgrading our Ceph cluster from v0.41 to v0.42, st=
arted to compile the .deb packages per the procedure below (see end of =
email).
[grab a clean source]
> dpkg-buildpackage -j16
=2E..
> However, the same server (Ubuntu 12.04 x64) that successfully produce=
d v0.41 is giving the below now with v0.42:
> libtool: install: (cd /usr/src/ceph/git-ceph_v0.42/v0.42/src; /bin/ba=
sh /usr/src/ceph/git-ceph_v0.42/v0.42/libtool =C2=A0--silent --tag CXX =
--mode=3Drelink g++ -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D64 -D_REENTR=
ANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS -D_GNU_SOURCE -rdynamic -Wtyp=
e-limits -Wignored-qualifiers -Winit-self -Wpointer-arith -fno-strict-a=
liasing -DCEPH_LIBDIR=3D\"/usr/lib\" -Wnon-virtual-dtor -Wno-invalid-of=
fsetof -Wstrict-null-sentinel -g -O2 -fstack-protector --param=3Dssp-bu=
ffer-size=3D4 -Wformat -Wformat-security -version-info 1:0:0 -lpthread =
-lm -lcrypto++ -luuid -lrt -lexpat -lcurl -Wl,-Bsymbolic-functions -Wl,=
-z,relro -o librgw.la -rpath /usr/lib librgw_la-librgw.lo librgw_la-rgw=
_acl.lo librgw_la-rgw_xml.lo librados.la -inst-prefix-dir /usr/src/ceph=
/git-ceph_v0.42/v0.42/debian/tmp)
> ./.libs/librgw.so: file not recognized: File truncated
> collect2: ld returned 1 exit status
> make[5]: *** [radosgw-admin] Error 1
> make[5]: *** Waiting for unfinished jobs....
> ./.libs/librgw.so: file not recognized: File format not recognized

Like Florian, -j4 worked fine for me. Our automated builds are -j10.

I've seen libtool get confused very much like that when it's not a
clean build, but your list of commands explicitly started with a clean
tree.

Perhaps this was a case of a cosmic ray flipping a bit in RAM and
actually corrupting that file. Is the build failure reproducible? It
might be a timing error, so not 100% reproducible, but if you e.g.
leave that running in a loop for a few hours, do you see any failures?
And if so, does e.g. a regular kernel compile also fail sometimes?

http://www.bitwizard.nl/sig11/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
