From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: ceph-0.91 with KVstore rocksdb as objectstore backend
Date: Tue, 20 Jan 2015 16:58:15 +0800
Message-ID: <CACJqLyaVyGEykKm5KrLn86D_sUfmtFeQ73-q_2EGEBWa=MYdjg@mail.gmail.com>
References: <CAMc8nAU7tu6f8nAXGiKT2iMBuH9qs5SUE30sN5458D4aB_3+iQ@mail.gmail.com>
	<CACJqLyYfHakm7k0s+6Gr7sT8yY0ju256h2KjAGNnjJDz46fBBA@mail.gmail.com>
	<CAMc8nAXYUr8oNa0TRw76Ppo6KNs7u5iRf3APsy14u9ora0SWYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64189 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbbATI6R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jan 2015 03:58:17 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so10906605wid.5
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2015 00:58:15 -0800 (PST)
In-Reply-To: <CAMc8nAXYUr8oNa0TRw76Ppo6KNs7u5iRf3APsy14u9ora0SWYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: pushpesh sharma <pushpesh.eck@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sorry, could you add debug_keyvaluestore=20/20 to your config.conf and
run again to capture the dump logs?


And simply view the log, it seemed that keyvaluestore failed to submit
transaction to rocksdb.

Additionally, run "ceph --admin-daemon=/var/run/ceph/[ceph-osd.*.pid]
perf dump" is help to verify the assumption.

Thanks!

