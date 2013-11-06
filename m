From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: CephFS use cases + MDS limitations
Date: Wed, 6 Nov 2013 11:59:14 -0500 (EST)
Message-ID: <1831866980.60.1383757154859.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1404675857.58.1383757057746.JavaMail.root@thunderbeast.private.linuxbox.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1053 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab3KFQ7T convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Nov 2013 11:59:19 -0500
In-Reply-To: <1404675857.58.1383757057746.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Sevilla <mikesevilla3@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Michael,

Thanks for posting this.

We don't have specific workload information, but we did want to mention=
 some of
the experimental Cephfs development we (Cohortfs) have been doing, in c=
ase it
might be of interest to others in the community.

One of the projects we've undertaken is to implement pnfs-metastripe
(a proposal for scale-out metadata in NFSv4) on Cephfs.  In doing that =
we've
essentially been evolving a metastripe-flavored version Cephfs, buildin=
g on
previous work to provide first-class lookup-by-inode# support (more bel=
ow).

Our current codebase has a number of changes.

In support of metastripe, we've augmented directory fragmentation with =
the
concept of stripes, each of which can be locked and modified independen=
tly.
In order to permit parallel updates on stripes, clients take "stripe ca=
ps" in
place of a single capset on directories.

We've also extended the Ceph cap model to support in-place state update=
s, as
well as invalidates.

We have a group of changes intended to increase mds workload independen=
ce,
including more independent caching.

There are many cases where a ceph mds needs to get a cache replica of a=
n object
from its auth mds. Most are needed in order to satisfy a client request=
 (like a
rename from one mds to another).  Many others, however, are necessitate=
d by the
reliance on full paths  to locate objects.  This means that every cache=
 object
must then have cache replicas of all parent objects in order to make th=
ese
traversals possible.  These extra cache replicas have a cost in terms o=
f memory,
lock latency, and messaging overhead that will have an effect on scalab=
ility.

All of these overheads are essentially side effects of Ceph's method of=
 storing
inodes with their primary dentry.  We're attacking this by storing inod=
es in a
separate container, which is also striped across MDS nodes to enable
lookup-by-ino with a simple placement function. Obviously, the former d=
esign
change is a big one, which trades away some of the Cephfs' inlining pro=
perties
for parallel performance and better NFS tuning.

We have other client and MDS work planned and/or in progress, including=
 client
concurrency work (in progress), MDS concurrency work (planned), MDS cac=
he management
changes (planned), and client cache management changes (in progress).

We're looking to add the ability to journal inode updates as deltas, in=
 order
to compress the journals and speed up replay. Further down the line, we=
'd like
to create a journal for each stripe of the inode container (where strip=
e count
>> mds count), rather than tying them to an individual mds. This would
facilitate load balancing and failover, by allowing any mds to become
authoritative for a stripe of inodes by replaying its journal.

One of our main goals is for a plurality of Cohortfs (and Cephfs) file =
systems
to coexist in a Ceph cluster, in separate or unified namespaces.

So, in fine, our Cohortfs version of Cephfs makes some tradeoffs that w=
e expect
to perform better on some workloads, and perhaps worse on others, but s=
ome of the
work we've performed may also be useful to traditional Cephfs.

We've been working entirely on our own so far, but we're doing open sou=
rce work.
We welcome feedback, and if there are others in the community intereste=
d in
collaborating in these or related areas, you're welcome to join in.

Matt, Casey, Adam, Marcus

----- "Michael Sevilla" <mikesevilla3@gmail.com> wrote:

> Hi Ceph community,
>=20
> I=E2=80=99d like to get a feel for some of the problems that CephFS u=
sers are
> encountering with single MDS deployments. There were requests for
> stable distributed metadata/MDS services [1] and I=E2=80=99m guessing=
 its
> because your workloads exhibit many, many metadata operations. Some
> of
> you mentioned opening many files in a directory for checkpointing,
> recursive stats on a directory, etc. [2] and I=E2=80=99d like more de=
tails,
> such as:
> - workloads/applications that stress the MDS service that would cause
> you to call for multi-MDS support
> - use cases for the Ceph file system (I=E2=80=99m not really too inte=
rested
> in
> users using CephFS to host VMs, since many of these use cases are
> migrating to RBD)
>=20
> I=E2=80=99m just trying to get an idea of what=E2=80=99s out there an=
d the problems
> CephFS users encounter as a result of a bottlenecked MDS (single node
> or cluster).
>=20
> Thanks!
>=20
> Michael
>=20
> [1] CephFS MDS Status Discussion,
> http://ceph.com/dev-notes/cephfs-mds-status-discussion/
> [2] CephFS First Product Release Discussion,
> http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/13524
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689=20
fax.  734-769-8938=20
cel.  734-216-5309=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
