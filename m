From: David McBride <dwm@doc.ic.ac.uk>
Subject: Re: Increasing the number of PGs
Date: Wed, 28 Mar 2012 13:45:33 +0100
Message-ID: <1332938733.8411.96.camel@squire.doc.ic.ac.uk>
References: <20120326213459.e8ace6f3.ctpm@ist.utl.pt>
	 <CAORUGqBzBBoi3TeWcqzyeN7vSW+=FCLM72MnPJfCqOFrQ9iOdg@mail.gmail.com>
	 <1332848771.8411.68.camel@squire.doc.ic.ac.uk>
	 <1332866711.8411.70.camel@squire.doc.ic.ac.uk>
	 <Pine.LNX.4.64.1203271105180.1271@cobra.newdream.net>
	 <1332882253.8411.72.camel@squire.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cardinal.doc.ic.ac.uk ([146.169.1.194]:34909 "EHLO
	cardinal.doc.ic.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab2C1Mpn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Mar 2012 08:45:43 -0400
In-Reply-To: <1332882253.8411.72.camel@squire.doc.ic.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel@vger.kernel.org

On Tue, 2012-03-27 at 22:04 +0100, David McBride wrote:
> On Tue, 2012-03-27 at 11:06 -0700, Sage Weil wrote:
> 
> > This shouldn't change the PG count either.  If you do
> > 
> >  ceph osd dump | grep ^pool
> > 
> > you'll see a pg_num value for each pool that should remain constant.  
> > Only the size should change (replica count)...
> 
> Okay, that's what I was expecting.  I earlier rebuilt the cluster and
> repeated my earlier results; however, I don't have the output of those
> commands to hand.

Hi,

Results are in.  Something odd is going on; the results returned by
`ceph -s` and `ceph osd dump` are inconsistent:

* `ceph osd dump` does indeed indicate that the pg_num values are 
  remaining constant for each pool before and after changing the replica
  count.

* However, the total number of PGs being reported by `ceph -s` or 
  `ceph -w` increases immediately after issuing the replica count change
  command for a pool.  The increase in size is equal to the number of 
  live OSDs; in this case, 28.

* This apparent (silent) increase in PG count will occur three times if
  the change is applied to all three pools, `data`, `metadata`, and 
  `rbd`.  

* Changing the replica count up and down again after the initial  
  increase has no effect on the reported replica count.

* My steps for reproducing are:

  - Mint a new cluster, with 14 OSDs stored on server A.
  - Start the cluster.
  - Add some data to the `rbd` pool using `rados bench`.
  - Initialize 14 additional OSDs on server B.
  - Add the server B OSDs to the cluster.
  - Increase the replica count.

  This process is probably not minimal.  I can try to run some 
  experiments to see what factors are significant.
  (I'm pretty sure I could skip the `rados bench` step, for example.)

* In case it makes a difference, I'm using XFS, not BTRFS, for the OSD's
  backing-store.


Here's the output of ceph status commands during the various stages:


Prior to OSD addition:
======================

output from: `ceph -s`:

> 2012-03-28 12:30:25.086686    pg v133: 2772 pgs: 2772 active+clean; 13252 MB data, 55720 MB used, 1857 GB / 1911 GB avail
> 2012-03-28 12:30:25.101300   mds e1: 0/0/1 up
> 2012-03-28 12:30:25.101424   osd e11: 14 osds: 14 up, 14 in
> 2012-03-28 12:30:25.101689   log 2012-03-28 12:25:22.596734 mon.0 146.169.21.55:6789/0 16 : [INF] osd.8 146.169.1.13:6836/6339 boot
> 2012-03-28 12:30:25.101897   mon e1: 1 mons at {vm-cephhead=146.169.21.55:6789/0}

output from: `ceph osd dump | grep pg_num`:

> pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 1 owner 0 crash_replay_interval 45
> pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 1 owner 0
> pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 1 owner 0


Adding the second set of OSDs:
=============================

output from: `ceph osd dump | grep pg_num`:

> pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 1 owner 0 crash_replay_interval 45
> pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 1 owner 0
> pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 1 owner 0

Changing `rbd` pool replica count:
=================================

output from: `ceph -w`:

> 2012-03-28 12:36:36.768714    pg v313: 2772 pgs: 2772 active+clean; 13252 MB data, 86002 MB used, 3739 GB / 3823 GB avail
> 2012-03-28 12:36:37.763292    pg v314: 2772 pgs: 2772 active+clean; 13252 MB data, 85163 MB used, 3740 GB / 3823 GB avail

(issued: `ceph osd pool set rbd size 3`)

> 2012-03-28 12:36:42.308575    pg v315: 2800 pgs: 28 creating, 2772 active+clean; 13252 MB data, 85163 MB used, 3740 GB / 3823 GB avail
> 2012-03-28 12:36:42.314124   osd e105: 28 osds: 28 up, 28 in
> 2012-03-28 12:36:43.399792    pg v316: 2800 pgs: 28 creating, 2772 active+clean; 13252 MB data, 85163 MB used, 3740 GB / 3823 GB avail
> 2012-03-28 12:36:43.402742   osd e106: 28 osds: 28 up, 28 in
> 2012-03-28 12:36:46.691598    pg v317: 2800 pgs: 28 creating, 2737 active+clean, 35 active+recovering; 13252 MB data, 84818 MB used, 3740 GB / 3823 GB avail; 274/6765 degraded (4.050%)
> 2012-03-28 12:36:47.596507    pg v318: 2800 pgs: 28 creating, 2709 active+clean, 63 active+recovering; 13252 MB data, 84819 MB used, 3740 GB / 3823 GB avail; 524/6890 degraded (7.605%)

output from: `ceph osd dump | grep pg_num`:

> pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 1 owner 0 crash_replay_interval 45
> pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 1 owner 0
> pool 2 'rbd' rep size 3 crush_ruleset 2 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 105 owner 0


Changing `data` pool replica count:
==================================

output from: `ceph -w`:

> 2012-03-28 13:10:54.818447    pg v573: 2800 pgs: 14 creating, 2786 active+clean; 13252 MB data, 98329 MB used, 3727 GB / 3823 GB avail

(issued: `ceph osd pool set data size 3`)

> 2012-03-28 13:11:08.240605    pg v574: 2828 pgs: 42 creating, 2786 active+clean; 13252 MB data, 98329 MB used, 3727 GB / 3823 GB avail
> 2012-03-28 13:11:08.245026   osd e114: 28 osds: 28 up, 28 in
> 2012-03-28 13:11:09.050371    pg v575: 2828 pgs: 42 creating, 2786 active+clean; 13252 MB data, 98329 MB used, 3727 GB / 3823 GB avail
> 2012-03-28 13:11:09.051179   osd e115: 28 osds: 28 up, 28 in

output from: `ceph osd dump | grep pg_num`:

> pool 0 'data' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 114 owner 0 crash_replay_interval 45
> pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 1 owner 0
> pool 2 'rbd' rep size 3 crush_ruleset 2 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 112 owner 0


Increase metadata pool
======================

output from `ceph -w`:

> 2012-03-28 13:12:04.279557    pg v580: 2828 pgs: 28 creating, 2800 active+clean; 13252 MB data, 98338 MB used, 3727 GB / 3823 GB avail

(issued: `ceph osd pool set metadata size 3`)

> 2012-03-28 13:13:19.748554    pg v581: 2856 pgs: 56 creating, 2800 active+clean; 13252 MB data, 98338 MB used, 3727 GB / 3823 GB avail
> 2012-03-28 13:13:19.753181   osd e116: 28 osds: 28 up, 28 in
> 2012-03-28 13:13:20.840151    pg v582: 2856 pgs: 56 creating, 2800 active+clean; 13252 MB data, 98338 MB used, 3727 GB / 3823 GB avail
> 2012-03-28 13:13:20.842065   osd e117: 28 osds: 28 up, 28 in

output from: `ceph osd dump | grep pg_num`: 

> pool 0 'data' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 114 owner 0 crash_replay_interval 45
> pool 1 'metadata' rep size 3 crush_ruleset 1 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 116 owner 0
> pool 2 'rbd' rep size 3 crush_ruleset 2 object_hash rjenkins pg_num 896 pgp_num 896 lpg_num 2 lpgp_num 2 last_change 112 owner 0


This sounds like it's probably defect.  Should I mint a new bug ticket in the tracker?

Cheers,
David
-- 
David McBride <dwm@doc.ic.ac.uk>
Department of Computing, Imperial College, London

