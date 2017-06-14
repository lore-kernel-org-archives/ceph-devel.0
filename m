From: Sage Weil <sage@newdream.net>
Subject: Re: Sparse file info in filestore not propagated to other OSDs
Date: Wed, 14 Jun 2017 13:44:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706141340520.3646@piezo.novalocal>
References: <beaf4408-2322-b0f1-3265-0d9e411c5bf9@corp.ovh.com> <alpine.DEB.2.11.1704061322330.2999@piezo.novalocal> <d4bde447-f179-aeca-bac5-636fa40ccba5@corp.ovh.com> <415c9590-ab96-01b6-3c49-553b0d9529fa@sadziu.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1219057633-1497447891=:3646"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53261 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbdFNNow (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 09:44:52 -0400
In-Reply-To: <415c9590-ab96-01b6-3c49-553b0d9529fa@sadziu.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Pawe=B3_Sadowski?= <ceph@sadziu.pl>
Cc: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <piotr.dalek@corp.ovh.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1219057633-1497447891=:3646
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 14 Jun 2017, Paweł Sadowski wrote:
> On 04/13/2017 04:23 PM, Piotr Dałek wrote:
> > On 04/06/2017 03:25 PM, Sage Weil wrote:
> >> On Thu, 6 Apr 2017, Piotr Dałek wrote:
> >>> Hello,
> >>>
> >>> We recently had an interesting issue with RBD images and filestore
> >>> on Jewel
> >>> 10.2.5:
> >>> We have a pool with RBD images, all of them mostly untouched (large
> >>> areas of
> >>> those images unused), and once we added 3 new OSDs to cluster, objects
> >>> representing these images grew substantially on new OSDs: objects
> >>> hosting
> >>> unused areas of these images on original OSDs remained small (~8K of
> >>> space
> >>> actually used, 4M allocated), but on new OSDs were large (4M
> >>> allocated *and*
> >>> actually used). After investigation we concluded that Ceph didn't
> >>> propagate
> >>> sparse file information during cluster rebalance, resulting in
> >>> correct data
> >>> contents on all OSDs, but no sparse file data on new OSDs, hence
> >>> disk space
> >>> usage increase on those.
> >>>
> >>> Example on test cluster, before growing it by one OSD:
> >>>
> >>> ls:
> >>>
> >>> osd-01-cluster: -rw-r--r-- 1 root root 4194304 Apr  6 09:18
> >>> /var/lib/ceph/osd-01-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
> >>>
> >>> osd-02-cluster: -rw-r--r-- 1 root root 4194304 Apr  6 09:18
> >>> /var/lib/ceph/osd-02-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
> >>>
> >>> osd-03-cluster: -rw-r--r-- 1 root root 4194304 Apr  6 09:18
> >>> /var/lib/ceph/osd-03-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
> >>>
> >>>
> >>> du:
> >>>
> >>> osd-01-cluster: 12
> >>> /var/lib/ceph/osd-01-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
> >>>
> >>> osd-02-cluster: 12
> >>> /var/lib/ceph/osd-02-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
> >>>
> >>> osd-03-cluster: 12
> >>> /var/lib/ceph/osd-03-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
> >>>
> >>>
> >>>
> >>> mon-01-cluster:~ # rbd diff test
> >>> Offset   Length  Type
> >>> 8388608  4194304 data
> >>> 16777216 4096    data
> >>> 33554432 4194304 data
> >>> 37748736 2048    data
> >>>
> >>> And after growing it:
> >>>
> >>> ls:
> >>>
> >>> clush> find /var/lib/ceph/osd-*/current/0.*head/ -type f -name
> >>> '*data*' -exec
> >>> ls -l {} \+
> >>> osd-02-cluster: -rw-r--r-- 1 root root 4194304 Apr  6 09:18
> >>> /var/lib/ceph/osd-02-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
> >>>
> >>> osd-03-cluster: -rw-r--r-- 1 root root 4194304 Apr  6 09:18
> >>> /var/lib/ceph/osd-03-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
> >>>
> >>> osd-04-cluster: -rw-r--r-- 1 root root 4194304 Apr  6 09:25
> >>> /var/lib/ceph/osd-04-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
> >>>
> >>>
> >>> du:
> >>>
> >>> clush> find /var/lib/ceph/osd-*/current/0.*head/ -type f -name
> >>> '*data*' -exec
> >>> du -k {} \+
> >>> osd-02-cluster: 12
> >>> /var/lib/ceph/osd-02-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
> >>>
> >>> osd-03-cluster: 12
> >>> /var/lib/ceph/osd-03-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
> >>>
> >>> osd-04-cluster: 4100
> >>> /var/lib/ceph/osd-04-cluster/current/0.27_head/rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0
> >>>
> >>>
> >>> Note that
> >>> "rbd\udata.12a474b0dc51.0000000000000008__head_2DD64767__0" grew
> >>> from 12 to 4100KB when copied from other OSDs to osd-04.
> >>>
> >>> Is this something to be expected? Is there any way to make it
> >>> propagate the
> >>> sparse file info? Or should we think about issuing a "fallocate
> >>> -d"-like patch
> >>> for writes on filestore?
> >>>
> >>> (We're using kernel 3.13.0-45-generic but on 4.4.0-31-generic the issue
> >>> remains; our XFS uses 4K bsize).
> >>
> >> I think the solution here is to use sparse_read during recovery.  The
> >> PushOp data representation already supports it; it's just a matter of
> >> skipping the zeros.  The recovery code could also have an option to
> >> check
> >> for fully-zero regions of the data and turn those into holes as
> >> well.  For
> >> ReplicatedBackend, see build_push_op().
> >
> > So far it turns out that there's even easier solution, we just enabled
> > "filestore seek hole" on some test cluster and that seems to fix the
> > problem for us. We'll see if fiemap works too.
> >
> 
> Is it safe to enable "filestore seek hole", are there any tests that
> verifies that everything related to RBD works fine with this enabled?
> Can we make this enabled by default?

We would need to enable it in the qa environment first.  The risk here is 
that users run a broad range of kernels and we are exposing ourselves to 
any bugs in any kernel version they may run.  I'd prefer to leave it off 
by default.  We can enable it in the qa suite, though, which covers 
centos7 (latest kernel) and ubuntu xenial and trusty.
 
> I tested on few of our production images and it seems that about 30% is
> sparse. This will be lost on any cluster wide event (add/remove nodes,
> PG grow, recovery).
> 
> How this is/will be handled in BlueStore?

BlueStore exposes the same sparseness metadata that enabling the 
filestore seek hole or fiemap options does, so it won't be a problem 
there.

I think the only thing that we could potentially add is zero detection 
on writes (so that explicitly writing zeros consumes no space).  We'd 
have to be a bit careful measuring the performance impact of that check on 
non-zero writes.

sage
--8323329-1219057633-1497447891=:3646--
