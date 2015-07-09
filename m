From: Travis Rhoden <trhoden@redhat.com>
Subject: Re: python facade pattern implementation in ceph and ceph-deploy is bad practice?
Date: Thu, 9 Jul 2015 10:00:01 -0700
Message-ID: <6E87029C-274C-4223-83AA-88CA5B0F59EC@redhat.com>
References: <559E4814.8030007@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42477 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbbGIRAD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jul 2015 13:00:03 -0400
In-Reply-To: <559E4814.8030007@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel@vger.kernel.org

Hi Owen,

There are quite a few emails in this thread already, but there are poin=
ts in each of them I would like to address.

Up front let me say I hear and recognize your frustration.  If you=E2=80=
=99ve felt ignored, I apologize.  I think you=E2=80=99ve turned around =
a lot of patches, PR comments, and emails faster then I=E2=80=99ve been=
 able to look at them all.  It=E2=80=99s completely been =E2=80=9CI hav=
en=E2=80=99t gotten there yet=E2=80=9D and none of =E2=80=9CI=E2=80=99m=
 ignoring you=E2=80=9D.

> On Jul 9, 2015, at 3:08 AM, Owen Synge <osynge@suse.com> wrote:
>=20
> Dear all,
>=20
> The facade pattern (or fa=C3=A7ade pattern) is a software design patt=
ern
> commonly used with object-oriented programming. The name is by analog=
y
> to an architectural facade. (wikipedia)
>=20
> I am frustrated with the desire to "standardise" on the one bad pract=
ice
> implementations of the facade pattern in python that is used in
> ceph-deploy even in ceph.
>=20
> The current "standard" of selectively calling modules with functions =
has
> a series of complexities to it.
>=20
> Ceph example:
>=20
> 	https://github.com/ceph/ceph/tree/master/src/ceph-detect-init/ceph_d=
etect_init
>=20
> ceph-deploy example:
>=20
> 	https://github.com/ceph/ceph-deploy/tree/master/ceph_deploy/hosts
>=20
> SO I guess _some_ of you dont immediately see why this is VERY bad
> practice, and wonder why this makes me feel like the orange in this s=
tory:
>=20
> http://www.dailymail.co.uk/news/article-2540670/The-perfect-half-time=
-oranges-five-football-matches-Farmers-create-pentagon-shaped-fruit.htm=
l
>=20
> when I try to code with ceph-deploy in particular.

I=E2=80=99ve never heard the facade name attached to it.  For our modes=
t goals with ceph-deploy we have found it be quite flexilble, as it all=
ows us to do have distro specific code only where it is needed, and to =
pull all common code into common places, all behind a consistent abstra=
cted interface.  I think this actually leads to less code duplication, =
but there are plenty of places in ceph-deploy where this is not the cas=
e and the code could be cleaned up to bring more code into common place=
s.

Let me also say that specific to one of the comments I made in your PR,=
 when I brought up this facade idea, I was just talking out loud.  The =
comment I was going to leave today (and still will) is that my point th=
ere was unrelated to your PR.  It sent us off in a wrong direction, and=
 was not relevant to the code under discussion.  It was more a note to =
myself that this was something that was still on our plate, but it did =
not/does not need to change what you were looking at specifically.

>=20
> The ceph/ceph-deploy way of implementing a facade in python causes th=
is
> list the problems:
>=20
> 1) facade cannot be instantiated twice.
>=20
> 2) facade requires code layout inflexibility.
>=20
> 3) facade implementation can have side effects when implementation is
> changed.
>=20
> And probably others I have not thought of.
>=20
> In consequence from points above.
>=20
> From (1)
>=20
> (1A) no concurrency, so you cant configure more than one ceph-node at=
 a
> time.
> (1A) You have to close one facade to start anouther, eg in ceph-deplo=
y
> you have to close each connection before connecting to the next serve=
r
> so making it slow to use as all state has to be gathered.

concurrency has come up before in ceph-deploy.  It has been our explici=
t goal to make ceph-deploy as simple and *clear* as possible for users,=
 with one of the main purposes to be extremely verbose and essentially =
*teach* a user how to deploy a Ceph cluster.  That=E2=80=99s why it pri=
nts everything it does by default, shows every remote command, and prin=
ts the output back in order.  Concurrency would muddy those waters, tho=
ugh we do all want things to go faster.

