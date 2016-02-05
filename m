From: "Vish (Vishwanath) Maram-SSI" <vishwanath.m@ssi.samsung.com>
Subject: Reg:.[CBT] Unable to do a CBT Clean Run.
Date: Fri, 5 Feb 2016 16:43:18 +0000
Message-ID: <B22CD36FB1C8D94DB1871AFD0023B0E438D720F8@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.ssi.samsung.com ([207.140.43.204]:54914 "EHLO
	mx1.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134AbcBEQun convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 11:50:43 -0500
Received: from ssiexch-casht1.ssi.samsung.com ([105.128.134.61]) by mx1.ssi.samsung.com with ESMTP id NbMZJpGxgaAlzPyw for <ceph-devel@vger.kernel.org>; Fri, 05 Feb 2016 08:50:41 -0800 (PST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi All,

We are trying to do a clean run with CBT and please find below all the details:

1.	OS - CentOS7.2
2.	CBT - Commit ID "1203c2b9d25344d1e15b28236ea2f19aa3103e0b" from "git log"
3.	CEPH Code - Hammer Version - 0.94.5
4.	Test.yaml - Please find below
5.	Ceph.conf - Please find below

Issue:
Command - ./cbt.py --archive="Archive" --conf=./ceph.conf ./test.yaml > cmd_log.txt

After the above command is executed we were able to check the Cluster is being created on the Server and able to see the status/OSD Tree as well. All those show correct, but we didn't see any IO going on the disk (iostat -t 5). So we started debugging the CBT code ceph.py under cluster directory. When we debugged and we observed that pool creation is not happening and we inserted break in ceph.py just before pool creation and executed the pool creation command on Server and get the below error:

Error EINVAL: error running crushmap through crushtool: (125) Operation canceled

And because of the above issue we weren't able to see any FIO run.

Appreciate any inputs.

Thanks,
-Vish


Test.yaml - 

  1  cluster:
  2   user: 'root'
  3   head: "Server"
  4   clients: ["client"]
  5   osds: ["Server"]
  6   mons:
  7     Mon1:
  8       a: "10.10.10.150:6789"
  9   osds_per_node: 1
10   fs: 'xfs'
11   mkfs_opts: '-f -i size=2048 -n size=64k'
12   mount_opts: '-o inode64,noatime,logbsize=256k'
13   conf_file: '/usr/local/ceph-cbt/ceph.conf.1osd'
14   iterations: 1
15   use_existing: False
16 #  clusterid: "8eda02e2-04b7-4eed-a85a-8471ea51528c"
17   clusterid: "cbttest"
18   tmp_dir: "/tmp/cbt"
19   pool_profiles:
20     rbd:
21       pg_size: 256
22       pgp_size: 256
23       replication: 1
24 benchmarks:
25   librbdfio:
26     time: 300
27     vol_size: 16384
28     mode: [write]
29     op_size: [1048576]
30     concurrent_procs: [1]
31     iodepth: [64]
32     osd_ra: [4096]
33     cmd_path: '/usr/local/bin/fio'
34     pool_profile: 'rbd'

Ceph.conf - 

[global]
        osd pool default size = 1
        auth cluster required = none
        auth service required = none
        auth client required = none
        keyring = /tmp/cbt/ceph/keyring
        osd pg bits = 8  
        osd pgp bits = 8
        log to syslog = false
        log file = /tmp/cbt/ceph/log/$name.log
        public network = 10.10.10.0/24
        cluster network = 10.10.10.0/24
        rbd cache = true
        osd scrub load threshold = 0.01
        osd scrub min interval = 137438953472
        osd scrub max interval = 137438953472
        osd deep scrub interval = 137438953472
        osd max scrubs = 16
        filestore merge threshold = 40
        filestore split multiple = 8
        osd op threads = 8
        mon pg warn max object skew = 100000
        mon pg warn min per osd = 0
        mon pg warn max per osd = 32768

[mon]
        mon data = /tmp/cbt/ceph/mon.$id

[mon.a]
        host = Mon1 
        mon addr = 10.10.10.150:6789

[osd.0]
        host = Server
        osd data = /tmp/cbt/mnt/osd-device-0-data
        osd journal = /dev/disk/by-partlabel/osd-device-0-journal


