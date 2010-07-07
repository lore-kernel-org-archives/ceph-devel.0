From: Wido den Hollander <wido@pcextreme.nl>
Subject: Some performance tests with Ceph
Date: Wed, 07 Jul 2010 16:01:14 +0200
Message-ID: <1278511274.1946.136.camel@wido-desktop>
Reply-To: wido@pcextreme.nl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-5xvPBSXoaCFzW+6u39EK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:44569 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab0GGOBR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jul 2010 10:01:17 -0400
Received: from zarafa.pcextreme.nl (zarafa.pcextreme.nl [79.99.135.237])
	by support.pcextreme.nl (Postfix) with ESMTP id D516C841FE
	for <ceph-devel@vger.kernel.org>; Wed,  7 Jul 2010 16:01:15 +0200 (CEST)
Received: from [192.168.6.32] (cable-191-148.zeelandnet.nl [82.176.191.148])
	by zarafa.pcextreme.nl (Postfix) with ESMTPSA id 3FF6360000B0
	for <ceph-devel@vger.kernel.org>; Wed,  7 Jul 2010 16:01:25 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--=-5xvPBSXoaCFzW+6u39EK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

Lately there has been much to do about the performance of Ceph. Since i
got some spare hardware i build a new cluster with a total of 30 OSD's
spread over 12 physical nodes.

The hardware is really old stuff, most of it are Opteron 170 CPU's with
1GB of DDR1 Ram (2 disks), but some are Core2Quad machines with 4GB Ram
(4 disks).

The disks are all leftovers, some are 160GB, others 250GB and some are
500GB disks (WD Greenpower).

For my client i used a simple Celeron 2.6Ghz machine with 3GB Ram.

The network is all GigE where i used a Brocade 24x GigE switch to make
sure there is enough bandwith.

