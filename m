From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: [ceph-users] Unable to start ceph monitor in V0.59
Date: Fri, 22 Mar 2013 01:33:46 +0000
Message-ID: <514BB4FA.6080302@inktank.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC62079F@SHSMSX102.ccr.corp.intel.com> <514AF18C.4010602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:41950 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092Ab3CVBeA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Mar 2013 21:34:00 -0400
Received: by mail-we0-f182.google.com with SMTP id t57so2915402wey.27
        for <ceph-devel@vger.kernel.org>; Thu, 21 Mar 2013 18:33:58 -0700 (PDT)
In-Reply-To: <514AF18C.4010602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "'ceph-users@lists.ceph.com' (ceph-users@lists.ceph.com)" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/21/2013 11:39 AM, Joao Eduardo Luis wrote:
> On 03/21/2013 11:23 AM, Chen, Xiaoxi wrote:
>> Hi List,
>>
>>           I cannot start my monitor when I update my cluster to v0.59,
>> pls note that I am not trying to upgrade,but by reinstall the ceph
>> software stack and rerunning mkcephfs.  I have seen that the monitor
>> change a lot after 0.58, is the mkcephfs still have bugs ?
>
> It's the first time I'm seeing this error, and it appears to be on the
> auth subsystem instead of the monitor, but it can be related to the
> monitor nonetheless.
>
> Any chance you can run the monitor with 'debug mon 20' and 'debug auth
> 20' and point me to the resulting log (assuming this happens all the time)?
>
>    -Joao
>

Following up on this, Xiaoxi was kind enough to provide me with enough 
logs to lead us to a fix.

For future reference, I opened a ticket [1] and the fix that went into 
'next'.

This was caused by a previous patch [2] on the AuthMonitor, and it flew 
under our radar due to not being triggered when using cephx.  This only 
affected a cluster with auth = none.

Thanks to Xiaoxi for putting his time into this!

   -Joao

[1] - http://tracker.ceph.com/issues/4519
[2] - http://tracker.ceph.com/issues/4285

>
>>
>> Below is the log:
>>
>> 2013-03-21 08:17:41.127576 7f71c3610780  0 ceph version 0.59
>> (cbae6a435c62899f857775f66659de052fb0e759), process ceph-mon, pid 1550
>>
>> 2013-03-21 08:17:41.131271 7f71c3610780  1 unable to open monitor store
>> at /data/mon.ceph1
>>
>> 2013-03-21 08:17:41.131281 7f71c3610780  1 check for old monitor store
>> format
>>
>> 2013-03-21 08:17:41.131409 7f71c3610780  1 store(/data/mon.ceph1) mount
>>
>> 2013-03-21 08:17:41.131430 7f71c3610780  1 store(/data/mon.ceph1) mount
>>
>> 2013-03-21 08:17:41.131659 7f71c3610780  1 found old GV monitor store
>> format -- should convert!
>>
>> 2013-03-21 08:17:41.136476 7f71c3610780  1 store(/data/mon.ceph1) mount
>>
>> 2013-03-21 08:17:46.098118 7f71c3610780  1 _convert_paxos first gv 2
>> last gv 475156
>>
>> 2013-03-21 08:17:47.131667 7f71c3610780  0 convert finished conversion
>>
>> 2013-03-21 08:17:47.185261 7f71c3610780  1 mon.ceph1@-1(probing) e1
>> preinit fsid 6d4e68d7-8959-4e8e-90c9-7e43f508f16a
>>
>> 2013-03-21 08:17:47.220874 7f71c3610780  0 mon.ceph1@-1(probing) e1  my
>> rank is now 0 (was -1)
>>
>> 2013-03-21 08:17:47.220905 7f71c3610780  1 mon.ceph1@0(probing) e1
>> win_standalone_election
>>
>> 2013-03-21 08:17:47.221808 7f71c3610780  0 log [INF] : mon.ceph1@0 won
>> leader election with quorum 0
>>
>> 2013-03-21 08:17:47.238542 7f71c3610780  0 log [INF] : pgmap v217425:
>> 10368 pgs: 140 active+clean, 3 stale+active+recovering, 2 stal
>>
>> e, 67 stale+active, 2 active+recovery_wait, 99 stale+active+clean, 819
>> peering, 5 stale+active+degraded+wait_backfill, 3 stale+activ
>>
>> e+recovery_wait, 3760 down+peering, 12 stale+active+recovering+degraded,
>> 305 stale+peering, 3977 stale+down+peering, 1135 stale+acti
>>
>> ve+degraded, 2 stale+active+degraded+backfilling, 4
>> stale+active+degraded+remapped+wait_backfill, 6 incomplete, 1
>> stale+remapped+pee
>>
>> ring, 17 stale+incomplete, 1 stale+active+degraded+remapped, 8
>> active+recovering; 2717 GB data, 2015 GB used, 15441 GB / 17457 GB av
>>
>> ail; 90413/1391836 degraded (6.496%); 250/695918 unfound (0.036%)
>>
>> 2013-03-21 08:17:47.239560 7f71c3610780  0 log [INF] : mdsmap e1:
>> 0/0/1 up
>>
>> 2013-03-21 08:17:47.240448 7f71c3610780  0 log [INF] : osdmap e5056: 80
>> osds: 25 up, 25 in
>>
>> 2013-03-21 08:17:47.241019 7f71c3610780  0 log [INF] : monmap e1: 1 mons
>> at {ceph1=192.168.10.11:6789/0}
>>
>> 2013-03-21 08:17:47.441000 7f71bc1d1700 -1
>> auth/none/AuthNoneServiceHandler.h: In function 'virtual int
>> AuthNoneServiceHandler::hand
>>
>> le_request(ceph::buffer::list::iterator&, ceph::bufferlist&, uint64_t&,
>> AuthCapsInfo&, uint64_t*)' thread 7f71bc1d1700 time 2013-03-
>>
>> 21 08:17:47.440030
>>
>> auth/none/AuthNoneServiceHandler.h: 35: FAILED assert(0)
>>
>> ceph version 0.59 (cbae6a435c62899f857775f66659de052fb0e759)
>>
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>

