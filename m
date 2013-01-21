From: Michael Grosser <mail@seetheprogress.com>
Subject: Re: Concepts of whole cluster snapshots/backups and backups in general.
Date: Mon, 21 Jan 2013 20:43:44 +0100
Message-ID: <CAH0TXZmR1GKSsq=3RskBsv4f4SH9-hQh8RFKxhjxvCPBBiviJQ@mail.gmail.com>
References: <CAH0TXZkjo0fkJx9x81RLBY0c7QfNs7ip6qAr-HFaWAapVC4o3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:47580 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab3AUTnq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jan 2013 14:43:46 -0500
Received: by mail-qc0-f175.google.com with SMTP id j3so79267qcs.34
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jan 2013 11:43:44 -0800 (PST)
In-Reply-To: <CAH0TXZkjo0fkJx9x81RLBY0c7QfNs7ip6qAr-HFaWAapVC4o3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

For anyone looking for a solution I want to outline the solution I
will go with in my coming setup.

First I wanna say I'm looking forward to the geo replication feature,
which hopefully features async replication and if there will someday
be some sort of snapshotted replica that would be another awesome
thing.

But for the time being:

For object storage (radosgw) I will use the admin function to retrieve
all buckets, retrieve all objects within these buckets and then back
them up into another offsite ceph or on some distributed logic on top
of simple rsync + fs
For block storage (rbd) I will use the snapshot feature to snapshot
all images for non corrupt and uptodate backup and then back them up
into another offsite ceph or on some distributed logic on top of
simple rsync + fs
For distributed fs (cephfs) I could use the snapshot feature too, but
I'm not yet using cephfs so it's just a consideration.

Some considerations:
I will probably go with offsite ceph with 2 replicas cause this will
distribute the load and make retrieval and so easier. (could be
accessible read only to users...)
The actual data retrieval of the live ceph cluster will probably be
done by some chef script running from time to time.
With the approach of using ceph at the backend buckets could have the
name of the date/time of the actual snapshot and therefore provide
reverting capabilities. (planned monthly and 3 days)

Some things to keep in mind:
Copying all data will drain the network bandwidth.
Keeping Snapshots of data of a production environment at scale with a
replica of 2 seems like a lot of storage is thrown away.
-> use 3+ replicas on production and perhaps only 1 replica in offsite backup?

With 3 replicas + 1 offsite replica + 1 monthly snapshot + 2-3 daily
snapshots the total amount of storage needed for 1 tb of data would
result in 7-8 tb in actual storage. Seems like a crazy idea to do 4-5
additional copies... (perhaps only have 1 monthly and the last day or
2)


Just a few ideas I wanted to throw at anyone interested.

Cheers Michael

On Tue, Jan 15, 2013 at 10:36 PM, Michael Grosser
<mail@seetheprogress.com> wrote:
> Hey,
>
> within this mail data is a reference to rados chunks so the actual
> data behind (fs/object/block storage).
>
> I was thinking about different scenarios, which could lead to data-loss.
>
> 1. The usual stupid customer deleting some important data.
> 2. The not so usual, totally corrupted cluster after upgrade or sorts.
> 3. The fun to think about "datacenter struck by [disaster] - nothing
> left" scenario.
>
> While thinking about these scenarios, I wondered how these disasters
> and the mentioned data-loss could be prevented.
> Telling customers data is lost, be it self inflicted or nature
> inflicted, is nothing you want or should need to do.
>
> But what are the technical solutions to provide another layer of
> disaster recovery (not just one datacenter with n replicas)?
>
> Some ideas, which came to mind:
>
> 1. Snapshotting (ability to get user deleted files + revert to old
> state after corruption)
> 2. Offsite backup (ability to recover from a lost datacenter)
>
> With these ideas a few problems came to mind.
> Is it cost effective to backup the whole cluster (would probably
> backup all replicas, which is not good at all?)?
> Is there a way to snapshot the current state and back it up to some
> offsite server array, could be another ceph cluster or a NAS?
> Do you really want to snapshot the non readable Ceph objects from rados?
> Shouldn't a backup always be readable?
>
> The simplest solution darkfaded from irc came up with was using
> special replicas.
> Using additional replicas, which only sync hourly, daily or monthly
> and dettach after sync could be a solution. But how could that be
> done?
> Some benefits of this solution:
> 1. Readable, cause it could a fully functioning cluster. Doable? Need
> for replication of gateways etc. or could that be intergrated within a
> special replica backup?
> 2. Easy recovery, just make the needed replica the "master".
> 3. No new system. Ceph in and out \o/
> 4. Offsite backup possibility.
> 5. Versioned states via different replicas hourly, daily, monthly
>
> Some problems:
> 1. strain on ceph cluster when sync is done for each special replica
> 2. additional disk space needed (could be double the already used
> amount, when using 3 replicas with one current, one daily, one monthly
> replica)
> 3. more costs
> 4. more complex solution?
>
> Could someone shed some light on how to have replicas without the
> write to be acknowledged for every replica and therefore only be a
> mirror instead of a full replica.
>
> Could this replica based backup be used as current snapshot in another
> datacenter?
>
> Wouldn't that be the async feature, which isn't yet possible sort of?
>
> I hope this mail is not too cluttered and I'm looking forward to the
> thread about it.
>
> Hopefully we can not only collect some ideas and solutions, but hear
> some current implementations from some bigger players.
>
> Cheers Michael
