From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: v0.56.2 released
Date: Thu, 31 Jan 2013 12:57:49 +0000
Message-ID: <510A6A4D.40805@inktank.com>
References: <alpine.DEB.2.00.1301301540030.6225@cobra.newdream.net> <510A2085.3080301@profihost.ag> <510A3DEB.4000900@profihost.ag> <alpine.DEB.2.00.1301310415550.11107@cobra.newdream.net> <510A67BF.1060900@profihost.ag> <510A6969.3040606@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:46927 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab3AaM6R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 07:58:17 -0500
Received: by mail-wi0-f170.google.com with SMTP id hm11so530257wib.3
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 04:58:15 -0800 (PST)
In-Reply-To: <510A6969.3040606@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 01/31/2013 12:54 PM, Joao Eduardo Luis wrote:
> On 01/31/2013 12:46 PM, Stefan Priebe - Profihost AG wrote:
>> this does not work:
>>
>> #~ ceph --format=json -s
>>
>>     health HEALTH_OK
>>     monmap e1: 3 mons at
>> {a=10.255.0.100:6789/0,b=10.255.0.101:6789/0,c=10.255.0.102:6789/0},
>> election epoch 2502, quorum 0,1,2 a,b,c
>>     osdmap e14994: 24 osds: 24 up, 24 in
>>      pgmap v4046683: 8128 pgs: 8128 active+clean; 172 GB data, 367 GB
>> used, 4968 GB / 5336 GB avail; 56588B/s wr, 8op/s
>>     mdsmap e1: 0/0/1 up
>>
>> Stefan
>
>
> The patches that would allow this are not on v0.56.2; they're in master
> though.

And I just realized that it would not work with 'ceph -s', but would 
with 'ceph status'; this is due to the way the 'ceph' tool handles 
arguments and the fact that '-s' is a special case.

So if you're trying it on master, try 'ceph status --format=json' 
instead of 'ceph -s --format=json' :)

   -Joao

>>
>> Am 31.01.2013 13:16, schrieb Sage Weil:
>>> On Thu, 31 Jan 2013, Stefan Priebe - Profihost AG wrote:
>>>> Hi,
>>>>
>>>> great to see that we now have op/s and B/s output in ceph -w / ceph -s.
>>>>
>>>> But is it reading or writing or both? Also if there are not ops the ;
>>>> and the rest of the line is missing instead of printing zeros. This
>>>> makes parsing harder.
>>>>
>>>> See:
>>>> 2013-01-31 10:46:42.045874 mon.0 [INF] pgmap v4037097: 8128 pgs: 8128
>>>> active+clean; 172 GB data, 366 GB used, 4970 GB / 5336 GB avail;
>>>> 8086B/s
>>>> wr, 1op/s
>>>>
>>>> 2013-01-31 10:46:43.056919 mon.0 [INF] pgmap v4037098: 8128 pgs: 8128
>>>> active+clean; 172 GB data, 366 GB used, 4970 GB / 5336 GB avail
>>>
>>> This output is meant for a human.  If you need to parse it, we should be
>>> adding a --format=json option for ceph -s and/or -w so that's not
>>> necessary...
>>>
>>> sage
>>>
>>>
>>>>
>>>> Stefan
>>>>
>>>> Am 31.01.2013 08:43, schrieb Stefan Priebe - Profihost AG:
>>>>> Hello,
>>>>>
>>>>> while compiling the bobtail branch i've seen this warning:
>>>>> mon/PGMap.cc: In member function ?void
>>>>> PGMap::apply_incremental(CephContext*, const PGMap::Incremental&)?:
>>>>> mon/PGMap.cc:247: warning: comparison between signed and unsigned
>>>>> integer expressions
>>>>>    CXX    libmon_a-LogMonitor.o
>>>>>
>>>>> Greets,
>>>>> Stefan
>>>>>
>>>>> Am 31.01.2013 00:46, schrieb Sage Weil:
>>>>>> The next bobtail point release is ready, and it's looking pretty
>>>>>> good.
>>>>>> This is an important update for the 0.56.x backport series that
>>>>>> fixes a
>>>>>> number of bugs and several performance issues. All v0.56.x users are
>>>>>> encouraged to upgrade.
>>>>>>
>>>>>> Notable changes since v0.56.1:
>>>>>>
>>>>>>   * osd: snapshot trimming fixes
>>>>>>   * osd: scrub snapshot metadata
>>>>>>   * osd: fix osdmap trimming
>>>>>>   * osd: misc peering fixes
>>>>>>   * osd: stop heartbeating with peers if internal threads are
>>>>>> stuck/hung
>>>>>>   * osd: PG removal is friendlier to other workloads
>>>>>>   * osd: fix recovery start delay (was causing very slow recovery)
>>>>>>   * osd: fix scheduling of explicitly requested scrubs
>>>>>>   * osd: fix scrub interval config options
>>>>>>   * osd: improve recovery vs client io tuning
>>>>>>   * osd: improve 'slow request' warning detail for better diagnosis
>>>>>>   * osd: default CRUSH map now distributes across hosts, not OSDs
>>>>>>   * osd: fix crash on 32-bit hosts triggered by librbd clients
>>>>>>   * librbd: fix error handling when talking to older OSDs
>>>>>>   * mon: fix a few rare crashes
>>>>>>   * ceph command: ability to easily adjust CRUSH tunables
>>>>>>   * radosgw: object copy does not copy source ACLs
>>>>>>   * rados command: fix omap command usage
>>>>>>   * sysvinit script: set ulimit -n properly on remote hosts
>>>>>>   * msgr: fix narrow race with message queuing
>>>>>>   * fixed compilation on some old distros (e.g., RHEL 5.x)
>>>>>>
>>>>>> There are a small number of interface changes related to the
>>>>>> default CRUSH
>>>>>> rule and scrub interval configuration options. Please see the full
>>>>>> release
>>>>>> notes.
>>>>>>
>>>>>> You can get v0.56.2 in the usual fashion:
>>>>>>
>>>>>>   * Git at git://github.com/ceph/ceph.git
>>>>>>   * Tarball at http://ceph.com/download/ceph-0.56.2.tar.gz
>>>>>>   * For Debian/Ubuntu packages, see
>>>>>> http://ceph.com/docs/master/install/debian
>>>>>>   * For RPMs, see http://ceph.com/docs/master/install/rpm
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>> ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

