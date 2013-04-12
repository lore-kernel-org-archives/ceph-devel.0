From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph and efficient access of distributed resources
Date: Fri, 12 Apr 2013 09:20:22 -0700
Message-ID: <CAPYLRzh669x=0xb9YGVkzEObGXheHd2o2LPpwU3Cwhfnzsb5ng@mail.gmail.com>
References: <loom.20130412T055215-88@post.gmane.org>
	<51683184.9010301@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:47488 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab3DLQUX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Apr 2013 12:20:23 -0400
Received: by mail-qa0-f49.google.com with SMTP id i13so969027qae.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Apr 2013 09:20:22 -0700 (PDT)
In-Reply-To: <51683184.9010301@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Matthias Urlichs <matthias@urlichs.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I was in the middle of writing a response to this when Mark's email
came in, so I'll just add a few things:

On Fri, Apr 12, 2013 at 9:08 AM, Mark Nelson <mark.nelson@inktank.com> =
wrote:
> On 04/11/2013 10:59 PM, Matthias Urlichs wrote:
>>
>> As I understand it, in Ceph one can cluster storage nodes, but other=
wise
>> every node is essentially identical, so if three storage nodes have =
a
>> file,
>> ceph randomly uses one of them.
>
>
> Ceph clusters have the concept of pools, where each pool has a certai=
n
> number of placement groups.  Placement groups are just collections of
> mappings to OSDs.  Each PG has a primary OSD and a number of secondar=
y ones,
> based on the replication level you set when you make the pool. When a=
n
> object gets written to the cluster, CRUSH will determine which PG the=
 data
> should be sent to.  The data will first hit the primary OSD and then
> replicated out to the other OSDs in the same placement group.
>
> Currently reads always come from the primary OSD in the placement gro=
up
> rather than a secondary even if the secondary is closer to the client=
=2E I'm
> guessing there are probably some tricks that could be played here to =
best
> determine which machines should service which clients, but it's not e=
xactly
> an easy problem.  In many cases spreading reads out over all of the O=
SDs in
> the cluster is better than trying to optimize reads to only hit local=
 OSDs.
> Ideally you probably want to prefer local OSDs first, but not exclusi=
vely.

In addition to just determining the locality (which we've started on
via external interfaces), this has a number of consistency challenges
associated with it. The infrastructure we have to allow reading from
non-primaries tends to involve clients having different consistency
expectations, and it's not fully explored yet or set up so that
clients can choose to read from a specific non-primary =97 the options
currently are "local if available and we can tell", "random", and
"primary".


>> This is not efficient use of network resources in a distributed data
>> center.
>> Or even in a multi-rack situation.
>>
>> I want to prefer accessing nodes which are "local".
>> The client in rack A should prefer to read from the storage nodes th=
at are
>> also in rack A.
>> Ditto for rack B.
>> Ditto for s/rack/data center/.

I do want to ask if you're sure this is as useful as you think it is.
There are use cases where it would be, but since writes have to
traverse these links (at a multiple of the actual write count) as well
you should be very certain. :)

>> As far as I understand, the Ceph clients can't do that.
>> (Nor can Ceph nodes among each other, but I care less about that, as=
 most
>> traffic is reading data.)
>>
>> I think this is an important feature for many high-reliability situa=
tions.
>>
>> What would be the next steps to get this feature, assuming I don't h=
ave
>> time
>> to implement it myself? Persistently annoy this mailing list that pe=
ople
>> need it? Offer to pay for implementing it? Shut up and look for some=
 other
>> solution -- which I already did, but I didn't find any that's as goo=
d as
>> Ceph, otherwise?
>
>
> I don't really have that much insight into the product roadmap, but I=
 assume
> that if you spoke to some of our business folks about paying for deve=
lopment
> work you'd at least get a response.

Yeah. It's not a feature in large enough demand right now that we can
see to be worth bumping up over other things, but I don't think
anybody's opposed to it existing. As with Mark I have no idea if
you're best off asking us or others to do things for money, but it
would certainly have to go through business channels. (If somebody
outside Inktank did want to implement this feature, I'd love to talk
to them about it on an informal but ongoing basis during development.)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
