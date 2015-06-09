From: Owen Synge <osynge@suse.com>
Subject: Re: Configure dependencies can be the same as make dependencies
Date: Tue, 09 Jun 2015 19:11:12 +0200
Message-ID: <55771E30.8070308@suse.com>
References: <5548807A.6060103@dachary.org> <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com> <5548D57E.3050406@dachary.org> <55491307.8010203@redhat.com> <554914EC.6000102@dachary.org> <alpine.DEB.2.00.1505051231040.13336@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:47938 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbbFIRMj (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 9 Jun 2015 13:12:39 -0400
In-Reply-To: <alpine.DEB.2.00.1505051231040.13336@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Sorry to catch this thread late.

I come here via patch

https://github.com/ceph/ceph/pull/4911#issuecomment-110422312

I think you guys are missing that configure is doing some thing here.

(1) Configure is generating the spec file.
(2) It could also generate the deb files.

What no one has done is to:

(A) Use configure to eliminate the differences between OS's.

If any one had done (A) you would not be considering this I hope.

This impact is particularly felt in the ceph.spec.in file where because
of the lack of (A) in the process we are plagued with OS specific
conditionals.

If the path of say:

	src/ceph-osd-prestart.sh

is ether:

	/usr/libexec/ceph

or:

	/usr/lib/ceph


Is purely distribution specific.

Having conditionals in

	ceph.sepc.in

defeats the point of generating it via autotools.

we can be remove many hard coded values replaced with variable and that
probably will only grow in number for example

	%if 0%{?rhel} || 0%{?fedora}
		--with-systemd-libexec-dir=3D/usr/libexec/ceph \
	%endif
	%if 0%{?opensuse} || 0%{?suse_version}
		--with-systemd-libexec-dir=3D/usr/lib/ceph/ \
	%endif

some wont need distribution specific locations like:

	--with-systemd-unit-dir=3D%_unitdir

In the long term replaced all these path variables could be replaced by
single parameter.

	./configure --with-distro-defaults=3Dredhat
	make rpm
	./configure --with-distro-defaults=3Dsuse
	make rpm
	./configure --with-distro-defaults=3Ddebian
	make deb
	./configure --with-distro-defaults=3Dubuntu
	make deb

Very easily.

In summary, please reconsider this decision as if you follow this polic=
y
we are left with conditionals all over the ceph.spec.in file.


Best regards

Owen






On 05/05/2015 09:31 PM, Sage Weil wrote:
> On Tue, 5 May 2015, Loic Dachary wrote:
>>> I think the long-term solution to Kefu's issue is that we need to
>>> remove the requirement to run through a full "./configure" invocati=
on
>>> just to get a tarball. All the RPM and Debian packages internally r=
un
>>> ./configure, so running it a second time slows things down. I think=
 it
>>> makes sense to implement the tarball-generation functionality using=
 a
>>> simpler script at the root of the ceph.git tree. The operation shou=
ld
>>> be about as fast as "git archive".
>>
>> I agree. It's going to be significant work but it's worth it.
>=20
> Yep!
>=20
>>> The "ceph.spec.in" -> "ceph.spec" suffers from a similar issue. It
>>> takes a full "./configure" run to get to a point where Make can wri=
te
>>> the proper version numbers into that file. Ideally we could skip al=
l
>>> of that and simply do the variable interpolation with sed or someth=
ing.
>=20
> Yep!
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer, HR=
B
21284 (AG
N=FCrnberg)

Maxfeldstra=DFe 5

90409 N=FCrnberg

Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
