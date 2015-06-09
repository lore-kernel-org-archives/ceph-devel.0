From: Owen Synge <osynge@suse.com>
Subject: Re: Configure dependencies can be the same as make dependencies
Date: Tue, 09 Jun 2015 21:23:09 +0200
Message-ID: <55773D1D.2060603@suse.com>
References: <5548807A.6060103@dachary.org> <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com> <5548D57E.3050406@dachary.org> <55491307.8010203@redhat.com> <554914EC.6000102@dachary.org> <alpine.DEB.2.00.1505051231040.13336@cobra.newdream.net> <55771E30.8070308@suse.com> <alpine.DEB.2.00.1506091017430.1985@cobra.newdream.net> <55772F08.6040508@suse.com> <alpine.DEB.2.00.1506091140380.1985@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:52286 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbbFITYk (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 9 Jun 2015 15:24:40 -0400
In-Reply-To: <alpine.DEB.2.00.1506091140380.1985@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 06/09/2015 08:44 PM, Sage Weil wrote:
> On Tue, 9 Jun 2015, Owen Synge wrote:
>> On 06/09/2015 07:22 PM, Sage Weil wrote:
>>> On Tue, 9 Jun 2015, Owen Synge wrote:
>>>> Sorry to catch this thread late.
>>>
>>> There were two goals here:
>>>
>>>  1- make the generated tarball deterministic and independent of=20
>>> configure options.  Currently we have horrible hackery to include r=
ocksdb=20
>>> source in the tarball when configure doesn't get the rocksdb argume=
nts,=20
>>> and were hitting similar roadblocks/pain with libxio.  This is avoi=
ded=20
>>> with the make_dist.sh script (although we're not using it yet becau=
se of=20
>>> the specfile generation piece).
>>
>> I think deterministic is a reasonable goal.
>>
>> I think independent of configure options, is not really a goal, its =
a
>> solution to a goal that misses a couple of observations. The goal is
>> deterministic operation.
>>
>> The important observations are:
>>
>> (a) The same source will need to be released multiple times.
>> (b) It is nice to release with some differences to each environment.
>=20
> This doesn't make sense to me.=20

I guess this is a matter of my poor wording.

> There should be *one* upstream .tar.gz (or=20
> whatever) that is the canonical source associated with a release. =20

I agree, git at git hub provides this with a tag.

I then think it is presented, on a web site, at this stage the upstream
=2Etar.gz can be post processed if needed.

The source is taken by distributions such as redhat, suse, debian,
ubuntu, and presented to users both as source and as binaries.

Packaging files including ceph.spec being made from ceph.spec.in are
part of that post release presentation work that have (for reasons of
pragmatism) been placed in the same git repository.

While this packaging code/config has to be traceable to a canonical
source, they do not have to be the canonical source, and may be
generated from templates, provided the values are stored.

> That is
> entirely independent of which distro you eventually build that source=
 on,=20
> and should (more or less) correspond to a snapshot of the git tree fo=
r the=20
> release tag.

To clarify; the bits where it does not correspond to a fixed value  in
git that this discussion is based on.

I suggest all such values can be stored together and placed in a releas=
e
script.

> Currently the only reason ceph.spec is generated from autotools is to=
 fill=20
> in the version string.  I can see why filling in all the other stuff =
makes=20
> sense, but that points toward a process like
>=20
>  tar zxvf ceph-9.2.1.tar.gz    # that's the canonical release tarball
>  cd ceph-9.2.1
>  ./autogen.sh
>  ./configure --with-systemd-libexec-dir=3D/usr/libexec/ceph \
>                --with-rpm-dir=3D/export/redhat/
>  make srpm
>=20
> right?

right,

> Making different release tarball flavors for each distro seems crazy =
to=20
> me...

Thankfully I cant think of anything in ceph that it would needed be
needed for apart from the version information.

If you had more variables like the version information that was
distribution specific then per distribution tar balls might be needed.

Should their be a "support contract" variable, this might make the need
for different source releases having different values in templated code=
=2E
I am glad ceph does not have or need such a variable.

Owen


>> If you combine (a) and (b) you quickly see why the "--configure" ste=
p
>> exists before:
>>
>> 	make dist-bzip2
>>
>> as say on release you iterate between distributions to produce each
>> setup deterministically.
>>
>> To illustrate I have put a little of my proposals for a replacement
>> model of "make_dist.sh" to illustrate this in my opinion improved pr=
ocess.
>>
>> But if this step exists imagining a couple of patches later:
>>
>>  	$cat make_dist.sh
>> 	#!/bin/sh -e
>> 	# Common code
>> 	autogen.sh
>> 	# Redhat
>> 	./configure --with-systemd-libexec-dir=3D/usr/libexec/ceph \
>> 		--with-rpm-dir=3D/export/redhat/
>>  	make srpm
>> 	# Suse
>>  	./configure --with-systemd-libexec-dir=3D/usr/lib/ceph/ \
>> 		--with-rpm-dir=3D/export/suse/
>>  	make srpm
>> 	# Debian
>>  	./configure --with-systemd-libexec-dir=3D/usr/lib/ceph/ \
>> 		--with-sdeb-dir=3D/export/debian/
>>  	make sdeb
>> 	# Ubuntu
>>  	./configure --with-systemd-libexec-dir=3D/usr/libexec/ceph \
>> 		--with-sdeb-dir=3D/export/ubuntu
>>  	make sdeb
>>
>> This will also solve the problems (1) and (2) with ceph.spec.in to
>> ceph.spec transformation. And not just solve it once but make it cle=
arer
>> for each distribution.
>>
>> Problems.
>>
>> These are problems with your planned approach I don't have good answ=
ers
>> for, and this approach solves now.
>>
>> (1) having autotools and another thing template ceph.spec.in could b=
e
>> complex.
>>
>> (2) This code need to be documented as its not standard autotools.
>>
>> (3) How much faster must the template tool be to be acceptably faste=
r
>> than ./configure
>>
>>>  2- avoid multiple passes through ./configure for 'make dist' and t=
he=20
>>> subsequent build.  We currently do it for the 'make dist' step (whi=
ch also=20
>>> generates ceph.spec) and then for the eventual build.  Using autoto=
ols for=20
>>> generating the spec means we still do it twice.
>>>
>>> I'm less concerned about build speed and it may be worth consolidat=
ing all=20
>>> of the distro logic in configure.ac.  Honestly I don't really know =
if=20
>>> that is better or not (vs conditionals in the specfile)... I have n=
o real=20
>>> love for autotools.
>>
>> autotools is not some thing I love, but I find it very useful, withi=
n
>> the scope of building C/C++, I have found it has a solution with _ev=
ery_
>> use case already catered for. You just need some time to find it, an=
d it
>> may look different from what you thought you wanted and how you woul=
d
>> make it, but I find the pre made autotools solution is a better solu=
tion
>> than making your own from experience.
>>
>> I must say though, autotools is much nicer than rpm for macros and
>> variables and template expansion.
>>
>>> But hopefully the tarball step can remain a fast, deterministic ste=
p that=20
>>> doesn't require a configure pass?
>>
>> I really support you desire for deterministic.
>>
>> I commend your desire that each step remain fast.
>>
>> I believe you are missing a step if you follow the path of skipping =
the
>> configure pass, and you loose some important functionality.
>>
>> I point out now what functionality in the hope that we can use it to
>> make other work easier, and autoools can be used to template any fil=
es
>> it needs to, including at least, spec files and deb files by putting
>> paths into autotools.
>>
>>
>> Owen
>>
>>
>>
>>> sage
>>>
>>>
>>>
>>>
>>>>
>>>> I come here via patch
>>>>
>>>> https://github.com/ceph/ceph/pull/4911#issuecomment-110422312
>>>>
>>>> I think you guys are missing that configure is doing some thing he=
re.
>>>>
>>>> (1) Configure is generating the spec file.
>>>> (2) It could also generate the deb files.
>>>>
>>>> What no one has done is to:
>>>>
>>>> (A) Use configure to eliminate the differences between OS's.
>>>>
>>>> If any one had done (A) you would not be considering this I hope.
>>>>
>>>> This impact is particularly felt in the ceph.spec.in file where be=
cause
>>>> of the lack of (A) in the process we are plagued with OS specific
>>>> conditionals.
>>>>
>>>> If the path of say:
>>>>
>>>> 	src/ceph-osd-prestart.sh
>>>>
>>>> is ether:
>>>>
>>>> 	/usr/libexec/ceph
>>>>
>>>> or:
>>>>
>>>> 	/usr/lib/ceph
>>>>
>>>>
>>>> Is purely distribution specific.
>>>>
>>>> Having conditionals in
>>>>
>>>> 	ceph.sepc.in
>>>>
>>>> defeats the point of generating it via autotools.
>>>>
>>>> we can be remove many hard coded values replaced with variable and=
 that
>>>> probably will only grow in number for example
>>>>
>>>> 	%if 0%{?rhel} || 0%{?fedora}
>>>> 		--with-systemd-libexec-dir=3D/usr/libexec/ceph \
>>>> 	%endif
>>>> 	%if 0%{?opensuse} || 0%{?suse_version}
>>>> 		--with-systemd-libexec-dir=3D/usr/lib/ceph/ \
>>>> 	%endif
>>>>
>>>> some wont need distribution specific locations like:
>>>>
>>>> 	--with-systemd-unit-dir=3D%_unitdir
>>>>
>>>> In the long term replaced all these path variables could be replac=
ed by
>>>> single parameter.
>>>>
>>>> 	./configure --with-distro-defaults=3Dredhat
>>>> 	make rpm
>>>> 	./configure --with-distro-defaults=3Dsuse
>>>> 	make rpm
>>>> 	./configure --with-distro-defaults=3Ddebian
>>>> 	make deb
>>>> 	./configure --with-distro-defaults=3Dubuntu
>>>> 	make deb
>>>>
>>>> Very easily.
>>>>
>>>> In summary, please reconsider this decision as if you follow this =
policy
>>>> we are left with conditionals all over the ceph.spec.in file.
>>>>
>>>>
>>>> Best regards
>>>>
>>>> Owen
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> On 05/05/2015 09:31 PM, Sage Weil wrote:
>>>>> On Tue, 5 May 2015, Loic Dachary wrote:
>>>>>>> I think the long-term solution to Kefu's issue is that we need =
to
>>>>>>> remove the requirement to run through a full "./configure" invo=
cation
>>>>>>> just to get a tarball. All the RPM and Debian packages internal=
ly run
>>>>>>> ./configure, so running it a second time slows things down. I t=
hink it
>>>>>>> makes sense to implement the tarball-generation functionality u=
sing a
>>>>>>> simpler script at the root of the ceph.git tree. The operation =
should
>>>>>>> be about as fast as "git archive".
>>>>>>
>>>>>> I agree. It's going to be significant work but it's worth it.
>>>>>
>>>>> Yep!
>>>>>
>>>>>>> The "ceph.spec.in" -> "ceph.spec" suffers from a similar issue.=
 It
>>>>>>> takes a full "./configure" run to get to a point where Make can=
 write
>>>>>>> the proper version numbers into that file. Ideally we could ski=
p all
>>>>>>> of that and simply do the variable interpolation with sed or so=
mething.
>>>>>
>>>>> Yep!
>>>>>
>>>>> sage
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>>
>>>>
>>>> --=20
>>>> SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffe=
r, HRB
>>>> 21284 (AG
>>>> N=FCrnberg)
>>>>
>>>> Maxfeldstra=DFe 5
>>>>
>>>> 90409 N=FCrnberg
>>>>
>>>> Germany
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>
>> --=20
>> SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer,=
 HRB
>> 21284 (AG
>> N=FCrnberg)
>>
>> Maxfeldstra=DFe 5
>>
>> 90409 N=FCrnberg
>>
>> Germany
>>

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
