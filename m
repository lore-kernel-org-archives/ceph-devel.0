From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: [ceph-users] Ceph cluster is unreachable because of authentication
 failure
Date: Wed, 22 Jan 2014 13:14:33 +0000
Message-ID: <52DFC439.5080506@inktank.com>
References: <BLU0-SMTP1356EEDE6A8ACF94947F22ADFBF0@phx.gbl>	<alpine.DEB.2.00.1401140654500.10628@cobra.newdream.net>	<016D7F31-523E-4EC1-8222-7D4084BA400F@outlook.com>	<BLU0-SMTP14487458FBE42B33537BD4EDFB90@phx.gbl>	<alpine.DEB.2.00.1401160908170.3044@cobra.newdream.net>	<BLU0-SMTP169D80D759610D226681DD3DFB80@phx.gbl>	<alpine.DEB.2.00.1401170804180.304@cobra.newdream.net>	<BLU0-SMTP65962E190D657BC79CFBB2DFBA0@phx.gbl>	<alpine.DEB.2.00.1401200835050.2149@cobra.newdream.net> <BLU0-SMTP45470BC6BBFC330988AD1B9DFA70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:50577 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755543AbaAVNOe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jan 2014 08:14:34 -0500
Received: by mail-wg0-f54.google.com with SMTP id x13so309364wgg.9
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jan 2014 05:14:33 -0800 (PST)
In-Reply-To: <BLU0-SMTP45470BC6BBFC330988AD1B9DFA70@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang <yguang11@outlook.com>, Sage Weil <sage@inktank.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 01/22/2014 11:34 AM, Guang wrote:
> Thanks Sage.
>
> If we use the debug_mon and debug_paxos as 20, the log file is growing too fast, I set the log level as 10 and then: 1) run the 'ceph osd set noin' command, 2) grep the log with keyword 'noin', attached is the monitor log. Please help to check. Thanks very much!
>
>


The log doesn't show the relevant part due to only containing log 
messages mentioning the 'noin' keyword.

We need the portion of the log between a line containing

'(leader).*handle_command mon_command({"prefix": "osd set", "key": 
"noin"}.*'

and the first line (after that) containing 'won leader election'.

Otherwise we are missing what is causing the election to be triggered.

   -Joao

