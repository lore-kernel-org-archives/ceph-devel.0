From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSDMap checksums
Date: Tue, 19 Aug 2014 21:35:21 -0700
Message-ID: <CAPYLRzioYDorFaruE5nnQgVZrxC9vDckT6Et6KmWhFaYt4fszw@mail.gmail.com>
References: <alpine.DEB.2.00.1408191528070.28247@cobra.newdream.net>
	<CAPYLRziaU2R57axjLVmkSX6P7F9gwHhwHMBtHgmVq0a2pd=P3g@mail.gmail.com>
	<alpine.DEB.2.00.1408191723440.28244@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:38918 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbaHTEfX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Aug 2014 00:35:23 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so6587192qaq.10
        for <ceph-devel@vger.kernel.org>; Tue, 19 Aug 2014 21:35:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408191723440.28244@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 19, 2014 at 5:32 PM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 19 Aug 2014, Gregory Farnum wrote:
>> On Tue, Aug 19, 2014 at 3:43 PM, Sage Weil <sweil@redhat.com> wrote:
>> > We have had a range of bugs come up in the past because OSDs or mo=
ns have
>> > been running different versions of the code and have encoded diffe=
rent
>> > variations of the same OSDMap epoch.  When two nodes in the system
>> > disagree about what the data distribution is, all manner of things=
 can go
>> > wrong and the effects are very difficult to debug.
>> >
>> > Several times we've said that we should be adding a crc or checksu=
m to the
>> > canonical encoded OSDMap so that we'll know if we're getting the "=
right"
>> > version or not.  One could imagine in a less trusted environment t=
his
>> > would be analogous to a signed version.
>> >
>> > I've started a wip-osdmap branch to do this, but have hit a few bu=
mps.
>> >
>> > Generally speaking, we want only the mons (and only the leader mon=
) to
>> > ever be allowed to encode (and checksum/sign) a new OSDMap or incr=
emental.
>> > (The only real exception here is that the MOSDMap message reencode=
s maps
>> > with older encoding strategies for old clients, but those old clie=
nts
>> > clearly won't support the new crc, so they get a free pass.)
>> >
>> > The trouble is that in general we share maps very liberally.  More
>> > specifically, we share _incremental_ maps.  The incremental map wi=
ll be
>> > encoded so that it itself has a crc, and also it has the crc of wh=
at the
>> > final OSDMap will have once the incremental has been applied, so t=
hat you
>> > can verify you got the right answer.
>> >
>> > The problem is what to do if you don't.  This can happen for a few
>> > different reasons, but usually it is just that we added a field to=
 a data
>> > structure that is included in the OSDMap.
>> >
>> > The main entity affected by this is the OSDs: they store a history=
 of
>> > incremntal maps *and* full maps, and share full and incremental ma=
ps with
>> > clients and peers.  We don't want them to ever share a full map th=
at did
>> > not match the specified crc as it might different from the canonic=
al
>> > version in some subtle (but problematic) way.
>> >
>> > A simple strategy would be to simply go back to the mons if we eve=
r run
>> > into this and ask for original (full) copies of the OSDMaps whose
>> > encodings we got wrong.  This works, but has a few potential probl=
ems:
>> >
>> >  - The general "upgrade mons first" strategy will mean mons will s=
tart
>> > generating maps that older osds can't replicate, and suddently eve=
ry will
>> > be hammering them for full maps.
>> >  - We could ask our peers, but there's no guarantee that they will=
 be any
>> > better off.
>> >
>> > We could:
>> >
>> >  - Have users upgrade OSDs before mons.  That way no 'new' osdmaps=
 will
>> > get generated before the osds are able to reencode them correctly.
>> >  - Make the osd peers smarter about how they share maps with each =
other so
>> > that they can also tell when they need full maps and not just
>> > incrementals.
>> >
>> > ...or perhaps both.  The former avoids the problem, the latter cop=
es with
>> > it.  I'm a bit unsure how to do make the latter algorithm simple (=
mostly
>> > stateless) and efficient, though.
>> >
>> > Any other ideas?
>>
>> How stateless do we need it to be? I don't remember all the details =
of
>> how OSDs generate their incrementals for sharing, but:
>> 1) Going forward, we can make sure that OSDs share full maps (or
>> Incrementals that they've received from the monitor instead of
>> self-generated) whenever they didn't make use of all the data in the
>> encoded bufferlist (or, perhaps, based on some supported feature bit=
s
>> in the OSDMap itself?)
>
> I'd planned on doing a check after we receive and apply an incrementa=
l
> where we reencode our map and compare the crc to the one in the
> incremental.  If it doesn't match, we will know there is a problem.
>
>> 2) We can set up OSDs so that they query the monitor (or, optionally=
,
>> a peer with a sufficient set of feature bits?) whenever they see a
>> checksum that doesn't match what they generate (...and eventually, d=
o
>> something more to check their prior maps?)
>
> There isn't necessarily a 1:1 mapping onto feature bits.  We might ad=
d
> fields to encodable data structures that will subtley get reset to th=
e
> default by older code.  Only if we plan on relying on us being very
> careful could we get away with feature bits...  That said, it would m=
ake
> our lives easier, because the mon could encode the map using the feat=
ure
> bits supported by all osds.  Only after they all restart will new stu=
ff
> kick in.  (We probably want to do that anyway).  But I still worry
> think it would be nice to guarantee we have a bit-for-bit accurate
> version of the osdmap before we ever use or share it.
>
> In any case, though, the problem is that we will eventaully reach a
> point where we just received an incremental and realized that it lead=
s to
> a new OSDMap that we can't accurately recreate.  What do we do?
> Obviously, we throw it on the floor.

Right, so let's talk about how we get into that situation:
1) Our existing OSDMap is "bad."
  a) We were never "correct"
  b) ...we went bad and didn't notice?
2) The Incremental we got is "bad".
  a) It's not the original Incremental generated by the mon cluster
  b) ...it got corrupted?
3) We don't understand the Incremental we got and applied it wrong
(Any other categories I'm missing?)

Let's leave out case 1a, because that's largely a transitional issue.
1b should be protected against thanks to the checksums.
2a just means that every time anybody sends an Incremental, it better
be the original. 2b should again be protected against thanks to its
checksum
3 is a little tricky: apparently we don't understand the full map, but
we're allowed to stay in the cluster according to feature bits and
other protections. So I think we're going to need to expose special
feature bits associated with the OSD Map, or perhaps just the encoding
version, in order to distinguish between "this isn't working right"
and "I don't understand it but I can keep running".

Given that, we have two big challenges:
1) We need to get any currently-divergent OSDMaps into sync for the
initial upgrade to this checksummed system,
2) We need to prevent any OSD which doesn't completely understand a
map format from transmitting any self-generated bufferlists.

The only way OSDs transmit self-generated bufferlists is if the
peer/client they're sending to isn't contiguous with the set of
Incrementals the OSD already has; in this case the OSD will encode and
send its oldest OSDMap. (Or at least, this is the obvious and most
important case where they do that.) This is a pretty rare case and I
think we'd probably be okay with just having the peer go to the
monitors instead if this happens?
So then we just have the upgrade issue to deal with. I think if we
prevent the monitors from enabling checksums until all the OSDs
support it, and then just have the OSDs query the monitors for any
non-conforming maps on upgrade, we should be good =E2=80=94 divergent O=
SDMaps
are pretty rare.

Is there some scenario I'm not accounting for that's concerning you?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
