From: Jianjian Huo <samuel.huo@gmail.com>
Subject: Re: Ceph space amplification ratio with write is more than 2
Date: Wed, 9 Mar 2016 16:29:27 -0800
Message-ID: <CAB=cV2TbsVQJWYeWRLwBmmFA+Hcpj1E2a=4ft7uiRt5Ma8O__Q@mail.gmail.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C0561C4194@SSIEXCH-MB3.ssi.samsung.com>
 <CACJqLya3_A4U=dZhDu8kxJaz6N96exjY4-qtVFhDNnXzSZORhA@mail.gmail.com>
 <BN1PR02MB0555C4954C611D023E86732F4B80@BN1PR02MB055.namprd02.prod.outlook.com>
 <CACJqLyY_B=gzUxiNr9EOXFWez65qhXymS4U=+bDt6fh8rzi49A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33896 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934458AbcCJA3r convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 19:29:47 -0500
Received: by mail-ig0-f173.google.com with SMTP id av4so5935198igc.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2016 16:29:47 -0800 (PST)
In-Reply-To: <CACJqLyY_B=gzUxiNr9EOXFWez65qhXymS4U=+bDt6fh8rzi49A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Just saw this thread...

If we are talking about application write amp, I observed different
WAF values for different Ceph workloads. For object workloads(rados
bench writes an empty drive to full), 4MB object writes have about 2X
write amp, ceph journal writes just a little bit more than data; 4KB
object writes have more than 10X write amp; for block
workloads(fio_rbd), 4KB block writes have about 5~6X write
amp(includes ceph journal, data files, leveldb, xfs journal, xfs
inodes, ...), depends on ceph and xfs configs.

For space amp, block workload is close to 1.

This is based on Hammer, 480GB SSD, single OSD, data and 5G journal on
the same drive, 400G rbd image.

