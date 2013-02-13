From: femi anjorin <femi.anjorin@gmail.com>
Subject: Fwd: optimizing ceph-fuse performance
Date: Wed, 13 Feb 2013 16:26:10 +0100
Message-ID: <CAPhYxPybc7=qbw5_h59yUp=BgCkkd-JfUvX_yoLOHrDiyULuDg@mail.gmail.com>
References: <CAPhYxPzLpw5H9W4LxCaWWeOPRYwVsSJb7h1OgQzswbCMT9S_xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:60852 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758942Ab3BMP0L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 10:26:11 -0500
Received: by mail-ie0-f180.google.com with SMTP id bn7so1788546ieb.25
        for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 07:26:11 -0800 (PST)
In-Reply-To: <CAPhYxPzLpw5H9W4LxCaWWeOPRYwVsSJb7h1OgQzswbCMT9S_xA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Dan Mick <dan.mick@inktank.com>, Joao Eduardo Luis <joao.luis@inktank.com>, Martin B Nielsen <martin@unity3d.com>, Gregory Farnum <greg@inktank.com>

I setup ceph cluster on 28 nodes.
24 nodes for osds...Each storage node has 16 drives.  raid0 on 4
drives. therefore i have 4 osds daemon on each node. each osd daemon
is allocated a raid volume. so total of 96 osds daemon in the entire
cluster.
3 nodes for mon ...
1 node for mds ...
I mounted a share with CEPH-FUSE and im generating load to the cluster
through the mount point.
Network bandwidth is fairly
mon nodes - 20 gb to switch
osd nodes - 1 gb to switch
mds node - 20 gb to switch


Questions:
1. How to optimize the network for better performance
2. Is 1 mds good for this cluster ?
3. How check for replication and what replication factors should be used?
4. What the debug logging configuration should look like?

All the aim is make ceph-fuse give its best in write,read and delete
operations... Pls kindly guide me.

Thanks







---------- Forwarded message ----------



Hi,

Pls can somebody help interprete what this configuration signify.

[global]
        debug ms = 0

[mon]
        debug mon = 20
        debug paxos = 20
        debug auth = 20

[osd]
        debug osd = 20
        debug filestore = 20
        debug journal = 20
        debug monc = 20

[mds]
        debug mds = 20
        debug mds balancer = 20
        debug mds log = 20
        debug mds migrator = 20


 I used the same configuration and my boot disk got full

ceph-mds.a.log =  50299281408
ceph-mon.a.log = 173858816

Moreover the results of my test using ceph-fuse to mount a share and
exportiing the share with samba isn't so good... How can i turn off
some of the logs to optimize ceph performance in a write,read and
delete operations. I will publish the result as soon as i can get the
cluster more optimized.


regards.
