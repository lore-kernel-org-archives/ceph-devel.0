From: Paul Collins <paul.collins@canonical.com>
Subject: 0.47.2 -> 0.48: mon cluster (no cephx) failed to start until empty keyring files created
Date: Wed, 25 Jul 2012 11:36:38 +1200
Message-ID: <871uk0pw8p.fsf@agnew.wgtn.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55508 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368Ab2GXXgq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jul 2012 19:36:46 -0400
Received: from [203.79.106.241] (helo=agnew.wgtn.ondioline.org)
	by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <paul.collins@canonical.com>)
	id 1Stoei-0000M0-2W
	for ceph-devel@vger.kernel.org; Tue, 24 Jul 2012 23:36:44 +0000
Received: from agnew (agnew [127.0.0.1])
	by agnew.wgtn.ondioline.org (Postfix) with ESMTP id CF3932030E
	for <ceph-devel@vger.kernel.org>; Wed, 25 Jul 2012 11:36:38 +1200 (NZST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm running a 3-node test cluster on Ubuntu 12.04, without cephx
authentication. I started out running 0.47.2 packages (an
impatiently-smashed-together backport based on the upstream
sources) and then upgraded to 0.48-1ubuntu1 (the packages from
quantal rebuilt on precise). So my situation may be a bit special.

When I upgraded from 0.47.2 to 0.48, I didn't notice that my first
monitor daemon hadn't restarted properly.  I rolled through the upgrade
and ended up with a system where "ceph -s" would hang, being unable to
find a monitor willing to accept responsibility for the cluster.  I
splashed around rather a lot turning on debug logging. The monitors
tended to get as far as

2012-07-17 02:38:52.254856 7f3c3b862780 -1 auth: error reading file: /srv/ceph/mon.leningradskaya/keyring: can't open /srv/ceph/mon.leningradskaya/keyring: (2) No such file or directory
2012-07-17 02:38:52.254874 7f3c3b862780 -1 mon.leningradskaya@-1(probing) e1 unable to load initial keyring /etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin
2012-07-17 02:38:53.006423 7f3c3b860700  1 -- 10.55.200.21:6789/0 >> :/0 pipe(0x7f3c2c0008c0 sd=17 pgs=0 cs=0 l=0).accept sd=17
2012-07-17 02:38:53.231137 7f3c386a1700  1 -- 10.55.200.21:6789/0 >> :/0 pipe(0x7f3c2c000f60 sd=18 pgs=0 cs=0 l=0).accept sd=18
2012-07-17 02:38:53.308857 7f3c3849f700  1 -- 10.55.200.21:6789/0 >> :/0 pipe(0x7f3c2c0015c0 sd=19 pgs=0 cs=0 l=0).accept sd=19
2012-07-17 02:38:53.668990 7f3c3829d700  1 -- 10.55.200.21:6789/0 >> :/0 pipe(0x7f3c2c001c20 sd=20 pgs=0 cs=0 l=0).accept sd=20

with lines like the last four streaming endlessly.  Eventually I
tried creating an empty /srv/ceph/mon.leningradskaya/keyring and
the monitor daemon started right up. When I applied the same
change to the rest of the cluster, I was back in business. Here's
a log snippet from a successful 0.48 monitor daemon startup:

2012-07-17 02:47:03.036077 7f5f2a66f780  2 auth: KeyRing::load: loaded key file /srv/ceph/mon.leningradskaya/keyring
2012-07-17 02:47:03.036283 7f5f2a66f780 10 mon.leningradskaya@-1(probing) e1 bootstrap
2012-07-17 02:47:03.036319 7f5f2a66f780 10 mon.leningradskaya@-1(probing) e1 unregister_cluster_logger - not registered
2012-07-17 02:47:03.036346 7f5f2a66f780 10 mon.leningradskaya@-1(probing) e1 cancel_probe_timeout (none scheduled)
2012-07-17 02:47:03.036383 7f5f2a66f780  0 mon.leningradskaya@-1(probing) e1  my rank is now 1 (was -1)

continuing to log more besides as the cluster came back up.

One of my colleagues tried something similar, but his monitor
daemons came up like so:

2012-07-19 10:16:10.223092 7f9e20d22780 -1 auth: error reading file: /var/lib/ceph/mon/ceph-a/keyring: can't open /var/lib/ceph/mon/ceph-a/keyring: (2) No such file or directory
2012-07-19 10:16:10.235911 7f9e20d22780 1 mon.a@-1(probing) e1 copying mon. key from old db to external keyring

which is a little different -- is this "old db" something I should
have ended up with after a regular no-cephx mkcephfs deployment?
And also, I ran the various mkcephfs steps individually to avoid
having ssh across the whole cluster, so perhaps something fell
through the cracks there...

Here's my ceph.conf, minus tedious OSD boilerplate:

    [global]
     max open files = 131072
     log file = /var/log/ceph/$name.log
     pid file = /run/ceph/$name.pid

    [mon]
     mon data = /srv/ceph/$name

    [mon.prat]
     host = prat
     mon addr = 10.55.200.22:6789

    [mon.jackass]
     host = jackass
     mon addr = 10.55.200.20:6789

    [mon.leningradskaya]
     host = leningradskaya
     mon addr = 10.55.200.21:6789

Regards,
-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
