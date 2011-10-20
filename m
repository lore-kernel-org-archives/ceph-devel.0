From: Stefan Kleijkers <stefan@unilogicnetworks.net>
Subject: Re: 0.37 crash
Date: Thu, 20 Oct 2011 22:12:41 +0200
Message-ID: <4EA080B9.7080708@unilogicnetworks.net>
References: <4EA040BC.30708@tuxadero.com> <4EA067A4.5090100@unilogicnetworks.net> <4EA06D2A.6040101@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpq1.gn.mail.iss.as9143.net ([212.54.34.164]:57199 "EHLO
	smtpq1.gn.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751436Ab1JTUMs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 20 Oct 2011 16:12:48 -0400
In-Reply-To: <4EA06D2A.6040101@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: ceph-devel@vger.kernel.org

Hello Martin,

I've recreated the fs with mkcephfs and the osd has been rebooted so I 
have no dmesg left from that time. At the moment I'm running a rsync 
workload and I just noticed I have the same problem (see paste below).
In the dmesg I found a couple of btrfs warnings (see below). I've found 
a patch for it, but I haven't applied it yet ( 
http://marc.info/?l=linux-btrfs&m=131547325515336&w=2 
<http://marc.info/?l=linux-btrfs&m=131547325515336&w=2>).
I don't know if the warnings from dmesg have anything to do with the 
error in the osd log. But I don't find any other warnings or errors in 
the dmesg.

Furthermore before the error in the osd log I got a lot of these messages:
2011-10-20 20:58:20.739916 7f5b9e71e700 heartbeat_map is_healthy 
'OSD::op_tp thread 0x7f5b90e02700' had timed out after 30
2011-10-20 20:58:20.739944 7f5b9e71e700 heartbeat_map is_healthy 
'OSD::op_tp thread 0x7f5b91603700' had timed out after 30
2011-10-20 20:58:20.739951 7f5b9e71e700 heartbeat_map is_healthy 
'FileStore::op_tp thread 0x7f5b96f0f700' had timed out after 60
2011-10-20 20:58:20.739956 7f5b9e71e700 heartbeat_map is_healthy 
'FileStore::op_tp thread 0x7f5b97710700' had timed out after 60

At the moment the osd daemon is in Dsl status (with ps) but I don't see 
any io...

I'm going to reboot the OSD and see if it comes back up.

Kind regards,
Stefan

Paste from dmesg:

[24597.271777] ------------[ cut here ]------------
[24597.271794] WARNING: at fs/btrfs/inode.c:2193 
btrfs_orphan_commit_root+0xa8/0xc0 [btrfs]()
[24597.271796] Hardware name: X8ST3
[24597.271797] Modules linked in: btrfs zlib_deflate lzo_compress 
raid456 async_raid6_recov async_pq raid6_pq async_xor xor async_memcpy 
async_tx md_mod target_core_mod configfs ahci libahci e1000e mptsas 
i7core_edac mptscsih mptbase scsi_transport_sas bnx2 i5000_edac 
edac_core ipmi_devintf ipmi_msghandler
[24597.271817] Pid: 6921, comm: ceph-osd Tainted: G        W   
3.1.0-rc10-un13.1-64-nohz #1
[24597.271819] Call Trace:
[24597.271827]  [<ffffffff81036dca>] warn_slowpath_common+0x7a/0xb0
[24597.271830]  [<ffffffff81036e15>] warn_slowpath_null+0x15/0x20
[24597.271840]  [<ffffffffa015f438>] btrfs_orphan_commit_root+0xa8/0xc0 
[btrfs]
[24597.271849]  [<ffffffffa0153c54>] commit_fs_roots+0xc4/0x1b0 [btrfs]
[24597.271856]  [<ffffffffa013a475>] ? btrfs_free_path+0x25/0x30 [btrfs]
[24597.271865]  [<ffffffffa0154c1e>] 
btrfs_commit_transaction+0x3be/0x7e0 [btrfs]
[24597.271874]  [<ffffffffa0153fb3>] ? wait_current_trans+0x23/0x110 [btrfs]
[24597.271878]  [<ffffffff810e41a6>] ? iput+0x46/0x210
[24597.271887]  [<ffffffffa0155120>] ? join_transaction+0x20/0x250 [btrfs]
[24597.271891]  [<ffffffff81052840>] ? wake_up_bit+0x40/0x40
[24597.271897]  [<ffffffffa01334a7>] btrfs_sync_fs+0x47/0x70 [btrfs]
[24597.271900]  [<ffffffff8102d7cb>] ? pick_next_task_fair+0x10b/0x190
[24597.271909]  [<ffffffffa01806b4>] btrfs_ioctl+0x4f4/0xd60 [btrfs]
[24597.271915]  [<ffffffff810ffc95>] ? fsnotify+0x1e5/0x310
[24597.271919]  [<ffffffff810dc77b>] do_vfs_ioctl+0x9b/0x4f0
[24597.271923]  [<ffffffff810dcc1a>] sys_ioctl+0x4a/0x80
[24597.271928]  [<ffffffff813fcc7b>] system_call_fastpath+0x16/0x1b
[24597.271931] ---[ end trace 3c3922c523490bbc ]---

Paste from osd log:

common/HeartbeatMap.cc: In function 'bool 
ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*, 
time_t)', in thread '0x7f5b9e71e700'
common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")
  ceph version 0.37 (commit:a6f3bbb744a6faea95ae48317f0b838edb16a896)
  1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*, 
