From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Compression implementation options
Date: Mon, 28 Sep 2015 18:41:55 +0300
Message-ID: <56095FC3.5070206@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:36284 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933698AbbI1Pl7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 11:41:59 -0400
Received: by laclj5 with SMTP id lj5so71029820lac.3
        for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 08:41:57 -0700 (PDT)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id h10sm2185642lam.29.2015.09.28.08.41.55
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2015 08:41:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi folks,

Here is a brief summary on potential compression implementation options=
=2E
I think we should choose the desired approach prior to start working on=
=20
the compression feature.

Comments, additions and fixes are welcome.

Compression At Client - compression/decompression to be performed at th=
e=20
client level (most preferably - Rados) before sending/after receiving=20
data to/from Ceph.
     Pros:
         * Ceph cluster isn=E2=80=99t loaded with additional computatio=
n burden.
         * All Ceph cluster components and data transfers benefit from=20
reduce data volume.
         * Compression is transparent to Ceph cluster components
     Cons:
         * Weak clients can lack CPU resources to handle their traffic.
         * Any Read/Write access requires at least two sequential=20
requests to Ceph cluster to get data: the first one to retrieve=20
=E2=80=9Coriginal to compressed=E2=80=9C offset mapping for desired dat=
a block, the=20
second one to get compressed data block.
         * Random write access handling is tricky (see notes below).=20
Even more requests to the cluster per single user one might be needed i=
n=20
this case.

Compression At Replicated Pool - compression to be performed at primary=
=20
Ceph entities at Replicated Pool level prior to data replication.
     Pros:
         * Clients benefit from cluster CPU resources utilization.
         * Compression for specific data block is performed at a single=
=20
point only - thus total CPU utilization for Ceph cluster is less.
         * Underlying Ceph components and data transfers benefit from=20
from reduced data volume.
     Cons:
         * Clients that use EC pools directly lack compression unless=20
it=E2=80=99s implemented there too.
         * In two-tier model data compression at cache tier may be=20
inappropriate due to performance reasons. Compression at cache tier als=
o=20
prevents from cache removal when/if needed.
         * Random write access handling is tricky (see notes below).

Compression At Erasure Coded pool - compression to be performed at=20
primary Ceph entities at EC Pool level prior to Erasure Coding.
     Pros:
         * Clients benefit from cluster CPU resources utilization.
         * Erasure Coding =E2=80=9Cinflates=E2=80=9D processed data blo=
ck (up to ~50%).=20
Thus doing compression prior to that reduces CPU utilization.
         * Natural combination with EC means. Compression and EC have=20
similar purposes - save storage space at the cost of CPU usage. One can=
=20
reuse EC infrastructure and design solutions.
         * No need for random write access support - EC pools don=E2=80=
=99t=20
provide that on its own. Thus we can reuse the same approach to resolve=
=20
the issue when needed. Implementation becomes much easier.
         * Underlying Ceph components and data transfers benefit from=20
reduced data volume.
     Cons:
         * Limited applicability - clients that don=E2=80=99t use EC po=
ols lack=20
compression.

Compression At Ceph Filestore entity - compression to be performed by=20
Ceph File Store component prior to saving object data to underlying fil=
e=20
system.
     Pros:
         *Clients benefit from cluster CPU resources utilization.

     Cons:
         * Random write access is tricky (see notes below).
         * From cluster perspective compression is performed either on=20
each replicated block or on a block =E2=80=9Cinflated=E2=80=9D by erasu=
re coding. Thus=20
total Ceph cluster CPU utilization to perform compression becomes=20
considerably higher ( three times increase for replicated pools and ~50=
%=20
one for EC pools).
         * No benefit in reduced data transfers over the net.
         * Recovery procedure caused by OSD down triggers complete data=
=20
set decompression and compression when EC pool used. This might=20
considerably increase CPU usage utilization for recovery process.

Compression Externally at File System - compression to be performed at=20
=46ile Store node by means of underlying file system.
     Pros:
         * Compression is (mostly) transparent to Ceph
         * Clients benefit from cluster CPU resources utilization.
     Cons:
         * File system =E2=80=9Clock-in=E2=80=9D. One can use BTRFS fil=
e system only for=20
now. Its production readiness is questionable.
         * Limited flexibility - compression is a partition/mount point=
=20
property. Hard to have better granularity - on per-pool or per-object.=20
No way to disable compression.
         * From cluster perspective compression is performed either on=20
each replicated block or on a block =E2=80=9Cinflated=E2=80=9D by erasu=
re coding. Thus=20
total Ceph cluster CPU utilization to perform compression becomes=20
considerably higher ( three times increase for replicated pools and ~50=
%=20
one for EC pools).
         * No benefit in reduced data transfers over the net.
         * Recovery procedure caused by OSD down triggers complete data=
=20
set decompression and compression when EC pool used. This might=20
considerably increase CPU usage utilization for recovery process.

Compression Externally at Block Device - compression to be performed at=
=20
=46ile Store node by means of underlying block device that supports inl=
ine=20
data compression.
     Pros:
         * Compression is transparent to Ceph
         * Clients benefit from cluster CPU resources utilization.
     Cons:
         * Production quality solution seems to be absent.
         * Limited flexibility - compression is a partition/mount point=
=20
property. Hard to have better granularity - on per-pool or per-object.=20
No way to disable compression.
         * From cluster perspective compression is performed either on=20
each replicated block or on a block =E2=80=9Cinflated=E2=80=9D by erasu=
re coding. Thus=20
total Ceph cluster CPU utilization to perform compression becomes=20
considerably higher ( three times increase for replicated pools and ~50=
%=20
one for EC pools).
         * No benefit in reduced data transfers over the net.
         * Recovery procedure caused by OSD down triggers complete data=
=20
set decompression and compression when EC pool used. This might=20
considerably increase CPU usage utilization for recovery process.

Notes:
Probably the most troublesome issue brought by compression introduction=
=20
is random write access handling. Please note that  Its brief overview i=
s=20
as follows:
Compressing entity processes original data blocks for a specific object=
=20
and eventually saves a set of new compressed blocks to the storage.=20
Since different blocks can have different compression ratio new block=20
are variable in size. When a new write request for specific data range=20
overlapping existing data comes from the client one needs to save=20
resulting compressed block some way. Again due to different compression=
=20
ratio new block may not fit into the space allocated for the previous=20
one. Moreover if new write request isn=E2=80=99t aligned with the origi=
nal one=20
we might face the case when previous block is invalidated partially.
Thus the flat and sequential object data keeping model doesn=E2=80=99t =
work any=20
more.
Instead one needs to introduce some trick scheme to store, access and=20
overwrite object content. One can find more details on both the issue=20
and potential implementation approach here ( sections I & II):
http://users.ics.forth.gr/~bilas/pdffiles/makatos-snapi10.pdf

Thanks,
Igor.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
