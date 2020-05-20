From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Possible bug in op path?
Date: Wed, 20 May 2020 00:40:39 -0700
Message-ID: <CAANLjFqkgn86Oa=70jHqHB-4o0saL9Q+AGPuGyyj94x7EiSi2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: ceph-users <ceph-users-a8pt6IJUokc@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

We upgraded our Jewel cluster to Nautilus a few months ago and I've noticed
that op behavior has changed. This is an HDD cluster (NVMe journals and
NVMe CephFS metadata pool) with about 800 OSDs. When on Jewel and running
WPQ with the high cut-off, it was rock solid. When we had recoveries going
on it barely dented the client ops and when the client ops on the cluster
went down the backfills would run as fast as the cluster could go. I could
have max_backfills set to 10 and the cluster performed admirably.
After upgrading to Nautilus the cluster struggles with any kind of recovery
and if there is any significant client write load the cluster can get into
a death spiral. Even heavy client write bandwidth (3-4 GB/s) can cause the
heartbeat checks to raise, blocked IO and even OSDs becoming unresponsive.
As the person who wrote the WPQ code initially, I know that it was fair and
proportional to the op priority and in Jewel it worked. It's not working in
Nautilus. I've tweaked a lot of things trying to troubleshoot the issue and
setting the recovery priority to 1 or zero barely makes any difference. My
best estimation is that the op priority is getting lost before reaching the
WPQ scheduler and is thus not prioritizing and dispatching ops correctly.
It's almost as if all ops are being treated the same and there is no
priority at all.
Unfortunately, I do not have the time to set up the dev/testing environment
to track this down and we will be moving away from Ceph. But I really like
Ceph and want to see it succeed. I strongly suggest that someone look into
this because I think it will resolve a lot of problems people have had on
the mailing list. I'm not sure if a bug was introduced with the other
queues that touches more of the op path or if something in the op path
restructuring that changed how things work (I know that was being discussed
around the time that Jewel was released). But my guess is that it is
somewhere between the op being created and being received into the queue.
I really hope that this helps in the search for this regression. I spent a
lot of time studying the issue to come up with WPQ and saw it work great
when I switched this cluster from PRIO to WPQ. I've also spent countless
hours studying how it's changed in Nautilus.

Thank you,
Robert LeBlanc
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