>
>
> Thanks,
> Guang
>
> On Jan 21, 2014, at 12:35 AM, Sage Weil <sage@inktank.com> wrote:
>
>> On Sun, 19 Jan 2014, Guang wrote:
>>> Thanks Sage.
>>>
>>> I just captured part of the log (it was fast growing), the process did
>>> not hang but I saw the same pattern repeatedly. Should I increase the
>>> log level and send over email (it constantly reproduced)?
>>
>> Sure!  A representative fragment of the repeating fragment shoudl be
>> enough.
>>
>> s
>>>
>>> Thanks,
>>> Guang
>>>
>>> On Jan 18, 2014, at 12:05 AM, Sage Weil <sage@inktank.com> wrote:
>>>
>>>> On Fri, 17 Jan 2014, Guang wrote:
>>>>> Thanks Sage.
>>>>>
>>>>> I further narrow down the problem to #any command using paxos service would hang#, following are details:
>>>>>
>>>>> 1. I am able to run ceph status / osd dump, etc., however, the result are out of date (though I stopped all OSDs, it does not reflect in ceph status report).
>>>>>
>>>>> -bash-4.1$ sudo ceph -s
>>>>> cluster b9cb3ea9-e1de-48b4-9e86-6921e2c537d2
>>>>>   health HEALTH_WARN 2797 pgs degraded; 107 pgs down; 7503 pgs peering; 917 pgs recovering; 6079 pgs recovery_wait; 2957 pgs stale; 7771 pgs stuck inactive; 2957 pgs stuck stale; 16567 pgs stuck unclean; recovery 54346804/779462977 degraded (6.972%); 9/259724199 unfound (0.000%); 2 near full osd(s); 57/751 in osds are down; noout,nobackfill,norecover,noscrub,nodeep-scrub flag(s) set
>>>>>   monmap e1: 3 mons at {osd151=10.194.0.68:6789/0,osd152=10.193.207.130:6789/0,osd153=10.193.207.131:6789/0}, election epoch 123278, quorum 0,1,2 osd151,osd152,osd153
>>>>>   osdmap e134893: 781 osds: 694 up, 751 in
>>>>>    pgmap v2388518: 22203 pgs: 26 inactive, 14 active, 79 stale+active+recovering, 5020 active+clean, 242 stale, 4352 active+recovery_wait, 616 stale+active+clean, 177 active+recovering+degraded, 6714 peering, 925 stale+active+recovery_wait, 86 down+peering, 1547 active+degraded, 32 stale+active+recovering+degraded, 648 stale+peering, 21 stale+down+peering, 239 stale+active+degraded, 651 active+recovery_wait+degraded, 30 remapped+peering, 151 stale+active+recovery_wait+degraded, 4 stale+remapped+peering, 629 active+recovering; 79656 GB data, 363 TB used, 697 TB / 1061 TB avail; 54346804/779462977 degraded (6.972%); 9/259724199 unfound (0.000%)
>>>>>   mdsmap e1: 0/0/1 up
>>>>>
>>>>> 2. If I run a command which uses paxos, the command will hang forever, this includes, ceph osd set noup (and also including those commands osd send to monitor when being started (create-or-add)).
>>>>>
>>>>> I attached the corresponding monitor log (it is like a bug).
>>>>
>>>> I see the osd set command coming through, but it arrives while paxos is
>>>> converging and the log seems to end before the mon would normally process
>>>> te delayed messages.  Is there a reason why the log fragment you attached
>>>> ends there, or did the process hang or something?
>>>>
>>>> Thanks-
>>>> sage
>>>>
>>>>> I
>>>>>
>>>>> On Jan 17, 2014, at 1:35 AM, Sage Weil <sage@inktank.com> wrote:
>>>>>
>>>>>> Hi Guang,
>>>>>>
>>>>>> On Thu, 16 Jan 2014, Guang wrote:
>>>>>>> I still have bad the luck to figure out what is the problem making authentication failure, so in order to get the cluster back, I tried:
>>>>>>> 1. stop all daemons (mon & osd)
>>>>>>> 2. change the configuration to disable cephx
>>>>>>> 3. start mon daemons (3 in total)
>>>>>>> 4. start osd daemon one by one
>>>>>>>
>>>>>>> After finishing step 3, the cluster can be reachable ('ceph -s' give results):
>>>>>>> -bash-4.1$ sudo ceph -s
>>>>>>> cluster b9cb3ea9-e1de-48b4-9e86-6921e2c537d2
>>>>>>> health HEALTH_WARN 2797 pgs degraded; 107 pgs down; 7503 pgs peering; 917 pgs recovering; 6079 pgs recovery_wait; 2957 pgs stale; 7771 pgs stuck inactive; 2957 pgs stuck stale; 16567 pgs stuck unclean; recovery 54346804/779462977 degraded (6.972%); 9/259724199 unfound (0.000%); 2 near full osd(s); 57/751 in osds are down; noout,nobackfill,norecover,noscrub,nodeep-scrub flag(s) set
>>>>>>> monmap e1: 3 mons at {osd151=10.194.0.68:6789/0,osd152=10.193.207.130:6789/0,osd153=10.193.207.131:6789/0}, election epoch 106022, quorum 0,1,2 osd151,osd152,osd153
>>>>>>> osdmap e134893: 781 osds: 694 up, 751 in
>>>>>>>   pgmap v2388518: 22203 pgs: 26 inactive, 14 active, 79 stale+active+recovering, 5020 active+clean, 242 stale, 4352 active+recovery_wait, 616 stale+active+clean, 177 active+recovering+degraded, 6714 peering, 925 stale+active+recovery_wait, 86 down+peering, 1547 active+degraded, 32 stale+active+recovering+degraded, 648 stale+peering, 21 stale+down+peering, 239 stale+active+degraded, 651 active+recovery_wait+degraded, 30 remapped+peering, 151 stale+active+recovery_wait+degraded, 4 stale+remapped+peering, 629 active+recovering; 79656 GB data, 363 TB used, 697 TB / 1061 TB avail; 54346804/779462977 degraded (6.972%); 9/259724199 unfound (0.000%)
>>>>>>> mdsmap e1: 0/0/1 up
>>>>>>> (at this point, all OSDs should be down).
>>>>>>>
>>>>>>> When I tried to start OSD daemon, the starting script got hang, and the process hang is:
>>>>>>> root      80497  80496  0 08:18 pts/0    00:00:00 python /usr/bin/ceph --name=osd.22 --keyring=/var/lib/ceph/osd/ceph-22/keyring osd crush create-or-move -- 22 0.40 root=default host=osd173
>>>>>>>
>>>>>>> When I strace the starting script, I got the following traces (process 75873 is the above process), it failed with futex and then do a infinite loop:
>>>>>>> select(0, NULL, NULL, NULL, {0, 16000}) = 0 (Timeout)
>>>>>>> Any idea what might trigger this?
>>>>>>
>>>>>> It is hard to tell from the strace what is going on from this.  Do you see
>>>>>> that the OSDs are booting in ceph.log (or ceph -w output)?  If not, I
>>>>>> would look at the osd daemon log for clues.  You may need to turn up
>>>>>> debugging to see (ceph daemon osd.NNN config set debug_osd 20 to adjust
>>>>>> the level on the running daemon).
>>>>>>
>>>>>> If they are booting, it is mostly a matter of letting it recover and come
>>>>>> up.  We have seen patterns where configuration or network issues have let
>>>>>> the system bury itself under a series of osdmap updates.  If you see that
>>>>>> in the log when you turn up debugging, or see the osds going up and down
>>>>>> when you try to bring the cluster up, that could be what is going on.  A
>>>>>> strategy that has worked there is to let all the osds catch up on their
>>>>>> maps before trying to peer and join the cluster.  To do that, 'ceph osd
>>>>>> set noup' (which prevents the osds from joining), wait for the ceph-osd
>>>>>> processes to stop chewing on maps (watch the cpu utilization in top), and
>>>>>> once they are all ready 'ceph osd unset noup' and let them join and peer
>>>>>> all at once.
>>>>>>
>>>>>> sage
>>>>>>
>>>>>>>
>>>>>>> ======= STRACE (PARTIAL) ==========
>>>>>>> [pid 75873] futex(0xf707a0, FUTEX_WAIT_PRIVATE, 0, NULL <unfinished ...>
>>>>>>> [pid 75878] mmap(NULL, 134217728, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = 0x7f5da6529000
>>>>>>> [pid 75878] munmap(0x7f5da6529000, 28143616) = 0
>>>>>>> [pid 75878] munmap(0x7f5dac000000, 38965248) = 0
>>>>>>> [pid 75878] mprotect(0x7f5da8000000, 135168, PROT_READ|PROT_WRITE) = 0
>>>>>>> [pid 75878] futex(0xf707a0, FUTEX_WAKE_PRIVATE, 1) = 1
>>>>>>> [pid 75873] <... futex resumed> )       = 0
>>>>>>> [pid 75873] futex(0xdd3cb0, FUTEX_WAIT_PRIVATE, 0, NULL <unfinished ...>
>>>>>>> [pid 75878] futex(0xdd3cb0, FUTEX_WAKE_PRIVATE, 1 <unfinished ...>
>>>>>>> [pid 75873] <... futex resumed> )       = -1 EAGAIN (Resource temporarily unavailable)
>>>>>>> [pid 75878] <... futex resumed> )       = 0
>>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 1000} <unfinished ...>
>>>>>>> [pid 75878] rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [], 8) = 0
>>>>>>> [pid 75878] mmap(NULL, 10489856, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) = 0x7f5dadb28000
>>>>>>> [pid 75878] mprotect(0x7f5dadb28000, 4096, PROT_NONE) = 0
>>>>>>> [ omit some entries?]
>>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 16000}) = 0 (Timeout)
>>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 32000}) = 0 (Timeout)
>>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) = 0 (Timeout)
>>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) = 0 (Timeout)
>>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) = 0 (Timeout)
>>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) = 0 (Timeout)
>>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) = 0 (Timeout)
>>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Guang
>>>>>>>
>>>>>>> On Jan 15, 2014, at 5:54 AM, Guang <yguang11@outlook.com> wrote:
>>>>>>>
>>>>>>>> Thanks Sage.
>>>>>>>>
>>>>>>>> -bash-4.1$ sudo ceph --admin-daemon /var/run/ceph/ceph-mon.osd151.asok mon_status
>>>>>>>> { "name": "osd151",
>>>>>>>> "rank": 2,
>>>>>>>> "state": "electing",
>>>>>>>> "election_epoch": 85469,
>>>>>>>> "quorum": [],
>>>>>>>> "outside_quorum": [],
>>>>>>>> "extra_probe_peers": [],
>>>>>>>> "sync_provider": [],
>>>>>>>> "monmap": { "epoch": 1,
>>>>>>>>    "fsid": "b9cb3ea9-e1de-48b4-9e86-6921e2c537d2",
>>>>>>>>    "modified": "0.000000",
>>>>>>>>    "created": "0.000000",
>>>>>>>>    "mons": [
>>>>>>>>          { "rank": 0,
>>>>>>>>            "name": "osd152",
>>>>>>>>            "addr": "10.193.207.130:6789\/0"},
>>>>>>>>          { "rank": 1,
>>>>>>>>            "name": "osd153",
>>>>>>>>            "addr": "10.193.207.131:6789\/0"},
>>>>>>>>          { "rank": 2,
>>>>>>>>            "name": "osd151",
>>>>>>>>            "addr": "10.194.0.68:6789\/0"}]}}
>>>>>>>>
>>>>>>>> And:
>>>>>>>>
>>>>>>>> -bash-4.1$ sudo ceph --admin-daemon /var/run/ceph/ceph-mon.osd151.asok quorum_status
>>>>>>>> { "election_epoch": 85480,
>>>>>>>> "quorum": [
>>>>>>>>      0,
>>>>>>>>      1,
>>>>>>>>      2],
>>>>>>>> "quorum_names": [
>>>>>>>>      "osd151",
>>>>>>>>      "osd152",
>>>>>>>>      "osd153"],
>>>>>>>> "quorum_leader_name": "osd152",
>>>>>>>> "monmap": { "epoch": 1,
>>>>>>>>    "fsid": "b9cb3ea9-e1de-48b4-9e86-6921e2c537d2",
>>>>>>>>    "modified": "0.000000",
>>>>>>>>    "created": "0.000000",
>>>>>>>>    "mons": [
>>>>>>>>          { "rank": 0,
>>>>>>>>            "name": "osd152",
>>>>>>>>            "addr": "10.193.207.130:6789\/0"},
>>>>>>>>          { "rank": 1,
>>>>>>>>            "name": "osd153",
>>>>>>>>            "addr": "10.193.207.131:6789\/0"},
>>>>>>>>          { "rank": 2,
>>>>>>>>            "name": "osd151",
>>>>>>>>            "addr": "10.194.0.68:6789\/0"}]}}
>>>>>>>>
>>>>>>>>
>>>>>>>> The election has been finished with leader selected from the above status.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Guang
>>>>>>>>
>>>>>>>> On Jan 14, 2014, at 10:55 PM, Sage Weil <sage@inktank.com> wrote:
>>>>>>>>
>>>>>>>>> On Tue, 14 Jan 2014, GuangYang wrote:
>>>>>>>>>> Hi ceph-users and ceph-devel,
>>>>>>>>>> I came across an issue after restarting monitors of the cluster, that authentication fails which prevents running any ceph command.
>>>>>>>>>>
>>>>>>>>>> After we did some maintenance work, I restart OSD, however, I found that the OSD would not join the cluster automatically after being restarted, though TCP dump showed it had already sent messenger to monitor telling add me into the cluster.
>>>>>>>>>>
>>>>>>>>>> So that I suspected there might be some issues of monitor and I restarted monitor one by one (3 in total), however, after restarting monitors, all ceph command would fail saying authentication timeout?
>>>>>>>>>>
>>>>>>>>>> 2014-01-14 12:00:30.499397 7fc7f195e700  0 monclient(hunting): authenticate timed out after 300
>>>>>>>>>> 2014-01-14 12:00:30.499440 7fc7f195e700  0 librados: client.admin authentication error (110) Connection timed out
>>>>>>>>>> Error connecting to cluster: Error
>>>>>>>>>>
>>>>>>>>>> Any idea why such error happened (restarting OSD would result in the same error)?
>>>>>>>>>>
>>>>>>>>>> I am thinking the authentication information is persisted in mon local disk and is there a chance those data got corrupted?
>>>>>>>>>
>>>>>>>>> That sounds unlikely, but you're right that the core problem is with the
>>>>>>>>> mons.  What does
>>>>>>>>>
>>>>>>>>> ceph daemon mon.`hostname` mon_status
>>>>>>>>>
>>>>>>>>> say?  Perhaps they are not forming a quorum and that is what is preventing
>>>>>>>>> authentication.
>>>>>>>>>
>>>>>>>>> sage
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
