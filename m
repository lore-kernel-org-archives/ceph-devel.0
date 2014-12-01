From: Sage Weil <sage@newdream.net>
Subject: Re: Pending list of dumpling backports
Date: Sun, 30 Nov 2014 19:40:38 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411301939100.352@cobra.newdream.net>
References: <CABYiri-qu6Kb67MoDrBAs70TmGtSL70yMQespu4mEkV5O_Z6UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47339 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbaLADkj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Nov 2014 22:40:39 -0500
In-Reply-To: <CABYiri-qu6Kb67MoDrBAs70TmGtSL70yMQespu4mEkV5O_Z6UQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Thu, 27 Nov 2014, Andrey Korolyov wrote:
> Hello,
> 
> out of curiousity, I`ve compared git logs for master and for dumpling
> branch, selecting all backport-to-dumpling marks and comparing
> resulting list with the actual set of dumpling backports. The attached
> list resembles commits for which backporting message was omitted in
> the commit log or backport does not exist at all (the second ones
> prevails). Unfortunately the procedure require a lot of manual
> actions. like checking cherry-picks from merge commits, so it is very
> poorly automated and for another stable a bit of monkey work is
> required.

Thanks, Andrey, for putting this list together!  Copying ceph-devel so 
that it doesn't get lost, and including the list inline, below. I wish we 
could automate this process but I suspect it would be challenging...

Thanks!
sage

a0929955cb84fb8cfdeb551d6863e4955b8e2a71 mds: fix locking, use-after-free/race in handle_accept
5bdbe9d617d6d9a00026b3b65833c4338bc9541f Merge pull request #489 from ceph/wip-5903
fefe0c602f78e66d35fd5806da4c2e4e154a267c config: fix stringification of config values
985a1405db6364d4283b68c681d6a4e816decf7e librados: add get_version64()
daf417f9ccc9181c549ad2d4a19b16b0c3caf85f osd/ReplicatedPG.cc: Verify that recovery is truly complete
1c12eefcb5ca9fa6204d9a6f514829d539502d94 osd/ReplicatedPG: fix leak of RepGather on watch timeout
acc47d234af63b1f707a7633f41655e8997b9aeb include: Bug fixes for CompatSet
46057925a8d409e70d29a073fe2afaff94333c36 librados: pool async create / delete does not delete completion handle
8912462f0c9956d1162567de51efa65f268d0d9d rgw: drop async pool create completion reference
34d09417b76eb38a4be52b0c90551239af99a839 client: fix invalid iterator dereference in Client::trim_caps()
df229e5eff63e46f83a18fab2e1db497a789309b mon/PGMonitor: always send pg creations after mapping
d8d27f13e11dcaefd3aa1c049b97c980283da575 JounralingObjectStore: journal->committed_thru after replay
cf099415ad5ad7560a33efd0016293becc70858a mon: MDSMonitor: implement 'get_trim_to()' to let the mon trim mdsmaps
00048fe33fb76adbc19ffaef960fe52a73b62849 mon: Have 'ceph report' print last committed versions
aa365e4b1a7fabfc8187d56f21fec127ee016379 mon: typo s/degrated/degraded/
8c5c55c8b47ee3c94c0dbcd82e0588ae629ba0ea mon: set next commit in mon command replies
824dd52b2a4b1f9b78e50920aef0ac94f18436a9 mon/MonCap: handle any whitespace (not just space)
a0b2c74647e9aafe35b14751d6607b50e2814318 osd/OSDCap: handle any whitespace (not just space)
1dae27c50538c066a7f22702838100baf243904b ReplicatedPG: return no data if read size is trimmed to zero
e550ad79154ead3c276a2cdefc75ced02c43d4c4 ReplicatedPG: avoid undefined behavior in xattr comparison
23e538efa4f0c59b65fb55a0e27bbf0cf2480c01 client: fix possible null dereference in create
73c59a022f011cb8d84ef5e8fed8df50846bd223 mon/PGMap: fix osd_epochs update
0f75c5419d61aed63b6cb785145ffd89221a6751 osd/ReplicatedPG: fix enqueue_front race
8bd89442aeb6f9fa7c2dea80b793aae4d70d50c9 common/PrioritizedQueue: fix remove_by_class() corner case
d78e67885529726368544ecbdc8b2060240a921b osd/PG: fix choose_acting revert to up case
bd8e026f88b812cc70caf6232c247844df5d99bf rgw: don't allow multiple writers to same multiobject part
6b858be0676f937a99dbd51321497f30c3a0097f osd: handle race between osdmap and prepare_to_stop
f1b890ecb3515bdd3e87ed67dd810e632013e42a osd: fix bad is_active() assert in share_map()
f3ec7d0b23fdee39a34bda7595cd2a79c08daf8a osd: add sanity check/warning on a few key configs
7fae941299e0c3ffc7a3016d94579d21c80d8956 rgw: allocate enough space for bucket instance id
b551ae2bcea2dd17b37f5f5ab34251cc78de0e26 mon: AuthMonitor: always encode full regardless of keyserver having keys
5773a374d0089ce824dec0a0c74a76e57806cc43 upstart/ceph-osd.conf: bump nofile limit up by 10x
7a9b986ac511541949922560d8d32be878f6a923 rados: add {read,write}_ops to df json
5663f91b600749a701cf040b8040c2d81adea3d9 rados: fix {read,write}_bytes value
f81d2b0eaa473ccfc787663b143959d0babf8b05 mon: fix divide by zero when pg_num adjusted and no osds
19df386b2d36d716be2e6d02de0386fac9e7bc1f mon: fix occasional message leak after session reset
2b13de16c522754e30a0a55fb9d072082dac455e osd/PG: fix crash from second backfill reservation rejection
97f9b6df668315fba6a5924b79024c7a986f4110 mon/OSDMonitor: fix double-free on old MOSDBoot
cfc68307843ea5fa878cf2f7fe9f45f25c9f9e99 common/Finisher: fix perfcounter
4be53d5eebbc294878ba38050d841359b6c8e19e PG: check full ratio again post-reservation
44cfd88dc65d30f4295743c5834768bb13f7b805 rgw: PutObjMetadata, clear bufferlist before appending into it
f833f12a200ecc2c4f74ddb443d6fa61b7ad14db rgw: rados->set_attrs() updates bucket index
624aaf2a4ea9950153a89ff921e2adce683a6f51 PG: release backfill reservations if a backfill peer rejects
83888362089346e473d6fd6e1d366b826d7bd739 ceph.spec.: add epoch
5b41d80b7fb9ed96c26801fc42c044191bb18d84 rgw: swift GET / HEAD object returns X-Timestamp field
cb9262abd7fd5f0a9f583bd34e4c425a049e56ce Objecter: resend linger ops on any interval change
a5184cf46a6e867287e24aeb731634828467cd98 client: cast m->get_client_tid() to compare to 16-bit Inode::flushing_cap_tid
8924158df8580bbb462130b5bb7f753b13513a23 JounralingObjectStore: journal->committed_thru after replay
093c5f0cabeb552b90d944da2c50de48fcf6f564 mon/PGMap and PGMonitor: update last_epoch_clean cache from new osd keys
cd784eab22a329cd3eb3798feb9d975a4506c57e osdc: Constrain max number of in-flight read requests
0d350b6817d7905908a4e432cd359ca1d36bab50 librbd: protect list_children from invalid child pool IoCtxs