On Fri, Feb 26, 2016 at 9:50 PM, Haomai Wang <haomai@xsky.com> wrote:
> On Sat, Feb 27, 2016 at 9:58 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>> Haomai,
>> I think what James is seeing excluding  journal write it is > 2X write amp. Must be something fishy on his setup..
>
> Oh, thanks for reminder. Hmm, I double checked the current
> FileJournal, it should be aligned with 4k... So it could be possible
> too......
>
>>
>> Thanks & Regards
>> Somnath
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wang
>> Sent: Friday, February 26, 2016 5:27 PM
>> To: James (Fei) Liu-SSI
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: Ceph space amplification ratio with write is more than 2
>>
>> It should be as expected. The reason is FileJournal will prepend header and append footer to the transaction data, and if using
>> aio+dio, we need to align these. So normally for 4k io, it will become
>> 5-6k filejournal write IIRC. Plus filestore writeback to filesystem, it should be 2.5x. But local file system and disk should has some merge tricky, it should be less than 2.5x.
>>
>> On Sat, Feb 27, 2016 at 1:46 AM, James (Fei) Liu-SSI <james.liu@ssi.samsung.com> wrote:
>>> Hi Cepher,
>>>    We recently have tested the Ceph space amplification with filestore
>>> through  writing data to ramdisk with rados bench. However, we found
>>> only
>>> 3584 MB was written from rados bench  but totally 8658M(1G of total 9G of ramdisk was used for journal) was used in the ramdisk.
>>>
>>> The totally space amplification is 7658/3584 = 2.14. (It is surprising
>>> huge factor) 1. Cluster configuration:
>>> . One OSD and one MON  are in the same machine with rados bench. Replication factor  was set as 1.
>>> . ceph version from ceph master
>>> 5979c8e34fa2f3d7efa28c29fb90758b3f9f818
>>> (45979c8e34fa2f3d7efa28c29fb90758b3f9f818)
>>> 2. Rados command we have been used :
>>> rados bench -p rbd -b 4096 --max-objects 1048576  300 write
>>> --no-cleanup 3. ceph cluster configuration:
>>> Please see appendix 1.
>>> 4. Results investigation.
>>> Please see appendix 0.
>>>
>>> Could anyone help to explain why  the space amplification with filestore is huge?  Thanks a lot.
>>>
>>> Regards,
>>> James
>>>
>>> Appendix 0:
>>>
>>> ssd@OptiPlex-9020-1:~/src/bluestore$ ceph df
>>> GLOBAL:
>>>     SIZE      AVAIL     RAW USED     %RAW USED
>>>     9206M      547M        8658M         94.05
>>> POOLS:
>>>     NAME     ID     USED      %USED     MAX AVAIL     OBJECTS
>>>     rbd      0      3584M     38.93          547M      917505
>>> ssd@OptiPlex-9020-1:~/src/bluestore$ ceph -s
>>>     cluster a7f64266-0894-4f1e-a635-d0aeaca0e993
>>>      health HEALTH_WARN
>>>             1 near full osd(s)
>>>      monmap e1: 1 mons at {localhost=127.0.0.1:6789/0}
>>>             election epoch 3, quorum 0 localhost
>>>      osdmap e7: 1 osds: 1 up, 1 in
>>>             flags sortbitwise
>>>       pgmap v31: 64 pgs, 1 pools, 3584 MB data, 896 kobjects
>>>             8658 MB used, 547 MB / 9206 MB avail
>>>                   64 active+clean
>>> ssd@OptiPlex-9020-1:~/src/bluestore$ df -h
>>> Filesystem      Size  Used Avail Use% Mounted on
>>> /dev/sda2       2.7T  1.4T  1.2T  55% /
>>> none            4.0K     0  4.0K   0% /sys/fs/cgroup
>>> udev            5.9G  4.0K  5.9G   1% /dev
>>> tmpfs           1.2G  720K  1.2G   1% /run
>>> none            5.0M     0  5.0M   0% /run/lock
>>> none            5.9G   81M  5.8G   2% /run/shm
>>> none            100M   20K  100M   1% /run/user
>>> /dev/ram1       9.0G  8.4G  618M  94% /home/ssd/src/bluestore/ceph-deploy/osd/myosddata
>>>
>>> Journal size:
>>>
>>> -rw-r--r--   1 ssd ssd         37 Feb 25 15:53 ceph_fsid
>>> drwxr-xr-x 132 ssd ssd       4096 Feb 25 15:53 current
>>> -rw-r--r--   1 ssd ssd         37 Feb 25 15:53 fsid
>>> -rw-r--r--   1 ssd ssd         21 Feb 25 15:53 magic
>>> -rw-r--r--   1 ssd ssd 1073741824 Feb 25 15:53 myosdjournal
>>> -rw-r--r--   1 ssd ssd          6 Feb 25 15:53 ready
>>> -rw-r--r--   1 ssd ssd          4 Feb 25 15:53 store_version
>>> -rw-r--r--   1 ssd ssd         53 Feb 25 15:53 superblock
>>> -rw-r--r--   1 ssd ssd         10 Feb 25 15:53 type
>>> -rw-r--r--   1 ssd ssd          2 Feb 25 15:53 whoami
>>>
>>> du -sh
>>> It shows current use 8G.
>>>
>>> Appendix 1:
>>> [global]
>>> fsid = a7f64266-0894-4f1e-a635-d0aeaca0e993
>>> auth_cluster_required = none
>>> auth_service_required = none
>>> auth_client_required = none
>>> filestore_xattr_use_omap = true
>>> filestore_max_sync_interval=10
>>> filestore_fd_cache_size = 64
>>> filestore_fd_cache_shards = 32
>>> filestore_op_threads = 6
>>> filestore_queue_max_ops=5000
>>> filestore_queue_committing_max_ops=5000
>>> journal_max_write_entries=1000
>>> journal_queue_max_ops=3000
>>> filestore_wbthrottle_enable=false
>>> filestore_queue_max_bytes=1048576000
>>> filestore_queue_committing_max_bytes=1048576000
>>> journal_max_write_bytes=1048576000
>>> journal_queue_max_bytes=1048576000
>>>
>>> osd_journal_size = 1024
>>> debug_lockdep = 0/0
>>> debug_context = 0/0
>>> debug_crush = 0/0
>>> debug_buffer = 0/0
>>> debug_timer = 0/0
>>> debug_filer = 0/0
>>> debug_objecter = 0/0
>>> debug_rados = 0/0
>>> debug_rbd = 0/0
>>> debug_journaler = 0/0
>>> debug_objectcatcher = 0/0
>>> debug_client = 0/0
>>> debug_osd = 0/0
>>> debug_optracker = 0/0
>>> debug_objclass = 0/0
>>> debug_filestore = 0/0
>>> debug_journal = 0/0
>>> debug_ms = 0/0
>>> debug_monc = 0/0
>>> debug_tp = 0/0
>>> debug_auth = 0/0
>>> debug_finisher = 0/0
>>> debug_heartbeatmap = 0/0
>>> debug_perfcounter = 0/0
>>> debug_asok = 0/0
>>> debug_throttle = 0/0
>>> debug_mon = 0/0
>>> debug_paxos = 0/0
>>> debug_rgw = 0/0
>>> debug_newstore = 0/0
>>> debug_keyvaluestore = 0/0
>>> osd_tracing = true
>>> osd_objectstore_tracing = true
>>> rados_tracing = true
>>> rbd_tracing = true
>>> osd_mount_options_xfs = rw,noatime,inode64,logbsize=256k,delaylog
>>> osd_mkfs_options_xfs = -f -i size=2048 osd_op_threads = 32
>>> objecter_inflight_ops=102400
>>> ms_dispatch_throttle_bytes=1048576000
>>> objecter_infilght_op_bytes=1048576000
>>> osd_mkfs_type = xfs
>>> osd_client_message_size_cap = 0
>>> osd_client_message_cap = 0
>>> osd_enable_op_tracker = false
>>> mon_initial_members = localhost
>>> mon_host = 127.0.0.1
>>> mon data = '$CEPH_DEPLOY'/mon/mymondata mon cluster log file =
>>> '$CEPH_DEPLOY'/mon/mon.log
>>> keyring='$CEPH_DEPLOY'/ceph.client.admin.keyring
>>> run dir = '$CEPH_DEPLOY'/run
>>> [osd.0]
>>> osd data = '$CEPH_DEPLOY'/osd/myosddata osd journal =
>>> '$CEPH_DEPLOY'/osd/myosddata/myosdjournal
>>> #osd journal = '$WORKSPACE'/myosdjournal/myosdjournal
>>> log file = '$CEPH_DEPLOY'/osd/osd.log'
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
