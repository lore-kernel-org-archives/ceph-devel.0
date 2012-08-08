From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Ceph RBD performance - random writes
Date: Wed, 08 Aug 2012 17:19:13 +1200
Message-ID: <5021F6D1.7000004@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040203020305060703040000"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:40662 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab2HHFTT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Aug 2012 01:19:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 5B71A3300E
	for <ceph-devel@vger.kernel.org>; Wed,  8 Aug 2012 17:19:15 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7+DRmWHU+EN for <ceph-devel@vger.kernel.org>;
	Wed,  8 Aug 2012 17:19:14 +1200 (NZST)
Received: from [IPv6:2404:130:0:1000:69c0:b106:4686:27e5] (unknown [IPv6:2404:130:0:1000:69c0:b106:4686:27e5])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 17BBB32EBA
	for <ceph-devel@vger.kernel.org>; Wed,  8 Aug 2012 17:19:14 +1200 (NZST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040203020305060703040000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've been looking at using Ceph RBD as a block store for database use. 
As part of this I'm looking a how (particularly random) IO of smallish 
(4K, 8K) block sizes performs.

I've setup Ceph with a single osd and mon spread over two SSD (Intel 
520) - 2G journal on one and the osd data on the other (xfs filesystem). 
The Intel's are pretty fast, and (despite being shackled by a crappy 
Nvidia SATA controller) fly for random IO.

However I am not seeing that reflected in the RBD case. I have the 
device mounted on the local machine where the osd and mon are running 
(so network performance should not be a factor here).

Here is what I did:

Create a rbd device of 10G and mount on /mnt/vol0:

$ rbd create --size 10240 vol0
$ rbd map vol0
$ mkfx.xfs /dev/rbd0
$ rbd mount /dev/rdb0 /mnt/vol0

Make a file:

$ dd if=/dev/zero of=/mnt/vol0/dump/file bs=4k count=300000 conv=fsync
1228800000 bytes (1.2 GB) copied, 13.4361 s, 91.5 MB/s

Performance ok if file size < journal (2G).

$ dd if=/dev/zero of=/mnt/vol0/dump/file bs=4096k count=200 conv=fsync
838860800 bytes (839 MB) copied, 9.47086 s, 88.6 MB/s

Not so good if file size > journal.

$ dd if=/dev/zero of=/mnt/vol0/dump/file bs=4096k count=1000 conv=fsync
4194304000 bytes (4.2 GB) copied, 279.891 s, 15.0 MB/s

Random writes (see attached file) sync'ed with sync_file_range are ok if 
block size big:

$ ./writetest /mnt/vol0/dump/file 4194304 0 1
random writes: 292 of: 4194304 bytes elapsed: 9.8397s io rate: 30/s 
(118.70 MB/s)

$ ./writetest /mnt/vol0/dump/file 1048576 0 1
random writes: 1171 of: 1048576 bytes elapsed: 10.6042s io rate: 110/s 
(110.43 MB/s)

$ ./writetest /mnt/vol0/dump/file 131072 0 1
random writes: 9375 of: 131072 bytes elapsed: 15.8075s io rate: 593/s 
(74.13 MB/s)


However smallish block size is suicide (trigger suicide assert after a 
while), I see 100 IOPS or less on actual devices, all 100% util:

$ ./writetest /mnt/vol0/dump/file 8192 0 1

I am running into http://tracker.newdream.net/issues/2784 here I think.

Note that the actual SSD are very fast for this when accessed directly:

$ ./writetest /data1/ceph/1/file 8192 0 1
random writes: 1000000 of: 8192 bytes elapsed: 125.7907s io rate: 7950/s 
(62.11 MB/s)


Thanks for your patience in reading so far - some actual questions now :-)

1/ Why is the appending write from dd when the size of file > journal so 
slow, despite reasonably capable storage devices?

2/ Is the sudden dramatic drop in random write performance a 
manifestation of the "small requests  are slow" issue? or is this 
something else?


Thanks

Mark



--------------040203020305060703040000
Content-Type: application/x-gzip;
 name="ceph.conf.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ceph.conf.gz"

