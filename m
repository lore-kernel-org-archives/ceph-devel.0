From: Florian Haas <florian@hastexo.com>
Subject: Re: snap_trimming + backfilling is inefficient with many purged_snaps
Date: Sun, 21 Sep 2014 17:27:53 +0200
Message-ID: <CAPUexz8GhXyNPmxkF2DDwdGppndVOWHnmX9YjO=E-HgDejmXEQ@mail.gmail.com>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>
 <D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch> <CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com>
 <541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAPUexz_H7-b8SY6J+dLnAyw663eHXoLKYccB1edwH9XgFBZCpw@mail.gmail.com>
 <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com> <CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com>
 <alpine.DEB.2.00.1409181446110.19460@cobra.newdream.net> <CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com>
 <alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net> <CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com>
 <1878E4A4-2363-4717-ABEC-B587B0337D6B@cern.ch> <CABZ+qqks_qSbgG4QhkaH8A1zTP=o+fR4ptHPbtA9-MxrM8sJ5w@mail.gmail.com>
 <alpine.DEB.2.00.1409190819070.18018@cobra.newdream.net> <63ccef299522995cc0704e349ef86503@webmail.vanderster.com>
 <CAME-gARt1NZmEFj6SCpxkfxnibXyR7+AdYKO4YNkQc_n+XJuXQ@mail.gmail.com>
 <CAPUexz-L=3O0qCkLWiW2UxUfJ0ryOLfO2w7A=kacOLoFui7ceA@mail.gmail.com> <7305be37366a5eadf5a3114efe1b0383@webmail.vanderster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:46041 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbaIUP2O convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Sep 2014 11:28:14 -0400
Received: by mail-qa0-f44.google.com with SMTP id dc16so2632587qab.31
        for <ceph-devel@vger.kernel.org>; Sun, 21 Sep 2014 08:28:13 -0700 (PDT)
In-Reply-To: <7305be37366a5eadf5a3114efe1b0383@webmail.vanderster.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <daniel.vanderster@cern.ch>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Sun, Sep 21, 2014 at 4:26 PM, Dan van der Ster
<daniel.vanderster@cern.ch> wrote:
> Hi Florian,
>
> September 21 2014 3:33 PM, "Florian Haas" <florian@hastexo.com> wrote:
>> That said, I'm not sure that wip-9487-dumpling is the final fix to the
>> issue. On the system where I am seeing the issue, even with the fix
>> deployed, osd's still not only go crazy snap trimming (which by itself
>> would be understandable, as the system has indeed recently had
>> thousands of snapshots removed), but they also still produce the
>> previously seen ENOENT messages indicating they're trying to trim
>> snaps that aren't there.
>>
>
> You should be able to tell exactly how many snaps need to be trimmed. Check the current purged_snaps with
>
> ceph pg x.y query
>
> and also check the snap_trimq from debug_osd=10. The problem fixed in wip-9487 is the (mis)communication of purged_snaps to a new OSD. But if in your cluster purged_snaps is "correct" (which it should be after the fix from Sage), and it still has lots of snaps to trim, then I believe the only thing to do is let those snaps all get trimmed. (my other patch linked sometime earlier in this thread might help by breaking up all that trimming work into smaller pieces, but that was never tested).

Yes, it does indeed look like the system does have thousands of
snapshots left to trim. That said, since the PGs are locked during
this time, this creates a situation where the cluster is becoming
unusable with no way for the user to recover.

> Entering the realm of speculation, I wonder if your OSDs are getting interrupted, marked down, out, or crashing before they have the opportunity to persist purged_snaps? purged_snaps is updated in ReplicatedPG::WaitingOnReplicas::react, but if the primary is too busy to actually send that transaction to its peers, so then eventually it or the new primary needs to start again, and no progress is ever made. If this is what is happening on your cluster, then again, perhaps my osd_snap_trim_max patch could be a solution.

Since the snap trimmer immediately jacks the affected OSDs up to 100%
CPU utilization, and they stop even responding to heartbeats, yes they
do get marked down and that makes the issue much worse. Even when
setting nodown, though, then that doesn't change the fact that the
affected OSDs just spin practically indefinitely.

So, even with the patch for 9487, which fixes *your* issue of the
cluster trying to trim tons of snaps when in fact it should be
trimming only a handful, the user is still in a world of pain when
they do indeed have tons of snaps to trim. And obviously, neither of
osd max backfills nor osd recovery max active help here, because even
a single backfill/recovery makes the OSD go nuts.

There is the silly option of setting osd_snap_trim_sleep to say 61
minutes, and restarting the ceph-osd daemons before the snap trim can
kick in, i.e. hourly, via a cron job. Of course, while this prevents
the OSD from going into a death spin, it only perpetuates the problem
until a patch for this issue is available, because snap trimming never
even runs, let alone completes.

This is particularly bad because a user can get themselves a
non-functional cluster simply by trying to delete thousands of
snapshots at once. If you consider a tiny virtualization cluster of
just 100 persistent VMs, out of which you take one snapshot an hour,
then deleting the snapshots taken in one month puts you well above
that limit. So we're not talking about outrageous numbers here. I
don't think anyone can fault any user for attempting this.

What makes the situation even worse is that there is no cluster-wide
limit to the number of snapshots, or even say snapshots per RBD
volume, or snapshots per PG, nor any limit on the number of snapshots
deleted concurrently.

So yes, I think your patch absolutely still has merit, as would any
means of reducing the number of snapshots an OSD will trim in one go.
As it is, the situation looks really really bad, specifically
considering that RBD and RADOS are meant to be super rock solid, as
opposed to say CephFS which is in an experimental state. And contrary
to CephFS snapshots, I can't recall any documentation saying that RBD
snapshots will break your system.

Cheers,
Florian
