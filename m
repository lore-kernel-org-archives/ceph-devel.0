From: Owen Synge <osynge@suse.com>
Subject: Re: python facade pattern implementation in ceph and ceph-deploy
 is bad practice?
Date: Thu, 09 Jul 2015 13:59:36 +0200
Message-ID: <559E6228.8090604@suse.com>
References: <559E4814.8030007@suse.com> <559E50F2.7030801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:43960 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbGIMBs (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 9 Jul 2015 08:01:48 -0400
In-Reply-To: <559E50F2.7030801@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, ceph-devel@vger.kernel.org, Loic Dachary <loic@dachary.org>, Travis Rhoden <trhoden@redhat.com>

On 07/09/2015 12:46 PM, John Spray wrote:
> Owen,

Hi John,

thanks for your reasonable mail.

> Please can you say what your overall goal is with recent ceph-deploy
> patches?=20

To give ceph-deploy code features we have in downstream ceph-deploy to
upstream.

All I am trying to do is reduce copious code duplication during the
process of up streaming. It seems such duplication is wanted for reason=
s
I am yet to understand.

I only understand that due to architectural bad practices such as this
one in how to do a basic facade class.

I made my downstream code OS preferred directory neutral, and init
system neutral using abstractions.

> Whether a given structure is right or wrong is really a
> function of the overall direction.  If you are aiming to make
> ceph-deploy into an extensible framework that can do things in parall=
el,
> then you need to say so, and that's a bigger conversation about wheth=
er
> that's a reasonable goal for a tool which has so far made a virtue of
> maintaining modest ambitions.

Understood and irrelevant.

As I stated in the email you replied to the issue of only one instance
existing which prevents processing more than one node at a time, or
even, connecting to two servers at the same time (so you can query
update a second node) can be worked around, by importing the modules as
objects, but issue (2) the structural "orange" issues are far more
serious, leading to structural artifacts of a badly implemented facade
pattern interfere with the complete code base.

> Along these lines, I noticed that you recently submitted a pull reque=
st
> to ceph-deploy that added a dependency on SQLAlchemy, and several
> hundred lines of extra boilerplate code -- this kind of thing is
> unlikely to get a warm reception without a stronger justification for
> the extra weight.  While I don't know how related that is to the poin=
ts
> you're making in this post, but it certainly inspires some curiosity
> about where you're going with this.

It was presented as a possible way to make a MVC model.

It was only a POC, that this way of doing things could do all that is
required.

I pulled this POC as it was told to me that no matter what I said MVC o=
r
structural changes to ceph-deploy in any way where to be opposed by
former developers of ceph-deploy.

I might have presented an alternative MVC but since the objections wher=
e
to MVC and also SQLAlchemy when ever it would strengthen arguments
against MVC, without even waiting to discuss positives or negatives.

I did not want all my "bug fix" patches for ceph-deploy not beign
reviewed due to peoples seeing my name, and fearing letting in any
patches which I did into the code base.

> I had not seen your wip_services_abstraction branch before, I've just
> taken a quick look now.  More comments would probably have made it
> easier to read, as would following PEP8. =20

Good review points that would have encouraged me we where moving
forwards not backwards, and suggesting everythign has to be part of the
"boat anchor" facade we already have.

> I don't think there's anything
> problematic about having a class that knows how to start and stop a
> service, but I don't know what comments you've received elsewhere (th=
ere
> aren't any on the PR).

Here:

https://github.com/ceph/ceph-deploy/pull/317

and this is not the first time this has occurred.

Best regards

Owen

PS I have to fork ceph-deploy rgw today as I have deadlines to get some
thing out of the door.

PPS I did not intentionally kill the branch and will investigate why it=
s
missing.


>=20
> John
>=20
>=20
> On 09/07/15 11:08, Owen Synge wrote:
>> Dear all,
>>
>> The facade pattern (or fa=C3=A7ade pattern) is a software design pat=
tern
>> commonly used with object-oriented programming. The name is by analo=
gy
>> to an architectural facade. (wikipedia)
>>
>> I am frustrated with the desire to "standardise" on the one bad prac=
tice
>> implementations of the facade pattern in python that is used in
>> ceph-deploy even in ceph.
>>
>> The current "standard" of selectively calling modules with functions=
 has
>> a series of complexities to it.
>>
>> Ceph example:
>>
>>     https://github.com/ceph/ceph/tree/master/src/ceph-detect-init/ce=
ph_detect_init
>>
>>
>> ceph-deploy example:
>>
>>     https://github.com/ceph/ceph-deploy/tree/master/ceph_deploy/host=
s
>>
>> SO I guess _some_ of you dont immediately see why this is VERY bad
>> practice, and wonder why this makes me feel like the orange in this
>> story:
>>
>> http://www.dailymail.co.uk/news/article-2540670/The-perfect-half-tim=
e-oranges-five-football-matches-Farmers-create-pentagon-shaped-fruit.ht=
ml
>>
>>
>> when I try to code with ceph-deploy in particular.
>>
>> The ceph/ceph-deploy way of implementing a facade in python causes t=
his
>> list the problems:
>>
>> 1) facade cannot be instantiated twice.
>>
>> 2) facade requires code layout inflexibility.
>>
>> 3) facade implementation can have side effects when implementation i=
s
>> changed.
>>
>> And probably others I have not thought of.
>>
>> In consequence from points above.
>>
>>  From (1)
>>
>> (1A) no concurrency, so you cant configure more than one ceph-node a=
t a
>> time.
>> (1A) You have to close one facade to start anouther, eg in ceph-depl=
oy
>> you have to close each connection before connecting to the next serv=
er
>> so making it slow to use as all state has to be gathered.
>>
>>  From (2)
>>
>> (2A) No nesting of facades without code duplication. EG reuse of sys=
temd
>> support between distributions.
>> (2B) inflexible / complex include paths for shared code between faca=
de
>> implementations.
>>
>>  From (3)
>>
>> (3A) Since all variables in a facade implementation are global, but
>> isolated to an implementation, we cannot have variables in the
>> implementation, any cross function variables that are not passed as
>> parameters or return values will return will lead to side effects th=
at
>> are difficult to test.
>>
>> So this set of general points will have complex side effects that ma=
ke
>> you feel like an the pictured orange when developing that are relate=
d to
>> wear the facade is implemented.
>>
>> About this point you will say well its open source so fix it ?
>>
>> My answer to this is that when I try to do this, as in this patch:
>>
>> https://github.com/osynge/ceph-deploy/commit/b82f89f35b27814ed4aba10=
82efd134c24ecf21f
>>
>>
>> More than once, seem to suggest I should use the much more complex m=
ulti
>> file implementation of a fa=C3=A7ade.
>>
>> The only advantages of implementing fa=C3=A7ades in the "standard" c=
eph /
>> ceph-deploy way that I can see is:
>>
>> (I) how ceph-deploy has always done this way.
>> (II) It allows you to continue using nearly no custom objects in pyt=
hon.
>> (III) We like our oranges in funny shapes.
>>
>> It seems to me the current implementation could have been created du=
e to
>> the misunderstanding that modules are like objects, when intact they=
 are
>> like classes. Issues (1) and (3) can be solved simply by importing
>> methods as objects rather than classes, but this does nothing to sol=
ve
>> the bigger issue (2) which is more serious, but its a simple step
>> forward that might very simple to patch, but their is little point i=
n a
>> POC unless people agree that issues (1) (2) and (3) are serious.
>>
>> Please can we not spread this boat anchor* implementation of a facad=
e,
>> further around the code base, and ideally migrate away from this bad
>> practice, and help us all feel like happy round oranges.
>=20

--=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer,=
 HRB
21284 (AG
N=C3=BCrnberg)

Maxfeldstra=C3=9Fe 5

90409 N=C3=BCrnberg

Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
