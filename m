From: Travis Rhoden <trhoden@redhat.com>
Subject: Re: Difference between convention and enforcement.
Date: Thu, 16 Jul 2015 22:10:08 -0700
Message-ID: <3370BF97-5059-4B12-927F-522C77E70E7B@redhat.com>
References: <559E4814.8030007@suse.com> <6E87029C-274C-4223-83AA-88CA5B0F59EC@redhat.com> <55A4E756.7090206@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53102 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbbGQFKJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jul 2015 01:10:09 -0400
In-Reply-To: <55A4E756.7090206@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel@vger.kernel.org


> On Jul 14, 2015, at 3:41 AM, Owen Synge <osynge@suse.com> wrote:
>=20
> Dear Travis,
>=20
> We clearly disagree in this area.
>=20
> I hope me explaining my perspective is not seen as unhelpful.
>=20
> On 07/09/2015 07:00 PM, Travis Rhoden wrote:
>>> (2B) inflexible / complex include paths for shared code between fac=
ade
>>>> implementations.
>>>>=20
>> I disagree here.  There are plenty of places to put code that is com=
mon and does not have to be duplicated.  I definitely don=E2=80=99t wan=
t code in each host module that knows how to deal with systemd. The cod=
e that does have to be in each host module is how to detect/assign what=
 init system is being used, and how to call into the appropriate (commo=
n) module to do what it needs.
>>=20
>> As for complex include paths, I=E2=80=99m not sure I have much of an=
 argument here other than to say that all frameworks have their convent=
ions.  I don=E2=80=99t see what we are doing as anything different than=
 what is enforced/recommended by many frameworks/scaffolds popular in W=
eb app and MVC paradigms like RoR, Pyramid, Django, etc.  It=E2=80=99s =
just convention to learn.
>=20
> I don't understand why you chose to defend this. Please expand your
> argument.

Truthfully I=E2=80=99m not sure how to, because I=E2=80=99m not sure I =
agree that code location is enforced at all.  I don=E2=80=99t think tha=
t it is.  There is nothing =E2=80=9Cenforcing=E2=80=9D where code lives=
=2E  By that I mean that as long is once class/function/module is impor=
table into another module, it works. There is a general style that has =
fallen out as development has happened over time, but like most project=
s there are bits and pieces scattered throughout in places that probabl=
y made logical sense at the time, but no longer is the best fit.

I say nothing is =E2=80=9Cenforcing=E2=80=9D locations because it=E2=80=
=99s not like the code won=E2=80=99t work if the code is some place els=
e.  As long you can import what you need, things should be good.  There=
 used to be relative imports in ceph_deploy (e.g. =E2=80=9Cimport ..uti=
ls; import .helpers=E2=80=9D), but I believe all of that has been gone =
for a while.

=46or the most part it=E2=80=99s really up to the author of new code to=
 put it where they think is best, and for the reviewers to agree or be =
indifferent about it.  :)  Along those lines, if code were to get moved=
 in a PR with a description of =E2=80=9Cthis makes a lot more sense=E2=80=
=9D, that would be seen as a positive contribution.

Most of the =E2=80=9Crigid=E2=80=9D layout is in the hosts modules.  It=
 makes sense that we have hosts/centos, hosts/debian, etc.  But then ev=
en inside to those top levels, they import things from all over the pla=
ce.  One example I can think of is ceph_deploy.hosts.remotes, the conte=
nts of which magically (except, not magic) appear as distro.conn.remote=
_module.  This is using a capability of python-remoto, and is an area o=
f code I=E2=80=99ve spent very little time with it.  I=E2=80=99m not su=
re if this is perhaps what you are concerned about.

>=20
> I will not go into the negative side effects of importing modules as
> objects in the include paths, as a work around for potential side
> effects of our current fa=C3=A7ade model, as this topic is more compl=
ex than
> the points I do raise in this email, but I will expand them should th=
ese
> arguments not be valid, as I would like to understand where we intend=
 to
> go, and how we minimise long term maintenance and maximise extensibil=
ity.
>=20
> Here are the simpler reasons why I don't agree:
>=20
> I hate the enforced code structures used my many "popular" frameworks
> especially common in web frameworks but I accept that these enforce v=
ery
> clear standard design patterns that are known to scale and be extensi=
ble
> and you acknowledge this difference to the ceph-deploy code base simp=
ly
> by calling them MVC. *
>=20
> Having enforced relative paths between code files defined by the
> implementation of the code is a great limitation.
>=20
> While one can place code modules in the correct location if only one
> thing defines the correct location, one can easily get into difficult=
ies
> 2 obvious limitations in tolerating this are:
>=20
> (1) by having two parts of the code base enforcing relative paths
> between modules.

