From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: RBD performance - tuning hints
Date: Tue, 28 Aug 2012 19:48:42 +0200
Message-ID: <20120828174842.GA9872@oder.mch.fsc.net>
References: <500931CF.9040407@selectel.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:39134 "EHLO
	smtpa1.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab2H1Rto (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 13:49:44 -0400
Content-Disposition: inline
In-Reply-To: <500931CF.9040407@selectel.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

on my 4-node system (SSD + 10GbE, see bench-config.txt for details)
I can observe a pretty nice rados bench performance 
(see bench-rados.txt for details):

Bandwidth (MB/sec):     961.710 
Max bandwidth (MB/sec): 1040
Min bandwidth (MB/sec): 772


Also the bandwidth performance generated with
  fio --filename=/dev/rbd1 --direct=1 --rw=$io --bs=$bs --size=2G --iodepth=$threads --ioengine=libaio --runtime=60 --group_reporting --name=file1 --output=fio_${io}_${bs}_${threads}

.... is acceptable, e.g.
fio_write_4m_16		795 MB/s
fio_randwrite_8m_128	717 MB/s
fio_randwrite_8m_16	714 MB/s
fio_randwrite_2m_32	692 MB/s


But, the write IOPS seems to be limited around 19k ...
RBD                     4M      64k (= optimal_io_size)
fio_randread_512_128    53286   55925
fio_randread_4k_128     51110   44382
fio_randread_8k_128     30854   29938
fio_randwrite_512_128   18888    2386
fio_randwrite_512_64    18844    2582
fio_randwrite_8k_64     17350    2445
(...)
fio_read_4k_128         10073   53151
fio_read_4k_64           9500   39757
fio_read_4k_32           9220   23650
(...)
fio_read_4k_16           9122   14322
fio_write_4k_128         2190   14306
fio_read_8k_32            706   13894
fio_write_4k_64          2197   12297
fio_write_8k_64          3563   11705
fio_write_8k_128         3444   11219


Any hints for tuning the IOPS (read and/or write) would be appreciated.

How can I set the variables when the Journal data have go to the OSD ? (after X seconds and/or when Y %-full)


Kind Regards,
-Dieter

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bench-rados.txt"

rados bench -p pbench 60 write
 Maintaining 16 concurrent writes of 4194304 bytes for at least 60 seconds.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
     0       0         0         0         0         0         -         0
     1      16       228       212   847.857       848  0.042984 0.0684383
     2      16       451       435    869.88       892  0.084162 0.0700566
     3      16       695       679   905.223       976  0.057677 0.0695337
     4      16       942       926   925.894       988  0.038117 0.0685357
     5      16      1162      1146     916.7       880  0.042098 0.0693864
     6      16      1400      1384   922.569       952  0.063983 0.0689167
     7      16      1644      1628   930.189       976  0.065745 0.0684646
     8      16      1895      1879   939.404      1004  0.051277 0.0677953
     9      16      2145      2129   946.127      1000  0.055165  0.067354
(...)
    57      16     13704     13688    960.47       996  0.082716 0.0665862
    58      16     13954     13938    961.15      1000  0.041879 0.0665307
    59      16     14194     14178   961.129       960  0.046657 0.0664642
2012-08-28 17:32:18.620060min lat: 0.030234 max lat: 3.17834 avg lat: 0.0664676
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
    60      16     14446     14430   961.909      1008  0.051635 0.0664676
 Total time run:         60.084612
Total writes made:      14446
Write size:             4194304
Bandwidth (MB/sec):     961.710 

Stddev Bandwidth:       54.0809
Max bandwidth (MB/sec): 1040
Min bandwidth (MB/sec): 772
Average Latency:        0.0665337
Stddev Latency:         0.0800225
Max latency:            3.17834
Min latency:            0.030234

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bench-config.txt"

--- RX37-3c --------------------------------------------------------------------
ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux RX37-3 3.0.41-5.1-default #1 SMP Wed Aug 22 00:54:03 UTC 2012 (9c63123) x86_64 x86_64 x86_64 GNU/Linux

model name	: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
Logial CPUs: 12
  current CPU frequency is 2.30 GHz (asserted by call to hardware).
MemTotal:       32856332 kB
Disk /dev/ram0: 2048 MB, 2048000000 bytes
Disk /dev/ram1: 2048 MB, 2048000000 bytes
Disk /dev/ram2: 2048 MB, 2048000000 bytes
Disk /dev/ram3: 2048 MB, 2048000000 bytes
Disk /dev/ram4: 2048 MB, 2048000000 bytes
Disk /dev/ram5: 2048 MB, 2048000000 bytes
Disk /dev/ram6: 2048 MB, 2048000000 bytes
Disk /dev/ram7: 2048 MB, 2048000000 bytes
[10:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdm 
[10:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdn 
[10:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdo 
[10:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdp 
[11:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdq 
[11:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdr 
[11:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sds 
[11:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdt 
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     37 C
  Blocks sent to initiator = 198232151949312
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     39 C
  Blocks sent to initiator = 188127268306944
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     42 C
  Blocks sent to initiator = 241646771896320
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     33 C
  Blocks sent to initiator = 202151376715776
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     34 C
  Blocks sent to initiator = 186279543177216
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     36 C
  Blocks sent to initiator = 200414079221760
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     40 C
  Blocks sent to initiator = 301595287879680
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     30 C
  Blocks sent to initiator = 190686448058368
optimal_io_size: scheduler:       [noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
/dev/sdm on /data/osd.30 type btrfs (rw,noatime)
/dev/sdn on /data/osd.31 type btrfs (rw,noatime)
/dev/sdo on /data/osd.32 type btrfs (rw,noatime)
/dev/sdp on /data/osd.33 type btrfs (rw,noatime)
/dev/sdq on /data/osd.34 type btrfs (rw,noatime)
/dev/sdr on /data/osd.35 type btrfs (rw,noatime)
/dev/sds on /data/osd.36 type btrfs (rw,noatime)
/dev/sdt on /data/osd.37 type btrfs (rw,noatime)
--- RX37-4c --------------------------------------------------------------------
ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux RX37-4 3.0.36-10-default #1 SMP Mon Jul 9 14:42:03 UTC 2012 (595894d) x86_64 x86_64 x86_64 GNU/Linux

model name	: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
Logial CPUs: 12
  current CPU frequency is 2.30 GHz (asserted by call to hardware).
MemTotal:       32856432 kB
Disk /dev/ram0: 2048 MB, 2048000000 bytes
Disk /dev/ram1: 2048 MB, 2048000000 bytes
Disk /dev/ram2: 2048 MB, 2048000000 bytes
Disk /dev/ram3: 2048 MB, 2048000000 bytes
Disk /dev/ram4: 2048 MB, 2048000000 bytes
Disk /dev/ram5: 2048 MB, 2048000000 bytes
Disk /dev/ram6: 2048 MB, 2048000000 bytes
Disk /dev/ram7: 2048 MB, 2048000000 bytes
[10:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdd 
[10:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sde 
[10:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdf 
[10:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdg 
[11:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdh 
[11:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdi 
[11:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdj 
[11:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdk 
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     33 C
  Blocks sent to initiator = 326270260871168
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     29 C
  Blocks sent to initiator = 230247207272448
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     34 C
  Blocks sent to initiator = 168513041858560
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     37 C
  Blocks sent to initiator = 171904673513472
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     30 C
  Blocks sent to initiator = 175995797635072
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     36 C
  Blocks sent to initiator = 206814587125760
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     26 C
  Blocks sent to initiator = 239652363567104
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     32 C
  Blocks sent to initiator = 221954917269504
optimal_io_size: scheduler:       [noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
/dev/sdd on /data/osd.40 type btrfs (rw,noatime)
/dev/sde on /data/osd.41 type btrfs (rw,noatime)
/dev/sdf on /data/osd.42 type btrfs (rw,noatime)
/dev/sdg on /data/osd.43 type btrfs (rw,noatime)
/dev/sdh on /data/osd.44 type btrfs (rw,noatime)
/dev/sdi on /data/osd.45 type btrfs (rw,noatime)
/dev/sdj on /data/osd.46 type btrfs (rw,noatime)
/dev/sdk on /data/osd.47 type btrfs (rw,noatime)
--- RX37-5c --------------------------------------------------------------------
ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux RX37-5 3.0.36-10-default #1 SMP Mon Jul 9 14:42:03 UTC 2012 (595894d) x86_64 x86_64 x86_64 GNU/Linux

model name	: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
Logial CPUs: 12
  current CPU frequency is 2.30 GHz (asserted by call to hardware).
MemTotal:       74226012 kB
Disk /dev/ram0: 2048 MB, 2048000000 bytes
Disk /dev/ram1: 2048 MB, 2048000000 bytes
Disk /dev/ram2: 2048 MB, 2048000000 bytes
Disk /dev/ram3: 2048 MB, 2048000000 bytes
Disk /dev/ram4: 2048 MB, 2048000000 bytes
Disk /dev/ram5: 2048 MB, 2048000000 bytes
Disk /dev/ram6: 2048 MB, 2048000000 bytes
Disk /dev/ram7: 2048 MB, 2048000000 bytes
[10:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdo 
[10:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdp 
[10:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdq 
[10:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdr 
[11:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sds 
[11:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdt 
[11:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdu 
[11:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdv 
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     36 C
  Blocks sent to initiator = 195550280417280
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     37 C
  Blocks sent to initiator = 177656960122880
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     41 C
  Blocks sent to initiator = 238550402465792
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     31 C
  Blocks sent to initiator = 226579741409280
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     33 C
  Blocks sent to initiator = 186652383248384
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     34 C
  Blocks sent to initiator = 219684389519360
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     39 C
  Blocks sent to initiator = 223471107833856
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     29 C
  Blocks sent to initiator = 190300723085312
optimal_io_size: scheduler:       [noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
/dev/sdo on /data/osd.50 type btrfs (rw,noatime)
/dev/sdp on /data/osd.51 type btrfs (rw,noatime)
/dev/sdq on /data/osd.52 type btrfs (rw,noatime)
/dev/sdr on /data/osd.53 type btrfs (rw,noatime)
/dev/sds on /data/osd.54 type btrfs (rw,noatime)
/dev/sdt on /data/osd.55 type btrfs (rw,noatime)
/dev/sdu on /data/osd.56 type btrfs (rw,noatime)
/dev/sdv on /data/osd.57 type btrfs (rw,noatime)
--- RX37-6c --------------------------------------------------------------------
ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux RX37-6 3.0.36-10-default #1 SMP Mon Jul 9 14:42:03 UTC 2012 (595894d) x86_64 x86_64 x86_64 GNU/Linux

model name	: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
Logial CPUs: 12
  current CPU frequency is 2.30 GHz (asserted by call to hardware).
MemTotal:       32856344 kB
Disk /dev/ram0: 2048 MB, 2048000000 bytes
Disk /dev/ram1: 2048 MB, 2048000000 bytes
Disk /dev/ram2: 2048 MB, 2048000000 bytes
Disk /dev/ram3: 2048 MB, 2048000000 bytes
Disk /dev/ram4: 2048 MB, 2048000000 bytes
Disk /dev/ram5: 2048 MB, 2048000000 bytes
Disk /dev/ram6: 2048 MB, 2048000000 bytes
Disk /dev/ram7: 2048 MB, 2048000000 bytes
[10:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdn 
[10:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdo 
[10:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdp 
[10:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdq 
[11:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdr 
[11:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sds 
[11:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdt 
[11:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdu 
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     41 C
  Blocks sent to initiator = 195597608943616
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     36 C
  Blocks sent to initiator = 197325225984000
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     42 C
  Blocks sent to initiator = 182463498289152
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     45 C
  Blocks sent to initiator = 250870398713856
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     37 C
  Blocks sent to initiator = 209343584665600
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     33 C
  Blocks sent to initiator = 226728102330368
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     43 C
  Blocks sent to initiator = 213839006138368
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     38 C
  Blocks sent to initiator = 179503745728512
optimal_io_size: scheduler:       [noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
/dev/sdn on /data/osd.60 type btrfs (rw,noatime)
/dev/sdo on /data/osd.61 type btrfs (rw,noatime)
/dev/sdp on /data/osd.62 type btrfs (rw,noatime)
/dev/sdq on /data/osd.63 type btrfs (rw,noatime)
/dev/sdr on /data/osd.64 type btrfs (rw,noatime)
/dev/sds on /data/osd.65 type btrfs (rw,noatime)
/dev/sdt on /data/osd.66 type btrfs (rw,noatime)
/dev/sdu on /data/osd.67 type btrfs (rw,noatime)
--- RX37-7c --------------------------------------------------------------------
ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux RX37-7 3.0.36-10-default #1 SMP Mon Jul 9 14:42:03 UTC 2012 (595894d) x86_64 x86_64 x86_64 GNU/Linux

model name	: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
Logial CPUs: 12
  current CPU frequency is 2.30 GHz (asserted by call to hardware).
MemTotal:       32856344 kB
optimal_io_size: 4194304
65536
scheduler:       [noop] deadline cfq 
noop deadline [cfq] 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
--- RX37-8c --------------------------------------------------------------------
ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux RX37-8 3.0.36-16-default #1 SMP Wed Jul 18 00:18:54 UTC 2012 (544e41f) x86_64 x86_64 x86_64 GNU/Linux

model name	: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
Logial CPUs: 12
  current CPU frequency is 2.30 GHz (asserted by call to hardware).
MemTotal:       65952088 kB
optimal_io_size: scheduler:       [noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
--------------------------------------------------------------------------------

dumped osdmap epoch 15
epoch 15
fsid 7ab4662b-0575-4875-b59d-3bef85bb918d
created 2012-08-26 15:10:43.529294
modifed 2012-08-26 15:11:09.537529
flags 

pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 4352 pgp_num 4352 last_change 1 owner 0 crash_replay_interval 45
pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num 4352 pgp_num 4352 last_change 1 owner 0
pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 4352 pgp_num 4352 last_change 1 owner 0

max_osd 68
osd.30 up   in  weight 1 up_from 2 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.52:6800/7884 192.168.114.52:6800/7884 192.168.114.52:6801/7884 exists,up f1912b6b-2abf-4eef-83e0-8657d78e48f8
osd.31 up   in  weight 1 up_from 4 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.52:6801/8057 192.168.114.52:6802/8057 192.168.114.52:6803/8057 exists,up 2a254612-5242-4ae8-8ba7-3fe2eaa3eec5
osd.32 up   in  weight 1 up_from 3 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.52:6802/8225 192.168.114.52:6804/8225 192.168.114.52:6805/8225 exists,up d41508ee-131c-47b8-9218-8f81bc7f7716
osd.33 up   in  weight 1 up_from 3 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.52:6803/8415 192.168.114.52:6806/8415 192.168.114.52:6807/8415 exists,up 2e5a96be-ca3a-4c7d-8895-b61c07d858ac
osd.34 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.52:6804/8588 192.168.114.52:6808/8588 192.168.114.52:6809/8588 exists,up 214d8253-ad9b-4268-ba67-365ae9bc612a
osd.35 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.52:6805/8777 192.168.114.52:6810/8777 192.168.114.52:6811/8777 exists,up 9d328117-581a-4fdb-bee8-e373e74ee013
osd.36 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.52:6806/8966 192.168.114.52:6812/8966 192.168.114.52:6813/8966 exists,up 0d046c45-ddd3-4c24-814c-36ace0632167
osd.37 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.52:6807/9155 192.168.114.52:6814/9155 192.168.114.52:6815/9155 exists,up 2265a65a-624c-4729-bf64-47850270b4a9
osd.40 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.53:6800/14455 192.168.114.53:6800/14455 192.168.114.53:6801/14455 exists,up e782364f-c5ee-4181-98ba-8e8009a789db
osd.41 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.53:6801/14639 192.168.114.53:6802/14639 192.168.114.53:6803/14639 exists,up 3154b1e5-e49a-417a-9b80-d64995afb2c8
osd.42 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.53:6802/14816 192.168.114.53:6804/14816 192.168.114.53:6805/14816 exists,up a7cab833-70b2-4067-83a3-a8a7b7ccb1c2
osd.43 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.53:6803/15013 192.168.114.53:6806/15013 192.168.114.53:6807/15013 exists,up 5afeea03-5a5d-4643-bbde-aaadda1bde01
osd.44 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.53:6804/15190 192.168.114.53:6808/15190 192.168.114.53:6809/15190 exists,up 5b1a90a2-596d-40d4-b33d-cf74142f7e96
osd.45 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.53:6805/15420 192.168.114.53:6810/15420 192.168.114.53:6811/15420 exists,up e4d85019-c8d4-4dc8-bec3-ceaddab60b99
osd.46 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.53:6806/15623 192.168.114.53:6812/15623 192.168.114.53:6813/15623 exists,up 0a1b6a02-1b70-457f-9602-8f02e00d7ae1
osd.47 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.53:6807/15826 192.168.114.53:6814/15826 192.168.114.53:6815/15826 exists,up 7be9d381-8c38-440c-ae22-fc29a9349351
osd.50 up   in  weight 1 up_from 5 up_thru 12 down_at 0 last_clean_interval [0,0) 192.168.113.54:6800/1915 192.168.114.54:6800/1915 192.168.114.54:6801/1915 exists,up 7653343d-5602-4a6e-ac69-a278dab28c8c
osd.51 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.54:6801/2155 192.168.114.54:6802/2155 192.168.114.54:6803/2155 exists,up a58bfbfb-8f21-4939-8ca1-b8209be68a30
osd.52 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.54:6802/2322 192.168.114.54:6804/2322 192.168.114.54:6805/2322 exists,up 81daeb73-23f4-4f68-b56b-7d5a1b95e7e0
osd.53 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.54:6803/2515 192.168.114.54:6806/2515 192.168.114.54:6807/2515 exists,up b3978c52-f689-45e8-9ee2-681e3bdeeeb2
osd.54 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.54:6804/2702 192.168.114.54:6808/2702 192.168.114.54:6809/2702 exists,up 205b59d3-176a-4048-84c5-81dd181a8e71
osd.55 up   in  weight 1 up_from 5 up_thru 11 down_at 0 last_clean_interval [0,0) 192.168.113.54:6805/2889 192.168.114.54:6810/2889 192.168.114.54:6811/2889 exists,up cd4d82de-0da8-48b0-a54f-d1372b611958
osd.56 up   in  weight 1 up_from 6 up_thru 14 down_at 0 last_clean_interval [0,0) 192.168.113.54:6806/3082 192.168.114.54:6812/3082 192.168.114.54:6813/3082 exists,up b82b38a6-64ad-487a-899b-6c62ebe6bb13
osd.57 up   in  weight 1 up_from 6 up_thru 14 down_at 0 last_clean_interval [0,0) 192.168.113.54:6807/3269 192.168.114.54:6814/3269 192.168.114.54:6815/3269 exists,up c155cf46-d287-4439-a39e-ff80c22e0caa
osd.60 up   in  weight 1 up_from 7 up_thru 14 down_at 0 last_clean_interval [0,0) 192.168.113.55:6800/30607 192.168.114.55:6800/30607 192.168.114.55:6801/30607 exists,up ab8370bf-c722-4eab-9842-498b6dfef765
osd.61 up   in  weight 1 up_from 7 up_thru 14 down_at 0 last_clean_interval [0,0) 192.168.113.55:6801/30801 192.168.114.55:6802/30801 192.168.114.55:6803/30801 exists,up a189a254-efcd-4129-867e-384cd0765d19
osd.62 up   in  weight 1 up_from 8 up_thru 14 down_at 0 last_clean_interval [0,0) 192.168.113.55:6802/30946 192.168.114.55:6804/30946 192.168.114.55:6805/30946 exists,up 2ddc9000-a5be-4c7f-9362-2c525b93db7f
osd.63 up   in  weight 1 up_from 9 up_thru 14 down_at 0 last_clean_interval [0,0) 192.168.113.55:6803/31139 192.168.114.55:6806/31139 192.168.114.55:6807/31139 exists,up 5c4661fb-4c6c-411d-bf46-b4ead15a019a
osd.64 up   in  weight 1 up_from 9 up_thru 14 down_at 0 last_clean_interval [0,0) 192.168.113.55:6804/31332 192.168.114.55:6808/31332 192.168.114.55:6809/31332 exists,up b67f9e9b-d0f6-41b9-ac7f-0c355950316f
osd.65 up   in  weight 1 up_from 10 up_thru 14 down_at 0 last_clean_interval [0,0) 192.168.113.55:6805/31525 192.168.114.55:6810/31525 192.168.114.55:6811/31525 exists,up 9e179b5f-b0ca-4799-8b02-13fc3a78eda5
osd.66 up   in  weight 1 up_from 10 up_thru 14 down_at 0 last_clean_interval [0,0) 192.168.113.55:6806/31814 192.168.114.55:6812/31814 192.168.114.55:6813/31814 exists,up e300060b-ac96-4ed0-9670-ffe3d7547a18
osd.67 up   in  weight 1 up_from 11 up_thru 14 down_at 0 last_clean_interval [0,0) 192.168.113.55:6807/32063 192.168.114.55:6814/32063 192.168.114.55:6815/32063 exists,up f87f78b3-61ba-403a-b012-ddd055ced47f



ceph.conf
---content---
# global
[global]
	# enable secure authentication
	auth supported = none

        # allow ourselves to open a lot of files
        #max open files = 1100000
        max open files = 131072

        # set log file
        log file = /ceph/log/$name.log
        # log_to_syslog = true        # uncomment this line to log to syslog

        # set up pid files
        pid file = /var/run/ceph/$name.pid

        # If you want to run a IPv6 cluster, set this to true. Dual-stack isn't possible
        #ms bind ipv6 = true
	public network = 192.168.113.0/24
	cluster network = 192.168.114.0/24

# monitors
#  You need at least one.  You need at least three if you want to
#  tolerate any node failures.  Always create an odd number.
[mon]
        mon data = /ceph/$name

        # If you are using for example the RADOS Gateway and want to have your newly created
        # pools a higher replication level, you can set a default
        #osd pool default size = 3

        # You can also specify a CRUSH rule for new pools
        # Wiki: http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH
        #osd pool default crush rule = 0

        # Timing is critical for monitors, but if you want to allow the clocks to drift a
        # bit more, you can specify the max drift.
        #mon clock drift allowed = 1

        # Tell the monitor to backoff from this warning for 30 seconds
        #mon clock drift warn backoff = 30

	# logging, for debugging monitor crashes, in order of
	# their likelihood of being helpful :)
	#debug ms = 1
	#debug mon = 20
	#debug paxos = 20
	#debug auth = 20
	debug optracker = 0

[mon.0]
	host = RX37-3c
	mon addr = 192.168.113.52:6789
[mon.1]
	host = RX37-7c
	mon addr = 192.168.113.56:6789
[mon.2]
	host = RX37-8c
	mon addr = 192.168.113.57:6789
	
# mds
#  You need at least one.  Define two to get a standby.
[mds]
#        mds data = /ceph/$name
	# where the mds keeps it's secret encryption keys
	#keyring = /data/keyring.$name

	# mds logging to debug issues.
	#debug ms = 1
	#debug mds = 20
	debug optracker = 0

[mds.0]
        host = RX37-8c

# osd
#  You need at least one.  Two if you want data to be replicated.
#  Define as many as you like.
[osd]
	# This is where the btrfs volume will be mounted.
	osd data = /data/$name

#        journal dio = true
#        osd op threads = 24
#        osd disk threads = 24
#        filestore op threads = 6
#        filestore queue max ops = 24

	# Ideally, make this a separate disk or partition.  A few
 	# hundred MB should be enough; more if you have fast or many
 	# disks.  You can use a file under the osd data dir if need be
 	# (e.g. /data/$name/journal), but it will be slower than a
 	# separate disk or partition.

        # This is an example of a file-based journal.
	# osd journal = /ceph/$name/journal
	# osd journal size = 2048 
	# journal size, in megabytes

        # If you want to run the journal on a tmpfs, disable DirectIO
        #journal dio = false

        # You can change the number of recovery operations to speed up recovery
        # or slow it down if your machines can't handle it
        # osd recovery max active = 3

	# osd logging to debug osd issues, in order of likelihood of being
	# helpful
	#debug ms = 1
	#debug osd = 20
	#debug filestore = 20
	#debug journal = 20
	debug optracker = 0
	fstype = btrfs

[osd.30]
	host = RX37-3c
	devs = /dev/sdm
	osd journal = /dev/ram0
[osd.31]
	host = RX37-3c
	devs = /dev/sdn
	osd journal = /dev/ram1
[osd.32]
	host = RX37-3c
	devs = /dev/sdo
	osd journal = /dev/ram2
[osd.33]
	host = RX37-3c
	devs = /dev/sdp
	osd journal = /dev/ram3
[osd.34]
	host = RX37-3c
	devs = /dev/sdq
	osd journal = /dev/ram4
[osd.35]
	host = RX37-3c
	devs = /dev/sdr
	osd journal = /dev/ram5
[osd.36]
	host = RX37-3c
	devs = /dev/sds
	osd journal = /dev/ram6
[osd.37]
	host = RX37-3c
	devs = /dev/sdt
	osd journal = /dev/ram7
[osd.40]
	host = RX37-4c
	devs = /dev/sdd
	osd journal = /dev/ram0
[osd.41]
	host = RX37-4c
	devs = /dev/sde
	osd journal = /dev/ram1
[osd.42]
	host = RX37-4c
	devs = /dev/sdf
	osd journal = /dev/ram2
[osd.43]
	host = RX37-4c
	devs = /dev/sdg
	osd journal = /dev/ram3
[osd.44]
	host = RX37-4c
	devs = /dev/sdh
	osd journal = /dev/ram4
[osd.45]
	host = RX37-4c
	devs = /dev/sdi
	osd journal = /dev/ram5
[osd.46]
	host = RX37-4c
	devs = /dev/sdj
	osd journal = /dev/ram6
[osd.47]
	host = RX37-4c
	devs = /dev/sdk
	osd journal = /dev/ram7
[osd.50]
	host = RX37-5c
	devs = /dev/sdo
	osd journal = /dev/ram0
[osd.51]
	host = RX37-5c
	devs = /dev/sdp
	osd journal = /dev/ram1
[osd.52]
	host = RX37-5c
	devs = /dev/sdq
	osd journal = /dev/ram2
[osd.53]
	host = RX37-5c
	devs = /dev/sdr
	osd journal = /dev/ram3
[osd.54]
	host = RX37-5c
	devs = /dev/sds
	osd journal = /dev/ram4
[osd.55]
	host = RX37-5c
	devs = /dev/sdt
	osd journal = /dev/ram5
[osd.56]
	host = RX37-5c
	devs = /dev/sdu
	osd journal = /dev/ram6
[osd.57]
	host = RX37-5c
	devs = /dev/sdv
	osd journal = /dev/ram7
[osd.60]
	host = RX37-6c
	devs = /dev/sdn
	osd journal = /dev/ram0
[osd.61]
	host = RX37-6c
	devs = /dev/sdo
	osd journal = /dev/ram1
[osd.62]
	host = RX37-6c
	devs = /dev/sdp
	osd journal = /dev/ram2
[osd.63]
	host = RX37-6c
	devs = /dev/sdq
	osd journal = /dev/ram3
[osd.64]
	host = RX37-6c
	devs = /dev/sdr
	osd journal = /dev/ram4
[osd.65]
	host = RX37-6c
	devs = /dev/sds
	osd journal = /dev/ram5
[osd.66]
	host = RX37-6c
	devs = /dev/sdt
	osd journal = /dev/ram6
[osd.67]
	host = RX37-6c
	devs = /dev/sdu
	osd journal = /dev/ram7
	devs = /dev/sdc

[client.01]
	client hostname = RX37-7c


--J/dobhs11T7y2rNN--