H4sICFjxIVAAA2NlcGguY29uZgB9Vu9v2zYQ/Rz9FTdgwFbA849kaLoY/tA1wJYPRYc2Q1EU
gUGJJ4sLJQokZcf76/eOkh05SxIDkUXy3t29u3v0MlvSLYdomg0V3Fbp37RwTUmlsTzNljjw
lUk7alwkzaVpmGodJqQCucbuqQti7HMth3F6Y12ubPa9f95lNPwtSVnrduQ6H9huOVB05Fpu
SJEFtutdhqNBrR76/bRMK1pcLOaX59kIMXCE7SadOC4fFmAx2yo/w/tM0pr92Kiap3gdIeBt
Hd067IOYrSj6jh93u6Zwdc1NpFiZQFaSR9RyFI/e6Gk8XUut0U9yOawcYvJdM44J22OYm5L2
rqOdEseOcBgc3fy1fUuF7UJkP0meUkzYl5indN0p+0uIqrgnE5qfIrUuBJOPiFnWgXLTaDIt
oPpcpWK1a0x0PuArfYPfhlmTArOsAurSAPyZ9Vh5ZjInoQpCdJa9ikyq2aNpNFOpjO08B8C8
tzu1D1R47k+Q05qars7ZT7PvCOSxX/BCWkUllMlz0RM27yl7hi7leWjG0nniB1W3IDxWTJ/f
X3/6Qn/AJbzDqz5SW6kti7FHcjs0cx+YHoG3ztkA+iuzqdiT59aaQkWD6Cxv2U6S7wKpSEmU
jIjqbDwiuKATxmGDgvlX2mAxzuDbAKFsQFu1XJgScdKHz39/+RPlRxqSEkLswxlZfjX35oqq
GNurWSJoilMaWdT4Emc7bM8+oGdcvRYS161VBUtHr3cmVuvk4eVYC9+Fqg9gRfNxxLemFqaN
1NJEMGJTiIdWmlDexSfNMcy/FKSwrrhPvau9KUHbCDk3ETCeR8QOhIiliEKymY7aGrVIiAc0
8YNWfULyLVvbY/RBivsc4+JKKI93dT9PO+WbQw9dzFFUiKEOLzuT80eYFUyy7CzJygYokwSj
Oe/S69Fz4VWoGCwZTIDX6CtXihmiMx4yc8/WVM5pEcWcxbJi25adpas3OJcAqU6a+PiKwFZ0
Pj8utOrBhdMl1cWqX0nDNt2yxgAUd9lZ5TDSKxoWsjNBU1p7cXF+OZ3js7h6e/nut0wUA43y
mljc7txJ7dMYC9t8nB+W64Lour9QcJfUIhd4ipEQADmAlzth5VbqIqXBAPYDnUdfBto629VM
O4O65lLWrkm4Z9LHr0kHMG80o032E/i9577yCsVuVZIubcI9CgMKfTQy6yJdVPIuI9hWXYMJ
0/TxdwqV66wW79y4blMtU+sekk/qUiZefEowmQt4GCRV2rsLIKC/HQCMXpAMjyloNATgEs05
J4CfebqZ9pn1Gc3+gYI1yr4Zxi4eOQkyCYIo4pKMX8lxPCwnvAn56IeZ5u0s6OJ8kmJeIC8x
liZ1UcQxIGhp+CGcH/pKDG+pGAkgX5xuDIp4Pv/1HTyPV9OA1LxR+T7iNn39ihTaDsbSvRTr
tsSMIVGFa5Cujeci3nx6RDmc1sbBfwn15edUuQB7m77x+qtKMgaW27Lfy08Un+6DpGfQKhQK
vwEO+yM8MCP1kPpot2uGLpHOKCpMQRBnuLfhTSNcE8emoOvoUTRQFdFshbWL1M6yP2hOUtU0
7bJoQuieCM1z+iIYg8S8pC+CdiIm6RdOlHY/WX4sd5IZmE3n/xeY7D9ISgBpegoAAA==
--------------040203020305060703040000
Content-Type: application/x-gzip;
 name="writetest.c.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="writetest.c.gz"

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
--------------040203020305060703040000--