I hope that I=E2=80=99ve made it clear that I don=E2=80=99t think anyth=
ing is actually enforcing any relative paths between modules.  That doe=
sn=E2=80=99t mean I=E2=80=99m not missing something, so do please point=
 it out if I am.

>=20
> (2) by having relationships between modules become needlessly complex
> because the enforced relationship says the code must go in a place th=
at
> is not correct to solve the problem. (this is analogous to the death =
of
> hierarchical databases and their replacement with relational database=
s)
>=20
> So since the issue is most serious if you have 2 components in the co=
de
> base that "enforce" module layout, and we only have one, we are only
> preventing further components that "enforce" module layout.
>=20
> Admittedly neither of these issues has _prevented_ development on
> ceph-deploy so far, or led to duplication now you withdrew your comme=
nts
> about all fa=C3=A7ades being the same.
>=20
> Due to the fa=C3=A7ade defining module location we so far have, some =
things
> have become confused in where the module can be placed that are clear=
ly
> OS specific.
>=20
> Examples include:
>=20
> 	ceph_deploy/util/constants.py which is clearly includes constants th=
at
> are OS specific, such as package names.

I get your point, but really these could be anywhere.  For all the OS=E2=
=80=99s we=E2=80=99ve been supporting, most of this is *not* OS specifi=
c, really.  They are indeed constants across all Linux distros.  There=E2=
=80=99s been new additions to deal with downstream package splits, and =
there very well be better ways of handling that.  Those pieces are rela=
tively new (just a few months), and I highly suspect that will be impro=
ved more over time.  I also fully accept that while perhaps these were =
simple/universal contstants in the past, the variety of packaging we su=
pport, distros, and init systems may not make that the case (systemd co=
mes to mind).  However it is important to keep in mind that ceph-deploy=
 is only intended to support installing Ceph from upstream Ceph release=
/testing packages, or downstream packages that follow the same location=
s about where to install things to, not homegrown or locally compiled b=
inaries.  ceph-deploy is purposely a highly opinionated tool.

>=20
> 	ceph_deploy/util/pkg_managers.py which clearly is a set of OS specif=
ic
> implementations.

Not so much OS specific, as packager specific (yum, apt, etc.)  This ar=
ea is ripe for improvement, and is actually something I=E2=80=99ve star=
ted on already in order to support DNF on Fedora.  I have a branch I ca=
n point you at if interested.  But I want to make sure I truly understa=
nd your concern here.  If there were classes in ceph_deploy.util.pkg_ma=
nagers, one for each type of of manager we use (dnf, yum, apt, zypper),=
 and these were imported as needed by host modules in ceph_deploy.hosts=
=2E*, would you see that as a problem?  It doesn=E2=80=99t matter to me=
 where the code is.  It=E2=80=99s more important to me that the module =
names are clear, so I don=E2=80=99t have to find package manager code i=
n a file named =E2=80=9Cdecorators=E2=80=9D or something.

>=20
> Both of these lead to unnecessary complications, when they could be
> fa=C3=A7ades in their own right and should have the modules moved if =
we
> continue to have this enforced module location in the fa=C3=A7ade imp=
lementation.

Totally agree that it can be improved.  ceph-deploy is growing organica=
lly and has had a lot of different developers on as you would expect fr=
om any project of this nature.

>=20
> This inconsistency will not effect customers but does effect the clar=
ity
> of the code, and leads to more conditionals than we might have if we
> took in my opinion a cleaner implementation to our model.
>=20
> I will _not_ provide sample code of improvements, as this may lead to
> people discussing irrelevant issues, until this point is resolved as =
my
> mistake, or an area that is agreed can be improved.
>=20
> Best regards
>=20
> Owen
>=20
>=20
> * It is one the many reasons I abandoned django in favour of Pyramid =
for
> my personal projects, even though django only enforced separation of
> components Model View and controller, pyramid to my recollection (its
> been 3 years at least) only recommended a module relationship path  .

I rather enjoyed working with Pyramid as well, and it=E2=80=99s precurs=
or pylons.--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
