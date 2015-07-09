From: Travis Rhoden <trhoden@redhat.com>
Subject: Re: python facade pattern implementation in ceph and ceph-deploy is bad practice?
Date: Thu, 9 Jul 2015 12:58:50 -0700
Message-ID: <3C4B78C7-D8FA-4EA0-84CE-129CE0852AB1@redhat.com>
References: <559E4814.8030007@suse.com> <559E50F2.7030801@redhat.com> <559E6228.8090604@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40901 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188AbbGIT6v convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jul 2015 15:58:51 -0400
In-Reply-To: <559E6228.8090604@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: ceph-devel@vger.kernel.org


> On Jul 9, 2015, at 4:59 AM, Owen Synge <osynge@suse.com> wrote:
>=20
> On 07/09/2015 12:46 PM, John Spray wrote:
>> Owen,
>=20
> Hi John,
>=20
> thanks for your reasonable mail.
>=20
>> Please can you say what your overall goal is with recent ceph-deploy
>> patches?=20
>=20
> To give ceph-deploy code features we have in downstream ceph-deploy t=
o
> upstream.
>=20
> All I am trying to do is reduce copious code duplication during the
> process of up streaming. It seems such duplication is wanted for reas=
ons
> I am yet to understand.
>=20
> I only understand that due to architectural bad practices such as thi=
s
> one in how to do a basic facade class.
>=20
> I made my downstream code OS preferred directory neutral, and init
> system neutral using abstractions.

I=E2=80=99ve added a new set of comments in https://github.com/ceph/cep=
h-deploy/pull/317 that hopefully clarifies my position.

I am *not* in favor of copious code duplication.

I *am* in favor of not introducing new paradigms or architectures in th=
e stable 1.5.x series.  The 1.5.x series is packaged and supported down=
stream, and introducing major changes will complicate that.  ceph-deplo=
y has been in a state where the main changes we have been taking are: (=
1) bug/security fixes (2) new features to keep up with Ceph features (l=
ike civetweb-based RGW) (3) fixes to make user help and execution outpu=
t more clear.

A major refactoring (I would consider anything that moves away from the=
 current facade paradigm to be major in 1.5.x) doesn=E2=80=99t fit into=
 that.  However, ceph-deploy is not dead or maintenance only, so long a=
s there is community interest.  The upstream installer developers (of w=
hich I am one) and Red Hat (also me again) are looking at alternatives =
for more robust installation solutions that do not involve ceph-deploy.=
  That is also a motivation for not making major changes, like those pr=
oposed in https://github.com/ceph/ceph-deploy/pull/320.  I am concerned=
 that it will make long-term maintenance more complicated.

>=20
>> Whether a given structure is right or wrong is really a
>> function of the overall direction.  If you are aiming to make
>> ceph-deploy into an extensible framework that can do things in paral=
lel,
>> then you need to say so, and that's a bigger conversation about whet=
her
>> that's a reasonable goal for a tool which has so far made a virtue o=
f
>> maintaining modest ambitions.
>=20
> Understood and irrelevant.
>=20
> As I stated in the email you replied to the issue of only one instanc=
e
> existing which prevents processing more than one node at a time, or
> even, connecting to two servers at the same time (so you can query
> update a second node) can be worked around, by importing the modules =
as
> objects, but issue (2) the structural "orange" issues are far more
> serious, leading to structural artifacts of a badly implemented facad=
e
> pattern interfere with the complete code base.
>=20
>> Along these lines, I noticed that you recently submitted a pull requ=
est
>> to ceph-deploy that added a dependency on SQLAlchemy, and several
>> hundred lines of extra boilerplate code -- this kind of thing is
>> unlikely to get a warm reception without a stronger justification fo=
r
>> the extra weight.  While I don't know how related that is to the poi=
nts
>> you're making in this post, but it certainly inspires some curiosity
>> about where you're going with this.
>=20
> It was presented as a possible way to make a MVC model.
>=20
> It was only a POC, that this way of doing things could do all that is
> required.
>=20
> I pulled this POC as it was told to me that no matter what I said MVC=
 or
> structural changes to ceph-deploy in any way where to be opposed by
> former developers of ceph-deploy.

We=E2=80=99ve been trying to only accept code into ceph-deploy that has=
 a corresponding bugzilla or Ceph tracker bug referenced.  I mention th=
is because it helps us answer the question =E2=80=9Cwhat problem does t=
his solve=E2=80=9D?  We haven=E2=80=99t enforced to all contributors in=
 the community, but we=E2=80=99re trying to be more stringent about it.=
  The code you=E2=80=99ve proposed in https://github.com/ceph/ceph-depl=
oy/pull/320 seems to mainly address creating required RGW pools.  I=E2=80=
=99d like to see a bug opened against that so that we can see if it is =
indeed something that needs to be fixed.  It may very well be that this=
 is something that RGW is supposed to be doing itself (just talking out=
 loud again).

>=20
> I might have presented an alternative MVC but since the objections wh=
ere
> to MVC and also SQLAlchemy when ever it would strengthen arguments
> against MVC, without even waiting to discuss positives or negatives.
>=20
> I did not want all my "bug fix" patches for ceph-deploy not beign
> reviewed due to peoples seeing my name, and fearing letting in any
> patches which I did into the code base.

I can only speak for myself here, but I would not do that and I don=E2=80=
=99t think my colleagues would either.  It would not lead to a very fri=
endly community if any of us would rather have bugs in the code than re=
view perfectly good patches that fix real problems.

