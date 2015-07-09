From: Owen Synge <osynge@suse.com>
Subject: python facade pattern implementation in ceph and ceph-deploy is bad
 practice?
Date: Thu, 09 Jul 2015 12:08:20 +0200
Message-ID: <559E4814.8030007@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:47541 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbbGIKKL (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 9 Jul 2015 06:10:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Loic Dachary <loic@dachary.org>, Travis Rhoden <trhoden@redhat.com>

Dear all,

The facade pattern (or fa=C3=A7ade pattern) is a software design patter=
n
commonly used with object-oriented programming. The name is by analogy
to an architectural facade. (wikipedia)

I am frustrated with the desire to "standardise" on the one bad practic=
e
implementations of the facade pattern in python that is used in
ceph-deploy even in ceph.

The current "standard" of selectively calling modules with functions ha=
s
a series of complexities to it.

Ceph example:

	https://github.com/ceph/ceph/tree/master/src/ceph-detect-init/ceph_det=
ect_init

ceph-deploy example:

	https://github.com/ceph/ceph-deploy/tree/master/ceph_deploy/hosts

SO I guess _some_ of you dont immediately see why this is VERY bad
practice, and wonder why this makes me feel like the orange in this sto=
ry:

http://www.dailymail.co.uk/news/article-2540670/The-perfect-half-time-o=
ranges-five-football-matches-Farmers-create-pentagon-shaped-fruit.html

when I try to code with ceph-deploy in particular.

The ceph/ceph-deploy way of implementing a facade in python causes this
list the problems:

1) facade cannot be instantiated twice.

2) facade requires code layout inflexibility.

3) facade implementation can have side effects when implementation is
changed.

And probably others I have not thought of.

In consequence from points above.

=46rom (1)

(1A) no concurrency, so you cant configure more than one ceph-node at a
time.
(1A) You have to close one facade to start anouther, eg in ceph-deploy
you have to close each connection before connecting to the next server
so making it slow to use as all state has to be gathered.

=46rom (2)

(2A) No nesting of facades without code duplication. EG reuse of system=
d
support between distributions.
(2B) inflexible / complex include paths for shared code between facade
implementations.

=46rom (3)

(3A) Since all variables in a facade implementation are global, but
isolated to an implementation, we cannot have variables in the
implementation, any cross function variables that are not passed as
parameters or return values will return will lead to side effects that
are difficult to test.

So this set of general points will have complex side effects that make
you feel like an the pictured orange when developing that are related t=
o
wear the facade is implemented.

About this point you will say well its open source so fix it ?

My answer to this is that when I try to do this, as in this patch:

https://github.com/osynge/ceph-deploy/commit/b82f89f35b27814ed4aba1082e=
fd134c24ecf21f

More than once, seem to suggest I should use the much more complex mult=
i
file implementation of a fa=C3=A7ade.

The only advantages of implementing fa=C3=A7ades in the "standard" ceph=
 /
ceph-deploy way that I can see is:

(I) how ceph-deploy has always done this way.
(II) It allows you to continue using nearly no custom objects in python=
=2E
(III) We like our oranges in funny shapes.

It seems to me the current implementation could have been created due t=
o
the misunderstanding that modules are like objects, when intact they ar=
e
like classes. Issues (1) and (3) can be solved simply by importing
methods as objects rather than classes, but this does nothing to solve
the bigger issue (2) which is more serious, but its a simple step
forward that might very simple to patch, but their is little point in a
POC unless people agree that issues (1) (2) and (3) are serious.

Please can we not spread this boat anchor* implementation of a facade,
further around the code base, and ideally migrate away from this bad
practice, and help us all feel like happy round oranges.

Best regards

Owen


boat anchor

https://en.wikipedia.org/wiki/Boat_anchor_%28metaphor%29
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
