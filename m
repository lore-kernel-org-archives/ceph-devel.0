From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: v0.56.2 released
Date: Thu, 31 Jan 2013 10:48:27 +0100
Message-ID: <510A3DEB.4000900@profihost.ag>
References: <alpine.DEB.2.00.1301301540030.6225@cobra.newdream.net> <510A2085.3080301@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:47888 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab3AaJsh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 04:48:37 -0500
In-Reply-To: <510A2085.3080301@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

great to see that we now have op/s and B/s output in ceph -w / ceph -s.

But is it reading or writing or both? Also if there are not ops the ;
and the rest of the line is missing instead of printing zeros. This
makes parsing harder.

See:
2013-01-31 10:46:42.045874 mon.0 [INF] pgmap v4037097: 8128 pgs: 8128
active+clean; 172 GB data, 366 GB used, 4970 GB / 5336 GB avail; 8086B/=
s
wr, 1op/s

2013-01-31 10:46:43.056919 mon.0 [INF] pgmap v4037098: 8128 pgs: 8128
active+clean; 172 GB data, 366 GB used, 4970 GB / 5336 GB avail

Stefan

Am 31.01.2013 08:43, schrieb Stefan Priebe - Profihost AG:
> Hello,
>=20
> while compiling the bobtail branch i've seen this warning:
> mon/PGMap.cc: In member function =91void
> PGMap::apply_incremental(CephContext*, const PGMap::Incremental&)=92:
> mon/PGMap.cc:247: warning: comparison between signed and unsigned
> integer expressions
>   CXX    libmon_a-LogMonitor.o
>=20
> Greets,
> Stefan
>=20
> Am 31.01.2013 00:46, schrieb Sage Weil:
>> The next bobtail point release is ready, and it's looking pretty goo=
d.=20
>> This is an important update for the 0.56.x backport series that fixe=
s a=20
>> number of bugs and several performance issues. All v0.56.x users are=
=20
>> encouraged to upgrade.=20
>>
>> Notable changes since v0.56.1:
>>
>>  * osd: snapshot trimming fixes
>>  * osd: scrub snapshot metadata
>>  * osd: fix osdmap trimming
>>  * osd: misc peering fixes
>>  * osd: stop heartbeating with peers if internal threads are stuck/h=
ung
>>  * osd: PG removal is friendlier to other workloads
>>  * osd: fix recovery start delay (was causing very slow recovery)
>>  * osd: fix scheduling of explicitly requested scrubs
>>  * osd: fix scrub interval config options
>>  * osd: improve recovery vs client io tuning
>>  * osd: improve 'slow request' warning detail for better diagnosis
>>  * osd: default CRUSH map now distributes across hosts, not OSDs
>>  * osd: fix crash on 32-bit hosts triggered by librbd clients
>>  * librbd: fix error handling when talking to older OSDs
>>  * mon: fix a few rare crashes
>>  * ceph command: ability to easily adjust CRUSH tunables
>>  * radosgw: object copy does not copy source ACLs
>>  * rados command: fix omap command usage
>>  * sysvinit script: set ulimit -n properly on remote hosts
>>  * msgr: fix narrow race with message queuing
>>  * fixed compilation on some old distros (e.g., RHEL 5.x)
>>
>> There are a small number of interface changes related to the default=
 CRUSH=20
>> rule and scrub interval configuration options. Please see the full r=
elease=20
>> notes.
>>
>> You can get v0.56.2 in the usual fashion:
>>
>>  * Git at git://github.com/ceph/ceph.git
>>  * Tarball at http://ceph.com/download/ceph-0.56.2.tar.gz
>>  * For Debian/Ubuntu packages, see http://ceph.com/docs/master/insta=
ll/debian
>>  * For RPMs, see http://ceph.com/docs/master/install/rpm
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