long)+0x214) [0x65f804]
  2: (ceph::HeartbeatMap::is_healthy()+0x7f) [0x65fb2f]
  3: (ceph::HeartbeatMap::check_touch_file()+0x20) [0x65fd60]
  4: (CephContextServiceThread::entry()+0x5f) [0x5a84bf]
  5: (()+0x69ca) [0x7f5ba019d9ca]
  6: (clone()+0x6d) [0x7f5b9ea1e70d]
  ceph version 0.37 (commit:a6f3bbb744a6faea95ae48317f0b838edb16a896)
  1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*, 
long)+0x214) [0x65f804]
  2: (ceph::HeartbeatMap::is_healthy()+0x7f) [0x65fb2f]
  3: (ceph::HeartbeatMap::check_touch_file()+0x20) [0x65fd60]
  4: (CephContextServiceThread::entry()+0x5f) [0x5a84bf]
  5: (()+0x69ca) [0x7f5ba019d9ca]
  6: (clone()+0x6d) [0x7f5b9ea1e70d]
*** Caught signal (Aborted) **
  in thread 0x7f5b9e71e700
  ceph version 0.37 (commit:a6f3bbb744a6faea95ae48317f0b838edb16a896)
  1: /usr/bin/ceph-osd() [0x660814]
  2: (()+0xf8f0) [0x7f5ba01a68f0]
  3: (gsignal()+0x35) [0x7f5b9e96ba75]
  4: (abort()+0x180) [0x7f5b9e96f5c0]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f5b9f2218e5]
  6: (()+0xcad16) [0x7f5b9f21fd16]
  7: (()+0xcad43) [0x7f5b9f21fd43]
  8: (()+0xcae3e) [0x7f5b9f21fe3e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x39f) [0x5e779f]
  10: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char 
const*, long)+0x214) [0x65f804]
  11: (ceph::HeartbeatMap::is_healthy()+0x7f) [0x65fb2f]
  12: (ceph::HeartbeatMap::check_touch_file()+0x20) [0x65fd60]
  13: (CephContextServiceThread::entry()+0x5f) [0x5a84bf]
  14: (()+0x69ca) [0x7f5ba019d9ca]
  15: (clone()+0x6d) [0x7f5b9ea1e70d]

