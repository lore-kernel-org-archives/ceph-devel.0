From: Kefu Chai <kchai@redhat.com>
Subject: Re: Configure dependencies can be the same as make dependencies
Date: Tue, 5 May 2015 13:15:25 -0400 (EDT)
Message-ID: <1078415657.9103451.1430846125983.JavaMail.zimbra@redhat.com>
References: <5548807A.6060103@dachary.org> <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:39657 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761749AbbEERQa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 13:16:30 -0400
In-Reply-To: <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Gregory Farnum <greg@gregs42.com>, Loic Dachary <loic@dachary.org>, Alfredo Deza <adeza@redhat.com>



----- Original Message -----
> From: "Gregory Farnum" <greg@gregs42.com>
> To: "Loic Dachary" <loic@dachary.org>
> Cc: "Kefu Chai" <kchai@redhat.com>, "Ceph Development" <ceph-devel@vg=
er.kernel.org>
> Sent: Tuesday, May 5, 2015 10:31:11 PM
> Subject: Re: Configure dependencies can be the same as make dependenc=
ies
>=20
> On Tue, May 5, 2015 at 1:34 AM, Loic Dachary <loic@dachary.org> wrote=
:
> > Hi Kefu,
> >
> > In the context of https://github.com/ceph/ceph/pull/4449 and
> > https://github.com/ceph/ceph/pull/4544 I see you're going out of yo=
ur way
> > to implement mechanisms that make it possible to require less depen=
dencies
> > when running
> >
> >    ./configure
> >
> > than what is required by
> >
> >    ./make check
> >
> > I think the right solution is to require the same set of dependenci=
es,
> > regardless. It can easily be done by running ./install-deps.sh[1].
> >
> > This script is already used in jenkins.ceph.com and saved us from t=
he
> > recurring pain of manually updating the jenkins slaves every time a
> > dependency was added to either ceph.spec.in or debian/control.
> >
> > Although it is possible to run ./configure with a subset of the
> > dependencies that are required to run make check, it trades automat=
ic
> > installation of packages for significant manual maintenance. It sav=
es a
> > little disk and bandwidth every time a dependency is modified in th=
e
> > ceph.spec.in or debian/control files, which happens a few times a m=
onths
> > at most. The work items to manually maintain this difference:
> >
> > * the set of dependencies that ./configure requires needs to be man=
ually
> > maintained, it is not listed anywhere at the moment. It changes les=
s often
> > than ceph.spec.in or debian/control but it does change from time to=
 time
> > * the configure script has to be engineered to only require depende=
ncies
> > (assuming these dependencies are listed somewhere). In other word, =
every
> > time you change the configure script you have to be extra careful t=
o not
> > introduce a new dependency, even when it would help implement what =
you're
> > after in a simpler way.
> > * the configure script dependencies in the context of CI actually c=
hange
> > every time you consider using --enable-something because it modifie=
s the
> > set of files your tarbal is made of. If the corresponding something=
 is not
> > installed, the configure will likely not do what you want and you'l=
l have
> > to add something manually on the CI machine (or use install-deps.sh=
 but
> > that would defeat the purpose of separating configure dependencies =
from
> > make dependencies)
> > * to avoid adding dependencies to configure, it is tempting to forb=
id file
> > generation when preparing the tarbal (I'm thinking .8 generation
> > specifically), although it is legitimate for the tarbal generation =
to
> > involve some processing and transformation of the sources that requ=
ire
> > tools to run
> > * it is very unlikely a new developer will remember configure depen=
dencies
> > and make dependencies are different and mistakes will be done all t=
he
> > time, creating needless frustration

yeah. we should rely on ./install-deps.sh to prepare the environment fo=
r
all slaves. that's a more consistent and manageable way in the long ter=
m.
@alfredo, what do you think?

as to the change in https://github.com/ceph/ceph/pull/4544, my original
intention was to port my quick fix in next branch back to the master, a=
nd
to minimize the dependency for "configure; make dist".

but now, i think it's but a way to please the developer who does not wa=
nt
to install sphinx-build. so it's just a nice-to-have now.

and if "--without-man-pages", the configure dependencies and make depen=
dencies=20
are the same.

i just updated https://github.com/ceph/ceph/pull/4449, to reference thi=
s
mail thread.

>=20
> Maybe I'm missing something, but...
>=20
> configure's purpose in life is to set up the build system so that Cep=
h
> will successfully build on the current system. If configure assumes
> that you have stuff installed that you don't need to have installed t=
o
> build, then it is not doing its job.

agreed. but build includes "make check", IMHO. unless cross compiling.
i think that's one of reasons why debhelper has dh_auto_test. debhelper
is a set of tools helping building debian packages. i am not suggesting
that "it is correct since it's working that way", but there is probably
some rationale behind this, i think.

> Similarly, if "make check" won't run on a system that otherwise build=
s
> Ceph, that's a problem with "make check", not a problem with configur=
e
> or the rest of Ceph. If we require *extra* dependencies to support

one task of configure is to figure out the settings for Makefile. so,
yes, it's a problem of "make check", but configure is responsible to
help it.


> make check that's very bad =E2=80=94 it's becoming more popular for v=
endors to
> build Ceph on more exotic architectures and systems, and the chances
> are good that they'll do the minimal porting job, and simply skip
> running "make check" if it requires extra bits.

IIUC, this requires more fine-grained control to disable the check for=20
dependencies only used in "make check". I am not sure if this is expect=
ed.
for the good of the vendor who wants to port ceph to an exotic platform=
,
a workable "make check" is always expected. at least "make check" for t=
he
part of ceph the venders want to port/build. for example, if the vendor
just want to run ceph-osd on a certain platform, it would be nice to=20
pass "--with-osd --without-mon --without-mds ..." to configure, and mak=
e
sure that "make check" passes. and in this case, "make check" should on=
ly
exercise the function of OSD and its dependencies.


>=20
> Now, there are times when we decide something is important so we have
> configure default to one configuration and require a flag to change
> it. But in general that's not what we want to do, and IIRC there was
> an issue where configure was actually failing despite it being
> perfectly fine to build without some library or other.



Greg


>=20
> Etc etc.
> -Greg
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
