From: ales-76@seznam.cz
Subject: =?us-ascii?Q?Re=3A=20how=20to=20install=20a=20cloud=20storage=20network=20=3Awhich=20is=20best=20smart=20automatic=20file=20replication=20solution=20for=20cloud=20storage=20based=20systems=2E?=
Date: Fri, 28 May 2010 10:11:39 +0200 (CEST)
Message-ID: <6159.152.1373-530-1901103025-1275034298@seznam.cz>
References: <AANLkTilC2wJJvaZlJgLvCRm3cOenq4Pt2S0d_y49L-N7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxh.seznam.cz ([77.75.72.26]:59068 "EHLO mxh.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001Ab0E1I0l (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 May 2010 04:26:41 -0400
In-Reply-To: <AANLkTilC2wJJvaZlJgLvCRm3cOenq4Pt2S0d_y49L-N7@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?TWV0aW4gQWt5YWzEsW==?= <metin.akyali@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hello Metin,

> Problem is, some files can be demanded much more than other files. And
> we cant replicate every file on other nodes, the cost would increase
> exponentialy.

If you really need selective replication take a look at MooseFS. It is open source, 
posix compliant, runs entirely in user space (both client and servers) and it is production ready. 
The architecture is similar to Ceph or GoogleFS - metadata server and bunch of storage nodes.
You can use just about any unix as a host OS. Clients need FUSE.

> So i need a cloud based system, which will push the files into
> replicated nodes automatically when demanded to those files are high,
> and when the demand is low, they will delete from other nodes and it
> will stay in only 1 node.

The replication ratio in MooseFS is set per file or per directory via command line tools (at the client).
Files and subdirectories inherit their replication ratio from parent directory unless you set it otherwise.
Thus your frontend nodes might set the desired replication level per file and then increase or decrease
it as needed. Or you you can create several directories, each one set for certain replication ratio and
then instruct your frontend servers to move the files around depending on their popularity. Big files are sliced
and slices stored (striped) on different nodes to improve aggregate bandwidth.

As to the performance, I had only a small test cluster. Single file read performance over gigabit ethernet
was very much the same as Samba. When reading several files I was able to saturate gigabit connection
at the client. But my cluster was very small (1MDS, 3 OSD), so I cannot really tell how scalable it is.

Regards

Ales Blaha
