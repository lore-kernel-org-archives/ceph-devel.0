From: John Spray <john.spray@redhat.com>
Subject: Re: python facade pattern implementation in ceph and ceph-deploy is
 bad practice?
Date: Thu, 9 Jul 2015 11:46:10 +0100
Message-ID: <559E50F2.7030801@redhat.com>
References: <559E4814.8030007@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52098 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbbGIKqP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Jul 2015 06:46:15 -0400
In-Reply-To: <559E4814.8030007@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>, ceph-devel@vger.kernel.org, Loic Dachary <loic@dachary.org>, Travis Rhoden <trhoden@redhat.com>

Owen,

Please can you say what your overall goal is with recent ceph-deploy=20
patches?  Whether a given structure is right or wrong is really a=20
function of the overall direction.  If you are aiming to make=20
ceph-deploy into an extensible framework that can do things in parallel=
,=20
then you need to say so, and that's a bigger conversation about whether=
=20
that's a reasonable goal for a tool which has so far made a virtue of=20
maintaining modest ambitions.

Along these lines, I noticed that you recently submitted a pull request=
=20
to ceph-deploy that added a dependency on SQLAlchemy, and several=20
hundred lines of extra boilerplate code -- this kind of thing is=20
unlikely to get a warm reception without a stronger justification for=20
the extra weight.  While I don't know how related that is to the points=
=20
you're making in this post, but it certainly inspires some curiosity=20
about where you're going with this.

I had not seen your wip_services_abstraction branch before, I've just=20
taken a quick look now.  More comments would probably have made it=20
easier to read, as would following PEP8.  I don't think there's anythin=
g=20
problematic about having a class that knows how to start and stop a=20
service, but I don't know what comments you've received elsewhere (ther=
e=20
aren't any on the PR).

John


On 09/07/15 11:08, Owen Synge wrote:
> Dear all,
>
> The facade pattern (or fa=C3=A7ade pattern) is a software design patt=
ern
> commonly used with object-oriented programming. The name is by analog=
y
> to an architectural facade. (wikipedia)
>
> I am frustrated with the desire to "standardise" on the one bad pract=
ice
> implementations of the facade pattern in python that is used in
> ceph-deploy even in ceph.
>
> The current "standard" of selectively calling modules with functions =
has
> a series of complexities to it.
>
> Ceph example:
>
> 	https://github.com/ceph/ceph/tree/master/src/ceph-detect-init/ceph_d=
etect_init
>
> ceph-deploy example:
>
> 	https://github.com/ceph/ceph-deploy/tree/master/ceph_deploy/hosts
>
> SO I guess _some_ of you dont immediately see why this is VERY bad
> practice, and wonder why this makes me feel like the orange in this s=
tory:
>
> http://www.dailymail.co.uk/news/article-2540670/The-perfect-half-time=
-oranges-five-football-matches-Farmers-create-pentagon-shaped-fruit.htm=
l
>
> when I try to code with ceph-deploy in particular.
>
> The ceph/ceph-deploy way of implementing a facade in python causes th=
is
> list the problems:
>
> 1) facade cannot be instantiated twice.
>
> 2) facade requires code layout inflexibility.
>
> 3) facade implementation can have side effects when implementation is
> changed.
>
> And probably others I have not thought of.
>
> In consequence from points above.
>
>  From (1)
>
> (1A) no concurrency, so you cant configure more than one ceph-node at=
 a
> time.
> (1A) You have to close one facade to start anouther, eg in ceph-deplo=
y
> you have to close each connection before connecting to the next serve=
r
> so making it slow to use as all state has to be gathered.
>
>  From (2)
>
> (2A) No nesting of facades without code duplication. EG reuse of syst=
emd
> support between distributions.
> (2B) inflexible / complex include paths for shared code between facad=
e
> implementations.
>
>  From (3)
>
> (3A) Since all variables in a facade implementation are global, but
> isolated to an implementation, we cannot have variables in the
> implementation, any cross function variables that are not passed as
> parameters or return values will return will lead to side effects tha=
t
> are difficult to test.
>
> So this set of general points will have complex side effects that mak=
e
> you feel like an the pictured orange when developing that are related=
 to
> wear the facade is implemented.
>
> About this point you will say well its open source so fix it ?
>
> My answer to this is that when I try to do this, as in this patch:
>
> https://github.com/osynge/ceph-deploy/commit/b82f89f35b27814ed4aba108=
2efd134c24ecf21f
>
> More than once, seem to suggest I should use the much more complex mu=
lti
> file implementation of a fa=C3=A7ade.
>
> The only advantages of implementing fa=C3=A7ades in the "standard" ce=
ph /
> ceph-deploy way that I can see is:
>
> (I) how ceph-deploy has always done this way.
> (II) It allows you to continue using nearly no custom objects in pyth=
on.
> (III) We like our oranges in funny shapes.
>
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
>
> Please can we not spread this boat anchor* implementation of a facade=
,
> further around the code base, and ideally migrate away from this bad
> practice, and help us all feel like happy round oranges.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
