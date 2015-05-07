From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: CRC algorithm selection
Date: Thu, 7 May 2015 07:46:24 +0200 (CEST)
Message-ID: <2117340096.21872970.1430977584564.JavaMail.zimbra@oxygem.tv>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8773C@SACMBXIP01.sdcorp.global.sandisk.com> <1129879155.20587125.1430975098173.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:45324 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbEGFq2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 May 2015 01:46:28 -0400
In-Reply-To: <1129879155.20587125.1430975098173.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>>I have found a redhat bugzilla about ceph and yasm.=20
>>https://bugzilla.redhat.com/show_bug.cgi?id=3D1190882=20
>>Seem to be blocked by SELinux.=20
speak too fast, it's fixed.

I see that yasm is require in all build packages requirements,

src/test/debian-jessie/debian/control:               yasm [amd64],
src/test/fedora/ceph.spec.in:BuildRequires:	yasm
src/test/ubuntu-12.04/debian/control:               yasm [amd64],
src/test/ubuntu-14.04/debian/control:               yasm [amd64],
src/test/centos-6/ceph.spec.in:BuildRequires:	yasm
src/test/centos-7/ceph.spec.in:BuildRequires:	yasm


and also a commit sage about incompatibility with x32

commit 49a08eb46ef277225fff0d9a0920c37427175f54
Author: Thorsten Glaser <tg@mirbsd.de>
Date:   Mon Sep 8 12:49:50 2014 -0700

    debian: only B-R yasm on amd64

    Make yasm dependency amd64 only, it isn?t used elsewhere
    but breaks x32 (which is mis-detected as amd64)

    Signed-off-by: Sage Weil <sage@redhat.com>
    (cherry picked from commit 9ab46dc5b49219aa6194861c393c938f23001c52=
)


----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Jeudi 7 Mai 2015 07:04:58
Objet: Re: CRC algorithm selection

Hi Sommath, nice debug !=20

>>BTW, I think we need to error out configure script (or at least docum=
ent ) if build server is not having 'yasm' installed.=20

I have found a redhat bugzilla about ceph and yasm.=20

https://bugzilla.redhat.com/show_bug.cgi?id=3D1190882=20

Seem to be blocked by SELinux.=20


----- Mail original -----=20
De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Mercredi 6 Mai 2015 20:36:35=20
Objet: CRC algorithm selection=20

Sage,=20
Based on the discussion of today's performance meeting, I ran the crc32=
 unittest and here is the result.=20

root@emsserver2:/home/ceph-main/src# ./unittest_crc32c=20
Running main() from gmock_main.cc=20
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 7 tests from 1 test case.=20
[----------] Global test environment set-up.=20
[----------] 7 tests from Crc32c=20
[ RUN ] Crc32c.Small=20
[ OK ] Crc32c.Small (0 ms)=20
[ RUN ] Crc32c.PartialWord=20
[ OK ] Crc32c.PartialWord (0 ms)=20
[ RUN ] Crc32c.Big=20
[ OK ] Crc32c.Big (16 ms)=20
[ RUN ] Crc32c.Performance=20
populating large buffer=20
calculating crc=20
best choice =3D 1193.86 MB/sec=20
best choice 0xffffffff =3D 1193.56 MB/sec=20
sctp =3D 1190.6 MB/sec=20
intel baseline =3D 261.623 MB/sec=20
[ OK ] Crc32c.Performance (7064 ms)=20
[ RUN ] Crc32c.Range=20
[ OK ] Crc32c.Range (0 ms)=20
[ RUN ] Crc32c.RangeZero=20
[ OK ] Crc32c.RangeZero (0 ms)=20
[ RUN ] Crc32c.RangeNull=20
[ OK ] Crc32c.RangeNull (0 ms)=20
[----------] 7 tests from Crc32c (7080 ms total)=20

[----------] Global test environment tear-down=20
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 7 tests from 1 test case ran. (7080 ms=
 total)=20
[ PASSED ] 7 tests.=20


So, it seems 'sctp' is giving better performance and thus it is recomme=
nding this.=20

So, it seems it is not picking up *_intel_fast method and going back to=
 make file I saw 'configure' was skipping yasm check since in my setup =
yasm was not installed.=20
I manually installed 'yasm' and rebuild everything. Now, here is the re=
sult..It is picking up *_intel_fast method and it is ~6 times faster !!=
!=20


root@emsserver2:/home/ceph-main/src# ./unittest_crc32c=20
Running main() from gmock_main.cc=20
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 7 tests from 1 test case.=20
[----------] Global test environment set-up.=20
[----------] 7 tests from Crc32c=20
[ RUN ] Crc32c.Small=20
[ OK ] Crc32c.Small (0 ms)=20
[ RUN ] Crc32c.PartialWord=20
[ OK ] Crc32c.PartialWord (0 ms)=20
[ RUN ] Crc32c.Big=20
[ OK ] Crc32c.Big (4 ms)=20
[ RUN ] Crc32c.Performance=20
populating large buffer=20
calculating crc=20
best choice =3D 6275.01 MB/sec=20
best choice 0xffffffff =3D 6314.59 MB/sec=20
sctp =3D 1187.1 MB/sec=20
intel baseline =3D 261.652 MB/sec=20
[ OK ] Crc32c.Performance (5709 ms)=20
[ RUN ] Crc32c.Range=20
[ OK ] Crc32c.Range (0 ms)=20
[ RUN ] Crc32c.RangeZero=20
[ OK ] Crc32c.RangeZero (0 ms)=20
[ RUN ] Crc32c.RangeNull=20
[ OK ] Crc32c.RangeNull (0 ms)=20
[----------] 7 tests from Crc32c (5713 ms total)=20

[----------] Global test environment tear-down=20
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 7 tests from 1 test case ran. (5713 ms=
 total)=20
[ PASSED ] 7 tests.=20


Thanks for the pointer and I will enable my journal tests with crc enab=
led.=20

BTW, I think we need to error out configure script (or at least documen=
t ) if build server is not having 'yasm' installed.=20

Thanks & Regards=20
Somnath=20

________________________________=20

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
