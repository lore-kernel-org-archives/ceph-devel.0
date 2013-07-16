From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: cephfs <fs> set_layout --pool_meta <SSD> --pool_data <SAS>
Date: Tue, 16 Jul 2013 13:58:50 +0200
Message-ID: <20130716115850.GA24975@oder.mch.fsc.net>
References: <20130716115448.GA23760@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:10214 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab3GPL66 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jul 2013 07:58:58 -0400
Content-Disposition: inline
In-Reply-To: <20130716115448.GA23760@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Kasper Dieter <Dieter.Kasper@ts.fujitsu.com>

BTW is there are a solution to put Cephfs metadata on a pool 'SSD-group' and Cephfs data on a 2nd pool 'SAS-group' ?

Regards,
Dieter Kasper


On Tue, Jul 16, 2013 at 01:54:48PM +0200, Kasper Dieter wrote:
> I followed the description
> http://www.sebastien-han.fr/blog/2013/02/11/mount-a-specific-pool-with-cephfs/
> ... to change the pool assigned to cephfs:
> 
> # ceph osd dump | grep rule
> pool 0 'data' rep size 2 min_size 1 crush_ruleset 0 object_hash rjenkins pg_num 10304 pgp_num 10304 last_change 1 owner 0 crash_replay_interval 45
> pool 1 'metadata' rep size 2 min_size 1 crush_ruleset 1 object_hash rjenkins pg_num 10304 pgp_num 10304 last_change 1 owner 0
> pool 2 'rbd' rep size 2 min_size 1 crush_ruleset 2 object_hash rjenkins pg_num 10304 pgp_num 10304 last_change 1 owner 0
> pool 3 'SSD-group-2' rep size 2 min_size 1 crush_ruleset 3 object_hash rjenkins pg_num 3300 pgp_num 3300 last_change 299 owner 0
> pool 4 'SSD-group-3' rep size 3 min_size 1 crush_ruleset 3 object_hash rjenkins pg_num 3300 pgp_num 3300 last_change 302 owner 0
> pool 5 'SAS-group-2' rep size 2 min_size 1 crush_ruleset 4 object_hash rjenkins pg_num 3300 pgp_num 3300 last_change 306 owner 0
> pool 6 'SAS-group-3' rep size 3 min_size 1 crush_ruleset 4 object_hash rjenkins pg_num 3300 pgp_num 3300 last_change 309 owner 0
> 
> # cephfs /mnt/cephfs/ show_layout
> layout.data_pool:     0
> layout.object_size:   4194304
> layout.stripe_unit:   4194304
> layout.stripe_count:  1
> 
> # mount | grep ceph
> 10.10.38.13:/ on /mnt/cephfs type ceph (name=admin,key=client.admin)
> 
> # cephfs /mnt/cephfs/ set_layout -p 3 -u 4194304 -c 1 -s 4194304
> Error setting layout: Invalid argument
> 
> 
> Is this a bug in the current release ?
> # ceph -v
> ceph version 0.61.4 (1669132fcfc27d0c0b5e5bb93ade59d147e23404)
> 
> How can this issue be solved ?
> 
> 
> Kind Regards,
> Dieter Kasper