On Tue, Jan 20, 2015 at 4:53 PM, pushpesh sharma <pushpesh.eck@gmail.com> wrote:
> Haomai,
>
> PFA for the complete logs of one of the OSD daemon. In an attempt to
> start all osd daemon, I captured logs of one of the OSD daemon is
> pasted here:  http://pastebin.com/SRBJknCM .
>
>
>
> On Tue, Jan 20, 2015 at 12:34 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> I think you can find related infos from log: /var/log/ceph/osd/ceph-osd*
>>
>> It should help us to figure out.
>>
>> On Tue, Jan 20, 2015 at 2:48 PM, pushpesh sharma <pushpesh.eck@gmail.com> wrote:
>>> Hi All,
>>>
>>> I am trying to configure rocksdb as objectstore backend on a cluster
>>> with ceph version 0.91-375-g2a4cbfc. I built ceph using' make-debs.sh'
>>> which builds the source with  --with-rocksdb option. I was able to get
>>> the cluster up and running with rockdbs as a backend, however as soon
>>> as I started dumping data on cluster using radosbench , cluster become
>>> miserable just after 10 sec of write I/Os. Some OSD daemons marked
>>> down randomly for no apparent reason. Even if  I make all daemons
>>> start/up again , after some time some daemons marked down again
>>> randomly.Recovery i/o does the job this time , that external i/o done
>>> before. What could be the possible problem and solution for this
>>> behaviour?
>>>
>>> Some more details:
>>>
>>> 1. Setup is 3 OSD nodes with 10 SanDisk Optimus Eco (400GB)
>>> each.Drives were working fine with filestore backend.
>>> 2. 3 Monitors and 1 client from which I am running RadosBench.
>>> 3. Ubuntu14.04 on each node. (3.13.0-24-generic)
>>> 4. I create OSDs on each nodes using below script(of course with
>>> different osd numbers):-
>>> ##################################
>>> #!/bin/bash
>>> sudo stop ceph-osd-all
>>> ps -eaf|grep osd |awk '{print $2}'|xargs sudo kill -9
>>> osd_num=(0 1 2 3 4 5 6 7 8 9)
>>> drives=(sdb1 sdc1 sdd1 sde1 sdf1 sdg1 sdh1 sdi1 sdj1 sdk1)
>>> node="rack6-storage-1"
>>> for ((i=0;i<10;i++))
>>> do
>>>         sudo ceph osd rm ${osd_num[i]}
>>>         sudo ceph osd crush rm osd.${osd_num[i]}
>>>         sudo ceph auth del osd.${osd_num[i]}
>>>         sudo umount -f /var/lib/ceph/osd/ceph-${osd_num[i]}
>>>         ceph osd create
>>>         sudo rm -rf /var/lib/ceph/osd/ceph-${osd_num[i]}
>>>         sudo mkdir -p /var/lib/ceph/osd/ceph-${osd_num[i]}
>>>         sudo mkfs.xfs -f -i size=2048 /dev/${drives[i]}
>>>         sudo mount -o rw,noatime,inode64,logbsize=256k,delaylog
>>> /dev/${drives[i]} /var/lib/ceph/osd/ceph-${osd_num[i]}
>>>         sudo ceph osd crush add osd.${osd_num[i]} 1 root=default host=$node
>>>         sudo sudo ceph-osd --id ${osd_num[i]} -d --mkkey --mkfs
>>> --osd-data /var/lib/ceph/osd/ceph-${osd_num[i]}
>>>         ceph auth add osd.${osd_num[i]} osd 'allow *' mon 'allow
>>> profile osd' -i /var/lib/ceph/osd/ceph-${osd_num[i]}/keyring
>>>         sudo sudo ceph-osd -i ${osd_num[i]}
>>> done
>>> ###################################
>>>
>>> 5. Some configs that might be relevant are as follows:-
>>> #########
>>> enable_experimental_unrecoverable_data_corrupting_features = keyvaluestore
>>> osd_objectstore = keyvaluestore
>>> keyvaluestore_backend = rocksdb
>>> keyvaluestore queue max ops = 500
>>> keyvaluestore queue max bytes = 100
>>> keyvaluestore header cache size = 2048
>>> keyvaluestore op threads = 10
>>> keyvaluestore_max_expected_write_size = 4096000
>>> leveldb_write_buffer_size = 33554432
>>> leveldb_cache_size = 536870912
>>> leveldb_bloom_size = 0
>>> leveldb_max_open_files = 10240
>>> leveldb_compression = false
>>> leveldb_paranoid = false
>>> leveldb_log = /dev/null
>>> leveldb_compact_on_mount = false
>>> rocksdb_write_buffer_size = 33554432
>>> rocksdb_cache_size = 536870912
>>> rocksdb_bloom_size = 0
>>> rocksdb_max_open_files = 10240
>>> rocksdb_compression = false
>>> rocksdb_paranoid = false
>>> rocksdb_log = /dev/null
>>> rocksdb_compact_on_mount = false
>>> #########
>>>
>>> 6. Objects get stored in *.sst files, seems rocksbd is configured correctly:-
>>>
>>> ls -l /var/lib/ceph/osd/ceph-20/current/ |more
>>> total 3169352
>>> -rw-r--r-- 1 root root  2128430 Jan 20 00:04 000031.sst
>>> -rw-r--r-- 1 root root  2128430 Jan 20 00:04 000033.sst
>>> -rw-r--r-- 1 root root  2128431 Jan 20 00:04 000035.sst
>>> ............
>>> 7. This is current state of cluster:-
>>> ################
>>> monmap e1: 3 mons at
>>> {rack6-ramp-1=10.x.x.x:6789/0,rack6-ramp-2=10.x.x.x:6789/0,rack6-ramp-3=10.x.x.x:6789/0}
>>> election epoch 16, quorum 0,1,2 rack6-ramp-1,rack6-ramp-2,rack6-ramp-3
>>> osdmap e547: 30 osds: 8 up, 8 in
>>>       pgmap v1059: 512 pgs, 1 pools, 18252 MB data, 4563 objects
>>>             22856 MB used, 2912 GB / 2934 GB avail
>>>             1587/13689 objects degraded (11.593%)
>>>             419/13689 objects misplaced (3.061%)
>>>             26/4563 unfound (0.570%)
>>> #################
>>>
>>> I would be happy to provide any other information that is needed.
>>>
>>> --
>>> -Pushpesh
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>
>
>
> --
> -Pushpesh



-- 
Best Regards,

Wheat
