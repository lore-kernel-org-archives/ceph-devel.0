From: Michael Grosser <mail@seetheprogress.com>
Subject: Concepts of whole cluster snapshots/backups and backups in general.
Date: Tue, 15 Jan 2013 22:36:23 +0100
Message-ID: <CAH0TXZkjo0fkJx9x81RLBY0c7QfNs7ip6qAr-HFaWAapVC4o3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:33523 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab3AOVgZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 16:36:25 -0500
Received: by mail-qa0-f45.google.com with SMTP id j15so2816839qaq.4
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 13:36:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey,

within this mail data is a reference to rados chunks so the actual
data behind (fs/object/block storage).

I was thinking about different scenarios, which could lead to data-loss.

1. The usual stupid customer deleting some important data.
2. The not so usual, totally corrupted cluster after upgrade or sorts.
3. The fun to think about "datacenter struck by [disaster] - nothing
left" scenario.

While thinking about these scenarios, I wondered how these disasters
and the mentioned data-loss could be prevented.
Telling customers data is lost, be it self inflicted or nature
inflicted, is nothing you want or should need to do.

But what are the technical solutions to provide another layer of
disaster recovery (not just one datacenter with n replicas)?

Some ideas, which came to mind:

1. Snapshotting (ability to get user deleted files + revert to old
state after corruption)
2. Offsite backup (ability to recover from a lost datacenter)

With these ideas a few problems came to mind.
Is it cost effective to backup the whole cluster (would probably
backup all replicas, which is not good at all?)?
Is there a way to snapshot the current state and back it up to some
offsite server array, could be another ceph cluster or a NAS?
Do you really want to snapshot the non readable Ceph objects from rados?
Shouldn't a backup always be readable?

The simplest solution darkfaded from irc came up with was using
special replicas.
Using additional replicas, which only sync hourly, daily or monthly
and dettach after sync could be a solution. But how could that be
done?
Some benefits of this solution:
1. Readable, cause it could a fully functioning cluster. Doable? Need
for replication of gateways etc. or could that be intergrated within a
special replica backup?
2. Easy recovery, just make the needed replica the "master".
3. No new system. Ceph in and out \o/
4. Offsite backup possibility.
5. Versioned states via different replicas hourly, daily, monthly

Some problems:
1. strain on ceph cluster when sync is done for each special replica
2. additional disk space needed (could be double the already used
amount, when using 3 replicas with one current, one daily, one monthly
replica)
3. more costs
4. more complex solution?

Could someone shed some light on how to have replicas without the
write to be acknowledged for every replica and therefore only be a
mirror instead of a full replica.

Could this replica based backup be used as current snapshot in another
datacenter?

Wouldn't that be the async feature, which isn't yet possible sort of?

I hope this mail is not too cluttered and I'm looking forward to the
thread about it.

Hopefully we can not only collect some ideas and solutions, but hear
some current implementations from some bigger players.

Cheers Michael
