From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: Multiple disks per server.
Date: Thu, 6 May 2010 04:18:27 +0100
Message-ID: <20100506041827.c1e51f92.ctpm@ist.utl.pt>
References: <4BE01091.7040103@embl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.ist.utl.pt ([193.136.128.21]:43421 "EHLO smtp1.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab0EFD1z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 5 May 2010 23:27:55 -0400
In-Reply-To: <4BE01091.7040103@embl.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?TWlja2HDq2wgQ2Fuw6l2ZXQ=?= <canevet@embl.fr>
Cc: ceph-devel@vger.kernel.org, sage@newdream.net


On Tue, 04 May 2010 14:18:25 +0200 Micka=C3=ABl Can=C3=A9vet <canevet@e=
mbl.fr> wrote:
> Hi,
>=20
> I'm testing ceph on 4 old servers.
>=20
> As there is more then one disk per server available for data (2 with =
6=20
> disks and 2 with 10 disks for a total of 32 disks over 4 nodes), I wa=
s=20
> wondering how to define OSDs.
>=20
> I have choice between one OSD per disk (32 OSDs on the cluster) or on=
e=20
> OSD per server with one btrfs filesystem over all disks of the server=
 (4=20
> OSDs on the cluster). Which one is the best solution ?
>=20
> In the first case, if I lose one disk, I lose only a small part of=20
> available space. In the other case, if I lose one disk, I lose the wh=
ole=20
> server (as btrfs filesystem is in stripping) much more space.

 Hi,

 I too am facing a similar dilemma:

 Scenario 1:
 I can set up an MD raid6 array for each OSD box and so can afford up
to 2 simultaneous disk failures without Ceph noticing anything wrong.
When the 3rd drive fails, a long time will be spent redistributing data
across the cluster (though much less time than a simple 25TB raid6
rebuild) . This setup should be quite simple, and a 16 disk raid6
should give generally nice performance, though. I probably would use
2-way data replication (on Ceph config.) for this case.

 Scenario 2:

 I can try to configure 1 OSD per disk. As soon as a drive fails, there
will be data redistribution across the remaining OSDs - but this should
be quite fast, as only the content of a single drive (or slightly more)
has to be redistributed across the cluster (worst case). In this case I
would use 3-way replication for added protection against simultaneous
double drive failures and to compensate for the OSDs not having a raid
array underneath them.

 I can see several potential advantages in "Scenario 2":

 * Greater simplicity and ease of administration, as there's no need to
worry about RAID arrays, their configuration and their possible bugs.
You have one less layer in the stack to worry about, and that has to be
good news.

 * You can replace failed drives with different drives without worrying
about wasted capacity because they are bigger (as you would on raid),
and you can even take advantage of older, smaller drives that would
otherwise go to the trash can. This will give greater liberty when
upgrading hardware, overall.

 * Degradation of available cluster capacity and bandwidth would be
much softer. In fact, assuming that you don't have many power supplies
or mainboards burning up, your cluster will maintain redundancy as
drives go failing. That is, as long as you have more drives than
(amount_of_data * replication_level) your cluster will probably be in a
good, fully redundant state. That should make for better sleep at night=
=2E

 * Workloads with small, spread writes should perform better. In a RAID
array those could cause entire stripes to be read, thus requiring data
chunks to be read from a lot of disks just to compute the redundancy
chunks. This one should be quite an advantage for big mail server
workloads, which is one of the workloads I'm interested in.

 * Large write performance should be no worse than with raid, since Cep=
h
also spreads chunks across OSDs.


 Having said that, there are some aspects about how Ceph would behave
in Scenario 2 that I still have to investigate:

 * If multiple OSDs per node is a well suported option. Do multiple OSD=
s
per node play well with each other and with a node's resources?

 * If there are issues with network ports/addresses when setting up mor=
e
than 1 OSD per node.

 * OSD behaviour when getting I/O errors from its drive -- this is
really the most complex and important one, and the one I wish I could
hear your opinions about:

  Usually, in a RAID array, when there is a fatal failure, the upper
layers will just get permanent I/O errors and you can assume that
storage area is dead and go on with life.
 However, this is frequently not true when you consider single drives
as in Scenario 2, at least for reads: the drive may return read errors
for a small region but still be quite ok for the remaining data.

 So, ideally, a Ceph OSD receiving a read error from the filesystem
would request a copy of the Object in question from another OSD and try
to rewrite it several times before giving up and declaring the drive
dead (1). This is actually what Linux MD does on recent kernels and I
know from my experience that it increases array survivability a lot.
 Background data scrubbing would help a lot with the above, and I guess
BTRFS checksuming will simplify things here.


 Sorry for the huge email, but I hope that what I wrote are valid
points to make Ceph more robust, and hope to know what you think about
them.

Notes:
  (1) Better yet, if the error repeats, it could leave the old backing
file alone, and try to alloc a new one for that object, thus avoiding
declaring the drive completely dead too early.

 Best regards and thanks

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
