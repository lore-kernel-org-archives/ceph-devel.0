From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: [ceph-users] v0.61.5 Cuttlefish update released
Date: Fri, 19 Jul 2013 08:58:59 +0200
Message-ID: <51E8E3B3.8020300@profihost.ag>
References: <alpine.DEB.2.00.1307180944270.7945@cobra.newdream.net> <alpine.DEB.2.00.1307182254010.28090@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:56132 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759383Ab3GSG7N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jul 2013 02:59:13 -0400
In-Reply-To: <alpine.DEB.2.00.1307182254010.28090@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

All mons do not work anymore:

=== mon.a ===
Starting Ceph mon.a on ccad...
[21207]: (33) Numerical argument out of domain
failed: 'ulimit -n 8192;  /usr/bin/ceph-mon -i a --pid-file
/var/run/ceph/mon.a.pid -c /etc/ceph/ceph.conf '

Stefan

Am 19.07.2013 07:59, schrieb Sage Weil:
> A note on upgrading:
> 
> One of the fixes in 0.61.5 is with a 32bit vs 64bit bug with the feature 
> bits.  We did not realize it before, but the fix will prevent 0.61.4 (or 
> earlier) from forming a quorum with 0.61.5. This is similar to the upgrade 
> from bobtail (and the future upgrade to dumpling). As such, we recommend 
> you upgrade all monitors at once to avoid the potential for discruption in 
> service.
> 
> I'm adding a note to the release notes.
> 
> Thanks!
> sage
> 
> 
> On Thu, 18 Jul 2013, Sage Weil wrote:
> 
>> We've prepared another update for the Cuttlefish v0.61.x series. This 
>> release primarily contains monitor stability improvements, although there 
>> are also some important fixes for ceph-osd for large clusters and a few 
>> important CephFS fixes. We recommend that all v0.61.x users upgrade.
>>
>>  * mon: misc sync improvements (faster, more reliable, better tuning)
>>  * mon: enable leveldb cache by default (big performance improvement)
>>  * mon: new scrub feature (primarily for diagnostic, testing purposes)
>>  * mon: fix occasional leveldb assertion on startup
>>  * mon: prevent reads until initial state is committed
>>  * mon: improved logic for trimming old osdmaps
>>  * mon: fix pick_addresses bug when expanding mon cluster
>>  * mon: several small paxos fixes, improvements
>>  * mon: fix bug osdmap trim behavior
>>  * osd: fix several bugs with PG stat reporting
>>  * osd: limit number of maps shared with peers (which could cause domino failures)
>>  * rgw: fix radosgw-admin buckets list (for all buckets)
>>  * mds: fix occasional client failure to reconnect
>>  * mds: fix bad list traversal after unlink
>>  * mds: fix underwater dentry cleanup (occasional crash after mds restart)
>>  * libcephfs, ceph-fuse: fix occasional hangs on umount
>>  * libcephfs, ceph-fuse: fix old bug with O_LAZY vs O_NOATIME confusion
>>  * ceph-disk: more robust journal device detection on RHEL/CentOS
>>  * ceph-disk: better, simpler locking
>>  * ceph-disk: do not inadvertantely mount over existing osd mounts
>>  * ceph-disk: better handling for unusual device names
>>  * sysvinit, upstart: handle symlinks in /var/lib/ceph/*
>>
>> Please also refer to the complete release notes:
>>
>>    http://ceph.com/docs/master/release-notes/#v0-61-5-cuttlefish
>>
>> You can get v0.61.5 from the usual locations:
>>
>>  * Git at git://github.com/ceph/ceph.git
>>  * Tarball at http://ceph.com/download/ceph-0.61.5.tar.gz
>>  * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
>>  * For RPMs, see http://ceph.com/docs/master/install/rpm
>>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