My client and three physical machines (the ones with 4 OSD's) all have
two connections to the switch, this to utilize bonding for maximum
throughput.

I used bonding mode 2 (xor) with hash policy 1 (layer3+4) to make sure i
was using all the available links.

This setup gives me:

root@node14:~# ceph -s
10.07.07_14:27:38.503345 7f809e28b710 monclient(hunting): found mon1
10.07.07_14:27:38.512432    pg v3622: 7936 pgs: 7936 active+clean; 42184
MB data, 84909 MB used, 6301 GB / 6383 GB avail
10.07.07_14:27:38.530634   mds e18: 1/1/1 up {0=up:active}, 1 up:standby
10.07.07_14:27:38.530671   osd e70: 30 osds: 30 up, 30 in
10.07.07_14:27:38.530758   log 10.07.07_12:18:20.044024 mon0
213.189.18.213:6789/0 6 : [INF] mds0 213.189.18.213:6800/30084 up:active
10.07.07_14:27:38.530846   mon e1: 2 mons at 213.189.18.213:6789/0
213.189.18.214:6789/0
root@node14:~#

So when this was all up i started running some tests with "dd".

dd if=/dev/zero of=100GB.bin bs=1024k count=102400 conv=sync

Average write speed: 156MB/sec

dd if=10GB.bin of=/dev/null

Average read speed: 38MB/sec

The read is much slower than the write. Tried playing with the rsize
mount option, this gave me:

2MB: 38MB/sec
4MB: 38MB/sec
8MB: 38MB/sec
16MB: 39MB/sec
32MB: 49MB/sec
64MB: 51MB/sec

Seems that a short read burst to about 66MB/sec, but when reading a
large stream of data, the speed drops. Not sure what this is.

I also performed some bonnie++ tests, those are also attached. I have to
note that my client somehow went OOM during the bonnie++ test.

In my tests Ceph really starts to perform better on terms of performance
and stability, keep up the good work.

All these tests were performed with the unstable branch (commit
1ca446dd9ac2a03c47b3b6f8cc7007660da911ec) and running 2.6.35-rc1 on all
the nodes and client.

The OS used was Ubuntu 10.04 (AMD64).

-- 
Met vriendelijke groet,

Wido den Hollander

PCextreme B.V. / CTO
Contact: http://www.pcextreme.nl/contact
Telefoon direct: +31 (0)20 50 60 104



--=-5xvPBSXoaCFzW+6u39EK
Content-Disposition: attachment; filename="ceph.conf"
Content-Type: text/plain; name="ceph.conf"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[global]
	auth supported = none
	debug ms = 0
	keyring = /etc/ceph/keyring.bin

[mon]
	mon data = /srv/ceph/mon$id
	mon lease wiggle room = 0.5
	debug mon = 1

[mon0]
	host = node13
	mon addr = 213.189.18.213:6789

[mon1]
	host = node14
	mon addr = 213.189.18.214:6789

[mds]
	debug mds = 1

[mds0]
	host = node13

[mds1]
	host = node14

[osd]
	osd data = /srv/ceph/osd$id
	debug osd = 1
	debug filestore = 1

[osd0]
	host = node01
	osd journal = /dev/sda6
	btrfs devs = /dev/sda7

[osd1]
	host = node01
	osd journal = /dev/sdb1
	btrfs devs = /dev/sdb2

[osd2]
	host = node01
	osd journal = /dev/sdc1
	btrfs devs = /dev/sdc2

[osd3]
	host = node01
	osd journal = /dev/sdd1
	btrfs devs = /dev/sdd2

[osd4]
	host = node02
	osd journal = /dev/sda6
	btrfs devs = /dev/sda7

[osd5]
	host = node02
	osd journal = /dev/sdb1
	btrfs devs = /dev/sdb2

[osd6]
	host = node02
	osd journal = /dev/sdc1
	btrfs devs = /dev/sdc2

[osd7]
	host = node02
	osd journal = /dev/sdd1
	btrfs devs = /dev/sdd2

[osd8]
	host = node03
	osd journal = /dev/sda6
	btrfs devs = /dev/sda7

[osd9]
	host = node03
	osd journal = /dev/sdb1
	btrfs devs = /dev/sdb2

[osd10]
	host = node04
	osd journal = /dev/sda6
	btrfs devs = /dev/sda7

[osd11]
	host = node04
	osd journal = /dev/sdb1
	btrfs devs = /dev/sdb2

[osd12]
	host = node05
	osd journal = /dev/sda6
	btrfs devs = /dev/sda7

[osd13]
	host = node05
	osd journal = /dev/sdb1
	btrfs devs = /dev/sdb2

[osd14]
	host = node06
	osd journal = /dev/sda6
	btrfs devs = /dev/sda7

[osd15]
	host = node06
	osd journal = /dev/sdb1
	btrfs devs = /dev/sdb2

[osd16]
	host = node07
	osd journal = /dev/sda6
	btrfs devs = /dev/sda7

[osd17]
	host = node07
	osd journal = /dev/sdb1
	btrfs devs = /dev/sdb2

[osd18]
	host = node08
	osd journal = /dev/sda6
	btrfs devs = /dev/sda7

[osd19]
	host = node08
	osd journal = /dev/sdb1
	btrfs devs = /dev/sdb2

[osd20]
	host = node09
	osd journal = /dev/sda6
	btrfs devs = /dev/sda7

[osd21]
	host = node09
	osd journal = /dev/sdb1
	btrfs devs = /dev/sdb2

[osd22]
	host = node09
	osd journal = /dev/sdc1
	btrfs devs = /dev/sdc2

[osd23]
	host = node09
	osd journal = /dev/sdd1
	btrfs devs = /dev/sdd2

[osd24]
	host = node10
	osd journal = /dev/sda6
	btrfs devs = /dev/sda7

[osd25]
	host = node10
	osd journal = /dev/sdb1
	btrfs devs = /dev/sdb2

[osd26]
	host = node11
	osd journal = /dev/sda6
	btrfs devs = /dev/sda7

[osd27]
	host = node11
	osd journal = /dev/sdb1
	btrfs devs = /dev/sdb2

[osd28]
	host = node12
	osd journal = /dev/sda6
	btrfs devs = /dev/sda7

[osd29]
	host = node12
	osd journal = /dev/sdb1
	btrfs devs = /dev/sdb2


--=-5xvPBSXoaCFzW+6u39EK
Content-Disposition: attachment; filename="bonnie.csv"
Content-Type: text/csv; name="bonnie.csv"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

format_version,bonnie_version,name,file_size,io_chunk_size,putc,putc_cpu,put_block,put_block_cpu,rewrite,rewrite_cpu,getc,getc_cpu,get_block,get_block_cpu,seeks,seeks_cpu,num_files,max_size,min_size,num_dirs,file_chunk_size,seq_create,seq_create_cpu,seq_stat,seq_stat_cpu,seq_del,seq_del_cpu,ran_create,ran_create_cpu,ran_stat,ran_stat_cpu,ran_del,ran_del_cpu,putc_latency,put_block_latency,rewrite_latency,getc_latency,get_block_latency,seeks_latency,seq_create_latency,seq_stat_latency,seq_del_latency,ran_create_latency,ran_stat_latency,ran_del_latency
1.96,1.96,client02,1,1278508021,6G,,670,95,127842,72,35050,8,1230,97,80082,6,2564,80,16,,,,,1496,6,+++++,+++,1087,2,1734,7,+++++,+++,467,1,13751us,34839us,1397ms,29449us,131ms,204ms,329ms,424us,894ms,500ms,30us,1972ms
1.96,1.96,client02,1,1278508021,6G,,640,96,117870,67,38083,10,1107,96,92545,7,2695,84,16,,,,,1172,5,+++++,+++,1087,2,1735,7,+++++,+++,466,1,22054us,22028us,1314ms,49389us,80395us,46550us,270ms,422us,1045ms,160ms,72us,1683ms
1.96,1.96,client02,1,1278508021,6G,,640,96,125643,72,40419,10,1123,97,89560,7,2562,79,16,,,,,1159,5,+++++,+++,1072,2,1155,5,+++++,+++,467,1,16838us,37100us,1319ms,35125us,513ms,48130us,291ms,422us,2729ms,1096ms,30us,1365ms

--=-5xvPBSXoaCFzW+6u39EK
Content-Disposition: attachment; filename="crushmap.txt"
Content-Type: text/plain; name="crushmap.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

# begin crush map

# devices
device 0 device0
device 1 device1
device 2 device2
device 3 device3
device 4 device4
device 5 device5
device 6 device6
device 7 device7
device 8 device8
device 9 device9
device 10 device10
device 11 device11
device 12 device12
device 13 device13
device 14 device14
device 15 device15
device 16 device16
device 17 device17
device 18 device18
device 19 device19
device 20 device20
device 21 device21
device 22 device22
device 23 device23
device 24 device24
device 25 device25
device 26 device26
device 27 device27
device 28 device28
device 29 device29

# types
type 0 device
type 1 host
type 2 root

# hosts
host host0 {
	id -1
	alg straw
	hash 0
	item device0 weight 1.000
	item device1 weight 1.000
	item device2 weight 1.000
	item device3 weight 1.000
}
host host1 {
	id -2
	alg straw
	hash 0
	item device4 weight 1.000
	item device5 weight 1.000
	item device6 weight 1.000
	item device7 weight 1.000
}
host host2 {
	id -2
	alg straw
	hash 0
	item device8 weight 1.000
	item device9 weight 1.000
}
host host3 {
	id -2
	alg straw
	hash 0
	item device10 weight 1.000
	item device11 weight 1.000
}
host host4 {
	id -2
	alg straw
	hash 0
	item device12 weight 1.000
	item device13 weight 1.000
}
host host5 {
	id -2
	alg straw
	hash 0
	item device14 weight 1.000
	item device15 weight 1.000
}
host host6 {
	id -2
	alg straw
	hash 0
	item device16 weight 1.000
	item device17 weight 1.000
}
host host7 {
	id -2
	alg straw
	hash 0
	item device18 weight 1.000
	item device19 weight 1.000
}
host host8 {
	id -2
	alg straw
	hash 0
	item device20 weight 1.000
	item device21 weight 1.000
	item device22 weight 1.000
	item device23 weight 1.000
}
host host9 {
	id -2
	alg straw
	hash 0
	item device24 weight 1.000
	item device25 weight 1.000
}
host host10 {
	id -2
	alg straw
	hash 0
	item device26 weight 1.000
	item device27 weight 1.000
}
host host11 {
	id -2
	alg straw
	hash 0
	item device28 weight 1.000
	item device29 weight 1.000
}
root root {
	id -16
	alg straw
	hash 0
	item host0 weight 4.000
	item host1 weight 4.000
	item host2 weight 2.000
	item host3 weight 2.000
	item host4 weight 2.000
	item host5 weight 2.000
	item host6 weight 2.000
	item host7 weight 2.000
	item host8 weight 4.000
	item host9 weight 2.000
	item host10 weight 2.000
	item host11 weight 2.000
}

# rules
rule data {
	ruleset 1
	type replicated
	min_size 2
	max_size 2
	step take root
	step chooseleaf firstn 0 type host
	step emit
}
rule metadata {
	ruleset 1
	type replicated
	min_size 2
	max_size 2
	step take root
	step chooseleaf firstn 0 type host
	step emit
}
rule casdata {
	ruleset 1
	type replicated
	min_size 2
	max_size 2
	step take root
	step chooseleaf firstn 0 type host
	step emit
}
rule rbd {
	ruleset 1
	type replicated
	min_size 2
	max_size 2
	step take root
	step chooseleaf firstn 0 type host
	step emit
}

# end crush map

--=-5xvPBSXoaCFzW+6u39EK--

