From: Gregory Farnum <greg@inktank.com>
Subject: Re: cache tier blueprint (part 2)
Date: Sat, 9 Nov 2013 09:59:52 -0800
Message-ID: <CAPYLRzgw3BGFEy9GdJGMzXrmHGjssa-KEah4w1U5zK96oWpBSg@mail.gmail.com>
References: <alpine.DEB.2.00.1311070653290.17943@cobra.newdream.net>
	<CAPYLRzgmhso21XgOM8ZAvfr6Hcsuvbu0yd6g6NeNZcCOr_9Umw@mail.gmail.com>
	<alpine.DEB.2.00.1311082219130.4750@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63146 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594Ab3KIR7x convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 12:59:53 -0500
Received: by mail-wi0-f178.google.com with SMTP id hn9so694896wib.11
        for <ceph-devel@vger.kernel.org>; Sat, 09 Nov 2013 09:59:52 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311082219130.4750@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Nov 8, 2013 at 10:25 PM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 8 Nov 2013, Gregory Farnum wrote:
>> On Thu, Nov 7, 2013 at 6:56 AM, Sage Weil <sage@inktank.com> wrote:
>> > I typed up what I think is remaining for the cache tier work for f=
irefly.
>> > Greg, can you take a look?  I'm most likely missing a bunch of stu=
ff here.
>> >
>> >  http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rados_cache_=
pool_(part_2)
>> >
>> > This will be one of the meatier sessions at the upcoming CDS.  The=
re will
>> > be a fair bit of work not just on the OSD side but also in buildin=
g
>> > testing tools that exercise and validate the functionality, here, =
that
>> > may be a great way for a new contributer to get involved and help =
out.
>>
>> This looks reasonably complete to me as an enumeration of areas, but
>> is definitely targeted at the cache pool use case rather than demoti=
ng
>> to cold storage. I'm not sure yet if we're going to want to use the
>> same agent/process/whatever in both use cases; do you want a separat=
e
>> blueprint for that, or should we broaden this one?
>
> I think they are going to be quite similar, so it seems simplest to j=
ust
> start with this use-case and keep in mind that it may need to general=
ize
> slightly.  To a first approximation, both are making some decision ab=
out
> when to flush/evict or demote based on how old the object is and/or h=
ow
> full the pool is.  It will probably be a pretty compact bit of logic,=
 so
> I'm not too worried.
>
> The other question for me is where we want to implement the agent.  T=
he
> logic is pretty simple, and it can operate entirely using the new lib=
rados
> calls.  I may be simpler to drive it from a thread inside ceph-osd
> (simpler than managing a separate external daemon).  It might also be=
 easy
> (and slightly more efficient) to plug into the scrub process.  It is
> possible/likely that in the future we (or others) will want to constr=
uct
> more sophisticated policies using an external agent, but at this poin=
t the
> logic is simple enough that we can probably pick something simple and
> still be able to easily change it up down the line...

This is the big thing that worries me. I think that doing cold storage
demotion as part of scrub is the natural way to go since we're already
examining the objects, but a cache pool needs to be able to evict
stuff on-demand, and certainly on a faster cycle than every day or two
=97 so it needs to have a separate internal process.
Maybe that means we do a heavier-weight cache pool eviction process
first and use that for both, but I'm not sure we want to sandbox
ourselves that way?

We may also want to avoid giving external users access for the first
implementation just so we can learn a little more about it before
providing an API that we need to keep stable, although that thought
just popped into my head.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
