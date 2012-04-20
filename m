From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: PGs stuck in creating state
Date: Fri, 20 Apr 2012 16:35:11 +0930
Message-ID: <4F910AA7.30206@bashkirtsev.com>
References: <4F90DCBC.4030104@bashkirtsev.com> <Pine.LNX.4.64.1204192207220.7024@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:55139 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab2DTHFb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Apr 2012 03:05:31 -0400
In-Reply-To: <Pine.LNX.4.64.1204192207220.7024@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Sage,

Thank you for quick response. I've seen notes about localized PGs and 
that they do not make sense. However I did not realize that it was what 
I had hit. I will follow your suggestion and wait out for 0.47 - if it 
is not (actually) broken - don't fix it. :)

Regards,
Vladimir

On 20/04/12 14:41, Sage Weil wrote:
> On Fri, 20 Apr 2012, Vladimir Bashkirtsev wrote:
>> Dear devs,
>>
>> First of all I would like to bow my head at your great effort! Even if ceph
>> did not reach prime time status yet it is already extremely powerful and
>> fairly stable to the point we have deployed it in live environment (still
>> backing up of course).
>>
>> I have played with ceph extensively to put it different failed modes and it
>> recovers in most cases without major issues. However when I was adding up OSDs
>> I have got 2 PGs stuck in creating mode and does not matter what I have done
>> (changing CRUSH, restarting OSDs in order to get ceph to move data around)
>> they still there. So instead of using scientific blindfold method I decided to
>> dig deeper. So here we go (please disregard stuck active+remapped as it is
>> part of another problem):
>>
>> [root@gamma tmp]# ceph -s
>> 2012-04-20 12:40:45.294969    pg v625626: 600 pgs: 2 creating, 586
>> active+clean, 12 active+remapped; 253 GB data, 767 GB used, 1292 GB / 2145 GB
>> avail
>> 2012-04-20 12:40:45.299426   mds e457: 1/1/1 up {0=2=up:active}, 2 up:standby
>> 2012-04-20 12:40:45.299549   osd e6022: 6 osds: 6 up, 6 in
>> 2012-04-20 12:40:45.299856   log 2012-04-20 12:26:43.988716 mds.0
>> 172.16.64.202:6802/21363 1 : [DBG] reconnect by client.13897
>> 172.16.64.10:0/1319861516 after 0.101633
>> 2012-04-20 12:40:45.300160   mon e1: 3 mons at
>> {0=172.16.64.200:6789/0,1=172.16.64.201:6789/0,2=172.16.64.202:6789/0}
>>
>> [root@gamma tmp]# ceph pg dump | grep creating
>> 2.1p3   0       0       0       0       0       0       0       creating
>> 0.000000        0'0     0'0     []      []      0'0     0.000000
>> 1.1p3   0       0       0       0       0       0       0       creating
>> 0.000000        0'0     0'0     []      []      0'0     0.000000
> Sigh.. this is exactly the problem I noticed last week that prompted the
> 'localized pgs' email.  I'm working on patches to remove this
> functionality entirely as we speak, since it's a broken design in several
> ways.
>
> Once you restart your osds (be sure to control-c that 'ceph' command
> first), you should be able to wipe out those bad pgs with
>
> 	ceph osd pool disable_lpgs<poolname>  --yes-i-really-mean-it
>
> This is in current master, and will be included in 0.46.
>
> Alternatively, you can just ignore those pgs for the time being.  They
> are completely harmless as long as you can tolerate the ceph -s/ceph
> health noise.  v0.47 should silently zap them all on upgrade.
>
> sage
>
>> My understanding is that p3 means that PG creating on osd.3 . I've tried to
>> stop and restart osd.3 - no banana. So I went to more dramatic option: lose
>> osd.3 . Completely destroyed osd.3 and rebuilt it from scratch. osd.3 came
>> back again with exactly the same PGs in creating mode - makes me think that
>> that osd.3 is not responsible for this.
>>
>> [root@gamma tmp]# ceph osd dump
>> dumped osdmap epoch 6022
>> epoch 6022
>> fsid 7719f573-4c48-4852-a27f-51c7a3fe1c1e
>> created 2012-03-31 04:47:12.130128
>> modifed 2012-04-20 12:26:56.406193
>> flags
>>
>> pool 0 'data' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num 192
>> pgp_num 192 lpg_num 2 lpgp_num 2 last_change 1137 owner 0
>> crash_replay_interval 45
>> pool 1 'metadata' rep size 3 crush_ruleset 1 object_hash rjenkins pg_num 192
>> pgp_num 192 lpg_num 2 lpgp_num 2 last_change 1160 owner 0
>> pool 2 'rbd' rep size 3 crush_ruleset 2 object_hash rjenkins pg_num 192
>> pgp_num 192 lpg_num 2 lpgp_num 2 last_change 1141 owner 0
>>
>> max_osd 6
>> osd.0 up   in  weight 1 up_from 6001 up_thru 6018 down_at 6000
>> last_clean_interval [5980,5996) 172.16.64.200:6804/23046
>> 172.16.64.200:6805/23046 172.16.64.200:6806/23046 exists,up
>> osd.1 up   in  weight 1 up_from 5998 up_thru 6017 down_at 5997
>> last_clean_interval [5992,5996) 172.16.64.201:6804/27598
>> 172.16.64.201:6805/27598 172.16.64.201:6806/27598 exists,up
>> osd.2 up   in  weight 1 up_from 5998 up_thru 6019 down_at 5997
>> last_clean_interval [5978,5996) 172.16.64.202:6804/21457
>> 172.16.64.202:6805/21457 172.16.64.202:6806/21457 exists,up
>> osd.3 up   in  weight 1 up_from 5972 up_thru 6017 down_at 5970
>> last_clean_interval [5884,5969) lost_at 1163 172.16.64.203:6800/10614
>> 172.16.64.203:6801/10614 172.16.64.203:6802/10614 exists,up
>> osd.4 up   in  weight 1 up_from 5995 up_thru 6017 down_at 5988
>> last_clean_interval [5898,5987) 172.16.64.204:6800/16357
>> 172.16.64.204:6801/16357 172.16.64.204:6802/16357 exists,up
>> osd.5 up   in  weight 1 up_from 5984 up_thru 6021 down_at 5982
>> last_clean_interval [5921,5981) 172.16.64.205:6800/11346
>> 172.16.64.205:6801/11346 172.16.64.205:6803/11346 exists,up
>>
>> pg_temp 0.25 [0,1,4]
>> pg_temp 0.33 [0,1,5]
>> pg_temp 0.3e [1,0,4]
>> pg_temp 0.48 [1,0,4]
>> pg_temp 1.24 [0,1,4]
>> pg_temp 1.32 [0,1,5]
>> pg_temp 1.3d [1,0,4]
>> pg_temp 1.47 [1,0,2]
>> pg_temp 2.23 [0,1,4]
>> pg_temp 2.31 [0,1,5]
>> pg_temp 2.3c [1,0,4]
>> pg_temp 2.46 [1,0,4]
>> blacklist 172.16.64.202:6800/19544 expires 2012-04-20 12:45:43.842394
>> blacklist 172.16.64.200:6800/22946 expires 2012-04-20 12:50:17.341910
>> blacklist 172.16.64.201:6803/27504 expires 2012-04-20 12:50:20.102205
>>
>> Then I have attempted to find out what's going on with 2.1p3:
>>
>> [root@delta ceph]# ceph pg 2.1p3 query
>>
>> at this point nothing did happen - it just sits there. At least it seems so
>> but in reality:
>>
>> [root@delta ceph]# ceph -s
>> 2012-04-20 12:49:50.322103    pg v625936: 600 pgs: 2 creating, 4 stale, 400
>> active+degraded, 3 stale+peering, 174 stale+active+degraded, 1
>> down+remapped+peering, 4 active+degraded+remapped, 1 stale+remapped+peering, 3
>> stale+active+replay+degraded, 8 stale+active+degraded+remapped; 253 GB data,
>> 768 GB used, 1292 GB / 2145 GB avail; 138289/230205 degraded (60.072%)
>> 2012-04-20 12:49:50.326769   mds e457: 1/1/1 up {0=2=up:active}, 2 up:standby
>> 2012-04-20 12:49:50.326886   osd e6042: 6 osds: 1 up, 6 in
>> 2012-04-20 12:49:50.327226   log 2012-04-20 12:49:16.732954 mon.0
>> 172.16.64.200:6789/0 35 : [INF] osd.4 172.16.64.204:6800/16357 failed (by
>> osd.5 172.16.64.205:6800/11346)
>> 2012-04-20 12:49:50.327497   mon e1: 3 mons at
>> {0=172.16.64.200:6789/0,1=172.16.64.201:6789/0,2=172.16.64.202:6789/0}
>>
>> So as you can see 5 out of 6 OSDs crashed. Restarting all crashed OSDs
>> manually gets ceph back on the feet without any damage - minute later
>> everything runs as nothing happened and it is good time to see the logs. In
>> particular osd.3 log:
>>
>> 2012-04-20 12:47:38.944653 aadd6b40 --OSD::tracker-- seq: 56, time: 2012-04-20
>> 12:47:38.944641, event: started pg_info(1 pgs e6026) v1
>> 2012-04-20 12:47:38.965044 aadd6b40 --OSD::tracker-- seq: 57, time: 2012-04-20
>> 12:47:38.965017, event: waiting_for_osdmap pg_info(1 pgs e6025) v1
>> 2012-04-20 12:47:38.965098 aadd6b40 --OSD::tracker-- seq: 57, time: 2012-04-20
>> 12:47:38.965086, event: started pg_info(1 pgs e6025) v1
>> 2012-04-20 12:47:38.965179 aadd6b40 --OSD::tracker-- seq: 58, time: 2012-04-20
>> 12:47:38.965165, event: waiting_for_osdmap pg_log(1.8 epoch 6026 query_epoch
>> 6026) v2
>> 2012-04-20 12:47:38.965215 aadd6b40 --OSD::tracker-- seq: 58, time: 2012-04-20
>> 12:47:38.965202, event: started pg_log(1.8 epoch 6026 query_epoch 6026) v2
>> 2012-04-20 12:47:38.965421 aadd6b40 --OSD::tracker-- seq: 59, time: 2012-04-20
>> 12:47:38.965408, event: waiting_for_osdmap pg_info(1 pgs e6026) v1
>> 2012-04-20 12:47:38.965461 aadd6b40 --OSD::tracker-- seq: 59, time: 2012-04-20
>> 12:47:38.965449, event: started pg_info(1 pgs e6026) v1
>> 2012-04-20 12:47:38.990427 ab5d7b40 --OSD::tracker-- seq: 60, time: 2012-04-20
>> 12:47:38.990388, event: waiting_for_osdmap osd_pg_create(pg1.1p3,619;
>> pg2.1p3,1141; ) v2
>> 2012-04-20 12:47:38.990592 aadd6b40 --OSD::tracker-- seq: 61, time: 2012-04-20
>> 12:47:38.990579, event: waiting_for_osdmap pg_info(1 pgs e6026) v1
>> 2012-04-20 12:47:38.994296 aadd6b40 --OSD::tracker-- seq: 61, time: 2012-04-20
>> 12:47:38.993072, event: started pg_info(1 pgs e6026) v1
>> 2012-04-20 12:47:39.077303 ab5d7b40 --OSD::tracker-- seq: 60, time: 2012-04-20
>> 12:47:39.077276, event: started osd_pg_create(pg1.1p3,619; pg2.1p3,1141; ) v2
>> 2012-04-20 12:47:54.546810 ab5d7b40 --OSD::tracker-- seq: 62, time: 2012-04-20
>> 12:47:54.546770, event: waiting_for_osdmap osd_op(client.13891.0:90331
>> rb.0.1.000000000b40 [write 3661824~4096] 2.1f179073) v4
>> osd/OSD.cc: In function 'PG* OSD::_lookup_lock_pg(pg_t)' thread a65cdb40 time
>> 2012-04-20 12:47:54.562370
>> osd/OSD.cc: 1162: FAILED assert(pg_map.count(pgid))
>>   ceph version 0.45 (commit:0aea1cb1df5c3e5ab783ca6f2ed7649823b613c5)
>>   1: /usr/bin/ceph-osd() [0x81f3b04]
>>   2: (OSD::do_command(Connection*, unsigned long long, std::vector<std::string,
>> std::allocator<std::string>  >&, ceph::buffer::list&)+0x1381) [0x8202b21]
>>   3: (OSD::CommandWQ::_process(OSD::Command*)+0x51) [0x823ac71]
>>   4: (ThreadPool::WorkQueue<OSD::Command>::_void_process(void*)+0x18)
>> [0x8224758]
>>   5: (ThreadPool::worker()+0x42d) [0x82f8ddd]
>>   6: (ThreadPool::WorkThread::entry()+0x1f) [0x822559f]
>>   7: (Thread::_entry_func(void*)+0x10) [0x82f3140]
>>   8: (()+0x6cd3) [0x6e0cd3]
>>   9: (clone()+0x5e) [0xa3ca2e]
>>   ceph version 0.45 (commit:0aea1cb1df5c3e5ab783ca6f2ed7649823b613c5)
>>   1: /usr/bin/ceph-osd() [0x81f3b04]
>>   2: (OSD::do_command(Connection*, unsigned long long, std::vector<std::string,
>> std::allocator<std::string>  >&, ceph::buffer::list&)+0x1381) [0x8202b21]
>>   3: (OSD::CommandWQ::_process(OSD::Command*)+0x51) [0x823ac71]
>>   4: (ThreadPool::WorkQueue<OSD::Command>::_void_process(void*)+0x18)
>> [0x8224758]
>>   5: (ThreadPool::worker()+0x42d) [0x82f8ddd]
>>   6: (ThreadPool::WorkThread::entry()+0x1f) [0x822559f]
>>   7: (Thread::_entry_func(void*)+0x10) [0x82f3140]
>>   8: (()+0x6cd3) [0x6e0cd3]
>>   9: (clone()+0x5e) [0xa3ca2e]
>> *** Caught signal (Aborted) **
>>   in thread a65cdb40
>>   ceph version 0.45 (commit:0aea1cb1df5c3e5ab783ca6f2ed7649823b613c5)
>>   1: /usr/bin/ceph-osd() [0x83754db]
>>   2: [0x8c0400]
>>   3: [0x8c0416]
>>   4: (gsignal()+0x4f) [0x97898f]
>>   5: (abort()+0x175) [0x97a2d5]
>>   6: (__gnu_cxx::__verbose_terminate_handler()+0x14d) [0x7a754d]
>>   7: (()+0xb02c4) [0x7a52c4]
>>   8: (()+0xb0300) [0x7a5300]
>>   9: (()+0xb044f) [0x7a544f]
>>   10: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x255) [0x8300715]
>>   11: /usr/bin/ceph-osd() [0x81f3b04]
>>   12: (OSD::do_command(Connection*, unsigned long long,
>> std::vector<std::string, std::allocator<std::string>  >&,
>> ceph::buffer::list&)+0x1381) [0x8202b21]
>>   13: (OSD::CommandWQ::_process(OSD::Command*)+0x51) [0x823ac71]
>>   14: (ThreadPool::WorkQueue<OSD::Command>::_void_process(void*)+0x18)
>> [0x8224758]
>>   15: (ThreadPool::worker()+0x42d) [0x82f8ddd]
>>   16: (ThreadPool::WorkThread::entry()+0x1f) [0x822559f]
>>   17: (Thread::_entry_func(void*)+0x10) [0x82f3140]
>>   18: (()+0x6cd3) [0x6e0cd3]
>>   19: (clone()+0x5e) [0xa3ca2e]
>>
>> So there's couple of things to note:
>> 1. At 2012-04-20 12:47:39.077303 osd started creating PGs in question
>> 2. At 2012-04-20 12:47:54.546810 we got FAILED assert(pg_map.count(pgid))
>>
>> And at this point I guess it is over to you guys as I do not have any idea why
>> this assert fails. If you point me in right direction I would be eternally
>> grateful! :)
>>
>> Regards,
>> Vladimir
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

