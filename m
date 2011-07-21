From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: architecture questions - OSD layout
Date: Thu, 21 Jul 2011 09:25:29 -0700
Message-ID: <CA+qbEUNrARNq8PLigcx0H7dQYrSAtgQ_ND4W2sSS1A7KVuoQzA@mail.gmail.com>
References: <CALFpzo74hRFUis0-P+ekPuC5eqa1AbM4aEimB+zO=cU-mgpjsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43316 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab1GUQZb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2011 12:25:31 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 84CEFC064
	for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2011 09:26:03 -0700 (PDT)
Received: from mail-fx0-f52.google.com (mail-fx0-f52.google.com [209.85.161.52])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id E75D1C062
	for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2011 09:26:02 -0700 (PDT)
Received: by fxd18 with SMTP id 18so3790309fxd.11
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2011 09:25:29 -0700 (PDT)
In-Reply-To: <CALFpzo74hRFUis0-P+ekPuC5eqa1AbM4aEimB+zO=cU-mgpjsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jul 20, 2011 at 9:30 PM, Marcus Sorensen <shadowsor@gmail.com> =
wrote:
> First off, I just want to say that I'm pretty excited about the
> possibilities that the Ceph system presents. I've been vaguely aware
> of it for awhile now, and just recently started playing with it. I've
> read most of the wiki, have gone back several months through the
> archives, and at this point I'd like to dedicate resources to testing
> and helping where I can in making Ceph production ready, even if we
> don't end up having any immediate production uses for it. In the next
> little while I'll be scraping together some test hardware and trying
> various usage and break/fix scenarios.
>
> I've thought a lot about how we'd go about using Ceph in place of
> several of our existing storage systems (were it ready), and would
> like to hear what others have done and/or feedback on my thoughts. My
> main point of curiosity at this point revolves around how best to
> allocate the OSDs.
>
> Let's assume we have a few dozen storage nodes with anywhere from 45
> to 216 drives (say 1-3T) on a 10Gbit network. =A0The wiki suggests a =
few
> setups: =A0multiple cosd daemons per physical server with possibly on=
e
> cosd per storage device, one cosd daemon per physical server and
> pooling the drives somehow (e.g. was btrfs raid1 or something), or
> possibly one of the variations in between. I'm sure I'll end up
> testing several variations, but I'm interested in fleshing out some o=
f
> the pros and cons between the various setups.
>
> First off, I'm wondering what cpu/memory limitations we might run
> into. Perhaps it's more prudent to do fewer drives per server (most
> configurations I've read of so far have only a few drives per server)=
?
> Or maybe with tcmalloc the limit will be very high on what a single
> motherboard can drive to handle the OSD load, pushing the bottleneck
> to the drives/SAS cards?

I think in the long term, having one cosd per drive is a better way to
go because you will get more parallelism. There are a bunch of
process-level locks in any multithreaded program, like the malloc
lock. We also have some of our own like the dout lock. The natural way
to get around these bottlenecks is to have multiple processes.

Also, as Sage mentioned, RAID uses block-level rereplication, which
will always rebuild an entire disk-- unlike our object-level
rereplication process. We have been working on the recovery code
lately in an effort to fix some corner cases. I think there are still
some cases that need more testing.

On the other hand, there is some fixed overhead to having multiple
cosd processes running. RAIDing a few disks might be a good option if
the fixed overhead of having a cosd per disk is too much.

> One of my coworkers thinks it's a good idea to define each physical
> disk as an OSD and rely solely on Ceph's data replication. Pros to
> this include relatively quick recovery when an OSD goes out, as well
> as maximum storage capacity, but I have a minor concern that
> configuration will become cumbersome with that many drives, and a
> larger concern that with as few as 2 drives lost there's a chance tha=
t
> both copies of a given 4MB object may have been on those drives, and
> unless I'm missing something about how the replication works we'd los=
e
> data.

I think this can be addressed by setting up an appropriate crush map.
Then both copies of the data won't end up on cosds hosted on the same
computer.

regards,
Colin

> And I'm not sure what that means as far as system reliability.
> Would we simply need to repopulate that data and move on, or does the
> whole system burn to the ground, clients sit forever in D state, etc
> (maybe there was metadata on those objects)? That will be one for
> testing. Another con to be seen is the apparent memory consumption pe=
r
> OSD.
>
> An alternative might be to call an OSD a 12-drive RAID50 or RAID6 or
> something, with each server having 15 or so OSDs. The downside to tha=
t
> is when the OSD is marked out the whole cluster will start spinning
> trying to replicate 20T worth of data (the 10G network will come in
> handy :-), but it seems perhaps less likely that we'd lose two OSDs a=
t
> a time, with the tradeoff that losing two is more catastrophic as far
> as potential overlap and lost data. =A0It seems like performance woul=
d
> also be lower, although with the OSD streaming journal we may actuall=
y
> end up with decent performance on writes if it keeps us writing full
> stripes. I'm not sure how in-place modification of small data would b=
e
> handled but presumably you'd still have to read the stripe to modify =
a
> portion of the data therein.
>
> I don't really see us pooling individual drives via btrfs into raid1
> or raid10 for redundancy, between that and the hit on object
> replication we'd lose too much capacity.
>
> Also, I'd assume losing the OSD journal is a recoverable event? Just
> thinking about whether the SSD should be RAID-1, or going the other
> direction if ramdisk would be acceptable.
>
> Have I gone on long enough yet? :-) =A0In short, the usage scenario
> we're toying with might be summed up as follows: We'd like to optimiz=
e
> for cluster stability and capacity, data loss is undesirable of
> course, but acceptable so long as the cluster itself can continue
> functioning and not bring everything to its knees (clients and all) i=
f
> objects are lost. At this point we'll just have to try a few things,
> not knowing how failure scenarios might be expected to play out, but =
I
> thought I'd send out this request for comments.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
