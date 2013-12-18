From: Gregory Farnum <greg@inktank.com>
Subject: Re: enable old OSD snapshot to re-join a cluster
Date: Wed, 18 Dec 2013 11:39:45 -0800
Message-ID: <CAPYLRzg6XCBu4B7P0o25q6oULVUQBzF8Jp4u2ONHtFeeAmqYjA@mail.gmail.com>
References: <orr4kbgbn3.fsf@livre.home>
	<CAPYLRzjG3ws-TJt+XOv0vp-oRuOZti+b1yjBZw_shhmdQE9F4g@mail.gmail.com>
	<orbo0faevz.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:42030 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab3LRTjq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Dec 2013 14:39:46 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so4045452qaq.15
        for <ceph-devel@vger.kernel.org>; Wed, 18 Dec 2013 11:39:45 -0800 (PST)
In-Reply-To: <orbo0faevz.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Dec 17, 2013 at 3:36 AM, Alexandre Oliva <oliva@gnu.org> wrote:
> On Feb 20, 2013, Gregory Farnum <greg@inktank.com> wrote:
>
>> On Tue, Feb 19, 2013 at 2:52 PM, Alexandre Oliva <oliva@gnu.org> wro=
te:
>>> It recently occurred to me that I messed up an OSD's storage, and
>>> decided that the easiest way to bring it back was to roll it back t=
o an
>>> earlier snapshot I'd taken (along the lines of clustersnap) and let=
 it
>>> recover from there.
>>>
>>> The problem with that idea was that the cluster had advanced too mu=
ch
>>> since the snapshot was taken: the latest OSDMap known by that snaps=
hot
>>> was far behind the range still carried by the monitors.
>>>
>>> Determined to let that osd recover from all the data it already had=
,
>>> rather than restarting from scratch, I hacked up a =93solution=94 t=
hat
>>> appears to work: with the patch below, the OSD will use the content=
s of
>>> an earlier OSDMap (presumably the latest one it has) for a newer OS=
DMap
>>> it can't get any more.
>>>
>>> A single run of osd with this patch was enough for it to pick up th=
e
>>> newer state and join the cluster; from then on, the patched osd was=
 no
>>> longer necessary, and presumably should not be used except for this=
 sort
>>> of emergency.
>>>
>>> Of course this can only possibly work reliably if other nodes are u=
p
>>> with same or newer versions of each of the PGs (but then, rolling b=
ack
>>> the OSD to an older snapshot would't be safe otherwise).  I don't k=
now
>>> of any other scenarios in which this patch will not recover things
>>> correctly, but unless someone far more familiar with ceph internals=
 than
>>> I am vows for it, I'd recommend using this only if you're really
>>> desperate to avoid a recovery from scratch, and you save snapshots =
of
>>> the other osds (as you probably already do, or you wouldn't have ol=
der
>>> snapshots to rollback to :-) and the mon *before* you get the patch=
ed
>>> ceph-osd to run, and that you stop the mds or otherwise avoid chang=
es
>>> that you're not willing to lose should the patch not work for you a=
nd
>>> you have to go back to the saved state and let the osd recover from
>>> scratch.  If it works, lucky us; if it breaks, well, I told you :-)
>
>> Yeah, this ought to basically work but it's very dangerous =97
>> potentially breaking invariants about cluster state changes, etc. I
>> wouldn't use it if the cluster wasn't otherwise healthy; other nodes
>> breaking in the middle of this operation could cause serious problem=
s,
>> etc. I'd much prefer that one just recovers over the wire using norm=
al
>> recovery paths... ;)
>
> Here's an updated version of the patch, that makes it much faster tha=
n
> the earlier version, particularly when the gap between the latest osd=
map
> known by the osd and the earliest osdmap known by the cluster is larg=
e.
> There are some #if0-ed out portions of the code for experiments that
> turned out to be unnecessary, but that I didn't quite want to throw
> away.  I've used this patch for quite a while, and I wanted to post a
> working version, rather than some cleaned-up version in which I might
> accidentally introduce errors.

Is this actually still necessary in the latest dumpling and emperor
branches? I thought sufficiently-old OSDs would go through backfill
with the new PG members in order to get up-to-date without copying all
the data.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