>=20
>> I had not seen your wip_services_abstraction branch before, I've jus=
t
>> taken a quick look now.  More comments would probably have made it
>> easier to read, as would following PEP8. =20
>=20
> Good review points that would have encouraged me we where moving
> forwards not backwards, and suggesting everythign has to be part of t=
he
> "boat anchor" facade we already have.
>=20
>> I don't think there's anything
>> problematic about having a class that knows how to start and stop a
>> service, but I don't know what comments you've received elsewhere (t=
here
>> aren't any on the PR).

All the comments relevant to the class abstraction are in that PR.  Oth=
er conversations have taken place on IRC, but that=E2=80=99s been aroun=
d the proposal for more of an MVC style that incorporates SQL Alchemy, =
and that is more related to PR #320.  I=E2=80=99ve clarified my review =
on #317 to say that I like the classes for the init systems as well, bu=
t want to see them used a bit differently and to not use the higher lev=
el abstraction above them.

>=20
> Here:
>=20
> https://github.com/ceph/ceph-deploy/pull/317
>=20
> and this is not the first time this has occurred.
>=20
> Best regards
>=20
> Owen
>=20
> PS I have to fork ceph-deploy rgw today as I have deadlines to get so=
me
> thing out of the door.
>=20
> PPS I did not intentionally kill the branch and will investigate why =
its
> missing.
>=20
>=20
>>=20
>> John
>>=20
>>=20
>> On 09/07/15 11:08, Owen Synge wrote:
>>> Dear all,
>>>=20
>>> The facade pattern (or fa=C3=A7ade pattern) is a software design pa=
ttern
>>> commonly used with object-oriented programming. The name is by anal=
ogy
>>> to an architectural facade. (wikipedia)
>>>=20
>>> I am frustrated with the desire to "standardise" on the one bad pra=
ctice
>>> implementations of the facade pattern in python that is used in
>>> ceph-deploy even in ceph.
>>>=20
>>> The current "standard" of selectively calling modules with function=
s has
>>> a series of complexities to it.
>>>=20
>>> Ceph example:
>>>=20
>>>    https://github.com/ceph/ceph/tree/master/src/ceph-detect-init/ce=
ph_detect_init
>>>=20
>>>=20
>>> ceph-deploy example:
>>>=20
>>>    https://github.com/ceph/ceph-deploy/tree/master/ceph_deploy/host=
s
>>>=20
>>> SO I guess _some_ of you dont immediately see why this is VERY bad
>>> practice, and wonder why this makes me feel like the orange in this
>>> story:
>>>=20
>>> http://www.dailymail.co.uk/news/article-2540670/The-perfect-half-ti=
me-oranges-five-football-matches-Farmers-create-pentagon-shaped-fruit.h=
tml
>>>=20
>>>=20
>>> when I try to code with ceph-deploy in particular.
>>>=20
>>> The ceph/ceph-deploy way of implementing a facade in python causes =
this
>>> list the problems:
>>>=20
>>> 1) facade cannot be instantiated twice.
>>>=20
>>> 2) facade requires code layout inflexibility.
>>>=20
>>> 3) facade implementation can have side effects when implementation =
is
>>> changed.
>>>=20
>>> And probably others I have not thought of.
>>>=20
>>> In consequence from points above.
>>>=20
>>> From (1)
>>>=20
>>> (1A) no concurrency, so you cant configure more than one ceph-node =
at a
>>> time.
>>> (1A) You have to close one facade to start anouther, eg in ceph-dep=
loy
>>> you have to close each connection before connecting to the next ser=
ver
>>> so making it slow to use as all state has to be gathered.
>>>=20
>>> From (2)
>>>=20
>>> (2A) No nesting of facades without code duplication. EG reuse of sy=
stemd
>>> support between distributions.
>>> (2B) inflexible / complex include paths for shared code between fac=
ade
>>> implementations.
>>>=20
>>> From (3)
>>>=20
>>> (3A) Since all variables in a facade implementation are global, but
>>> isolated to an implementation, we cannot have variables in the
>>> implementation, any cross function variables that are not passed as
>>> parameters or return values will return will lead to side effects t=
hat
>>> are difficult to test.
>>>=20
>>> So this set of general points will have complex side effects that m=
ake
>>> you feel like an the pictured orange when developing that are relat=
ed to
>>> wear the facade is implemented.
>>>=20
>>> About this point you will say well its open source so fix it ?
>>>=20
>>> My answer to this is that when I try to do this, as in this patch:
>>>=20
>>> https://github.com/osynge/ceph-deploy/commit/b82f89f35b27814ed4aba1=
082efd134c24ecf21f
>>>=20
>>>=20
>>> More than once, seem to suggest I should use the much more complex =
multi
>>> file implementation of a fa=C3=A7ade.
>>>=20
>>> The only advantages of implementing fa=C3=A7ades in the "standard" =
ceph /
>>> ceph-deploy way that I can see is:
>>>=20
>>> (I) how ceph-deploy has always done this way.
>>> (II) It allows you to continue using nearly no custom objects in py=
thon.
>>> (III) We like our oranges in funny shapes.
>>>=20
>>> It seems to me the current implementation could have been created d=
ue to
>>> the misunderstanding that modules are like objects, when intact the=
y are
>>> like classes. Issues (1) and (3) can be solved simply by importing
>>> methods as objects rather than classes, but this does nothing to so=
lve
>>> the bigger issue (2) which is more serious, but its a simple step
>>> forward that might very simple to patch, but their is little point =
in a
>>> POC unless people agree that issues (1) (2) and (3) are serious.
>>>=20
>>> Please can we not spread this boat anchor* implementation of a faca=
de,
>>> further around the code base, and ideally migrate away from this ba=
d
>>> practice, and help us all feel like happy round oranges.
>>=20
>=20
> --=20
> SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffe=
r, HRB
> 21284 (AG
> N=C3=BCrnberg)
>=20
> Maxfeldstra=C3=9Fe 5
>=20
> 90409 N=C3=BCrnberg
>=20
> Germany

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