It is not necessarily the facade pattern that is the limitation there =E2=
=80=94 it is the implementation within ceph-deploy.  We simply do a =E2=
=80=9Cfor host is hostnames=E2=80=A6=E2=80=9D loop everywhere =E2=80=94=
 it doesn=E2=80=99t matter what we are using underneath, we are doing o=
ne SSH connection at a time.

=46urthermore, I don=E2=80=99t think it=E2=80=99s the facade paradigm t=
hat would limit you to one host at a time at all.  It=E2=80=99s one hos=
t module (facade) instantiated per host.  You could do many of these at=
 once =E2=80=94 I don=E2=80=99t see any reason why you couldn=E2=80=99t=
=2E  I=E2=80=99ve never tried it out, and I don=E2=80=99t know if pytho=
n-remoto handles concurrency, but I don=E2=80=99t think the facade para=
digm prevents it.

>=20
> From (2)
>=20
> (2A) No nesting of facades without code duplication. EG reuse of syst=
emd
> support between distributions.
> (2B) inflexible / complex include paths for shared code between facad=
e
> implementations.
>=20

I disagree here.  There are plenty of places to put code that is common=
 and does not have to be duplicated.  I definitely don=E2=80=99t want c=
ode in each host module that knows how to deal with systemd. The code t=
hat does have to be in each host module is how to detect/assign what in=
it system is being used, and how to call into the appropriate (common) =
module to do what it needs.

As for complex include paths, I=E2=80=99m not sure I have much of an ar=
gument here other than to say that all frameworks have their convention=
s.  I don=E2=80=99t see what we are doing as anything different than wh=
at is enforced/recommended by many frameworks/scaffolds popular in Web =
app and MVC paradigms like RoR, Pyramid, Django, etc.  It=E2=80=99s jus=
t convention to learn.

> From (3)
>=20
> (3A) Since all variables in a facade implementation are global, but
> isolated to an implementation, we cannot have variables in the
> implementation, any cross function variables that are not passed as
> parameters or return values will return will lead to side effects tha=
t
> are difficult to test.

I admit I don=E2=80=99t follow this one completely.

>=20
> So this set of general points will have complex side effects that mak=
e
> you feel like an the pictured orange when developing that are related=
 to
> wear the facade is implemented.
>=20
> About this point you will say well its open source so fix it ?
>=20
> My answer to this is that when I try to do this, as in this patch:
>=20
> https://github.com/osynge/ceph-deploy/commit/b82f89f35b27814ed4aba108=
2efd134c24ecf21f
>=20
> More than once, seem to suggest I should use the much more complex mu=
lti
> file implementation of a fa=C3=A7ade.
>=20
> The only advantages of implementing fa=C3=A7ades in the "standard" ce=
ph /
> ceph-deploy way that I can see is:
>=20
> (I) how ceph-deploy has always done this way.
> (II) It allows you to continue using nearly no custom objects in pyth=
on.
> (III) We like our oranges in funny shapes.

Again, I have more to say here in the actual PR, but do give me some ti=
me.  I can tell you it will be at least 1.5 hrs from now before I will =
get to go read it all again.
In short, yes I would like to continue to use what we have, but I think=
 the classes you=E2=80=99ve created to handle systemd and sysv can fit =
into that very nicely.

>=20
> It seems to me the current implementation could have been created due=
 to
> the misunderstanding that modules are like objects, when intact they =
are
> like classes. Issues (1) and (3) can be solved simply by importing
> methods as objects rather than classes, but this does nothing to solv=
e
> the bigger issue (2) which is more serious, but its a simple step
> forward that might very simple to patch, but their is little point in=
 a
> POC unless people agree that issues (1) (2) and (3) are serious.
>=20
> Please can we not spread this boat anchor* implementation of a facade=
,
> further around the code base, and ideally migrate away from this bad
> practice, and help us all feel like happy round oranges.
>=20

John touched on this a bit already, about the real question here being =
about ultimate goals and intentions.  I=E2=80=99ll come back to this in=
 another email, but I have a couple of other scheduled events to attend=
 to first.  Again, do please give me the time to reply properly.

> Best regards
>=20
> Owen
>=20
>=20
> boat anchor
>=20
> https://en.wikipedia.org/wiki/Boat_anchor_%28metaphor%29

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