On 10/20/2011 08:49 PM, Martin Mailand wrote:
> Hi Stefan,
> in my case the osd process was just terminated, no IO wait. Could you 
> have a look in your dmesg, if there is any btrfs entry?
> Because the IO wait sounds like a btrfs problem.
>
> Best Regards,
>  martin
>
> Stefan Kleijkers schrieb:
>> Hello,
>>
>> I got the exact same problem. Upgraded from 0.36 to 0.37 and one of 
>> the two osds wouldn't start. In the log of the osd I also found the 
>> same error as below. The ceph-osd had status D (with ps, which is 
>> uninterruptable sleep) and I see a high IO wait with top. Also I 
>> noticed a lot of disk io on the disks.
>>
>> Stefan
>>
>> On 10/20/2011 05:39 PM, Martin Mailand wrote:
>>> Hi,
>>> today I tried the version 0.37 and it did not work very well, see 
>>> below.
>>> It was an update from 0.36.
>>>
>>> Best Regards,
>>>  Martin
>>>
>>>
>>> 2011-10-20 17:33:34.350502 7f0ada6f4760 ceph version 0.37 
>>> (commit:a6f3bbb744a6faea95ae48317f0b838edb16a896), process ceph-osd, 
>>> pid 21707
>>> 2011-10-20 17:33:34.353543 7f0ada6f4760 filestore(/data/osd2) mount 
>>> FIEMAP ioctl is NOT supported
>>> 2011-10-20 17:33:34.353628 7f0ada6f4760 filestore(/data/osd2) mount 
>>> detected btrfs
>>> 2011-10-20 17:33:34.353656 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs CLONE_RANGE ioctl is supported
>>> 2011-10-20 17:33:34.425059 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs SNAP_CREATE is supported
>>> 2011-10-20 17:33:34.544564 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs SNAP_DESTROY is supported
>>> 2011-10-20 17:33:34.544873 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs START_SYNC got 0 Success
>>> 2011-10-20 17:33:34.544966 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs START_SYNC is supported (transid 149)
>>> 2011-10-20 17:33:34.624965 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs WAIT_SYNC is supported
>>> 2011-10-20 17:33:34.636719 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs SNAP_CREATE_V2 got 0 Success
>>> 2011-10-20 17:33:34.636754 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs SNAP_CREATE_V2 is supported
>>> 2011-10-20 17:33:34.644876 7f0ada6f4760 filestore(/data/osd2) mount 
>>> found snaps <>
>>> 2011-10-20 17:33:34.644983 7f0ada6f4760 filestore(/data/osd2) mount: 
>>> enabling WRITEAHEAD journal mode: 'filestore btrfs snap' mode is not 
>>> enabled
>>> 2011-10-20 17:33:34.678324 7f0ada6f4760 journal  kernel version is 
>>> 3.1.0
>>> 2011-10-20 17:33:34.678737 7f0ada6f4760 journal _open /dev/sda7 fd 
>>> 14: 476500201472 bytes, block size 4096 bytes, directio = 1
>>> 2011-10-20 17:33:34.688215 7f0ada6f4760 journal read_entry 39366656 
>>> : seq 4653 710 bytes
>>> 2011-10-20 17:33:34.688420 7f0ada6f4760 journal read_entry 39374848 
>>> : seq 4654 33 bytes
>>> 2011-10-20 17:33:34.695110 7f0ada6f4760 journal  kernel version is 
>>> 3.1.0
>>> 2011-10-20 17:33:34.695496 7f0ada6f4760 journal _open /dev/sda7 fd 
>>> 14: 476500201472 bytes, block size 4096 bytes, directio = 1
>>> 2011-10-20 17:33:34.696359 7f0ada6f4760 FileStore is up to date.
>>> 2011-10-20 17:33:34.696683 7f0ada6f4760 journal close /dev/sda7
>>> 2011-10-20 17:33:34.697970 7f0ada6f4760 filestore(/data/osd2) mount 
>>> FIEMAP ioctl is NOT supported
>>> 2011-10-20 17:33:34.698013 7f0ada6f4760 filestore(/data/osd2) mount 
>>> detected btrfs
>>> 2011-10-20 17:33:34.698031 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs CLONE_RANGE ioctl is supported
>>> 2011-10-20 17:33:34.774980 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs SNAP_CREATE is supported
>>> 2011-10-20 17:33:34.904538 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs SNAP_DESTROY is supported
>>> 2011-10-20 17:33:34.904945 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs START_SYNC got 0 Success
>>> 2011-10-20 17:33:34.904995 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs START_SYNC is supported (transid 152)
>>> 2011-10-20 17:33:34.991585 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs WAIT_SYNC is supported
>>> 2011-10-20 17:33:34.996636 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs SNAP_CREATE_V2 got 0 Success
>>> 2011-10-20 17:33:34.996664 7f0ada6f4760 filestore(/data/osd2) mount 
>>> btrfs SNAP_CREATE_V2 is supported
>>> 2011-10-20 17:33:35.004813 7f0ada6f4760 filestore(/data/osd2) mount 
>>> found snaps <>
>>> 2011-10-20 17:33:35.004902 7f0ada6f4760 filestore(/data/osd2) mount: 
>>> enabling WRITEAHEAD journal mode: 'filestore btrfs snap' mode is not 
>>> enabled
>>> 2011-10-20 17:33:35.023071 7f0ada6f4760 journal  kernel version is 
>>> 3.1.0
>>> 2011-10-20 17:33:35.023353 7f0ada6f4760 journal _open /dev/sda7 fd 
>>> 14: 476500201472 bytes, block size 4096 bytes, directio = 1
>>> 2011-10-20 17:33:35.029846 7f0ada6f4760 journal read_entry 39366656 
>>> : seq 4653 710 bytes
>>> 2011-10-20 17:33:35.030077 7f0ada6f4760 journal read_entry 39374848 
>>> : seq 4654 33 bytes
>>> 2011-10-20 17:33:35.036728 7f0ada6f4760 journal  kernel version is 
>>> 3.1.0
>>> 2011-10-20 17:33:35.037142 7f0ada6f4760 journal _open /dev/sda7 fd 
>>> 14: 476500201472 bytes, block size 4096 bytes, directio = 1
>>> *** Caught signal (Aborted) **
>>>  in thread 0x7f0ace7f9700
>>>  ceph version 0.37 (commit:a6f3bbb744a6faea95ae48317f0b838edb16a896)
>>>  1: /usr/bin/ceph-osd() [0x5bd012]
>>>  2: (()+0xfc60) [0x7f0ada2d4c60]
>>>  3: (gsignal()+0x35) [0x7f0ad8a5ad05]
>>>  4: (abort()+0x186) [0x7f0ad8a5eab6]
>>>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f0ad93116dd]
>>>  6: (()+0xb9926) [0x7f0ad930f926]
>>>  7: (()+0xb9953) [0x7f0ad930f953]
>>>  8: (()+0xb9a5e) [0x7f0ad930fa5e]
>>>  9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0x129) 
>>> [0x5a7e99]
>>>  10: (OSDMap::decode(ceph::buffer::list&)+0x81) [0x58f9f1]
>>>  11: (OSD::get_map(unsigned int)+0x242) [0x53f6d2]
>>>  12: (OSD::handle_osd_map(MOSDMap*)+0x1f82) [0x56ae72]
>>>  13: (OSD::_dispatch(Message*)+0x36b) [0x56d11b]
>>>  14: (OSD::ms_dispatch(Message*)+0xf6) [0x56e1c6]
>>>  15: (SimpleMessenger::dispatch_entry()+0x88b) [0x5fff2b]
>>>  16: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x4bd55c]
>>>  17: (()+0x6d8c) [0x7f0ada2cbd8c]
>>>  18: (clone()+0x6d) [0x7f0ad8b0d04d]
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe 
>>> ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

