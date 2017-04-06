From: Sage Weil <sage@newdream.net>
Subject: Re: Sparse file info in filestore not propagated to other OSDs
Date: Thu, 6 Apr 2017 13:55:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704061353070.2999@piezo.novalocal>
References: <beaf4408-2322-b0f1-3265-0d9e411c5bf9@corp.ovh.com> <alpine.DEB.2.11.1704061322330.2999@piezo.novalocal> <db761315-61b5-bcac-e9ae-519ae8f769dc@corp.ovh.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-974734899-1491486908=:2999"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40542 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933624AbdDFNzJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Apr 2017 09:55:09 -0400
In-Reply-To: <db761315-61b5-bcac-e9ae-519ae8f769dc@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <piotr.dalek@corp.ovh.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-974734899-1491486908=:2999
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 6 Apr 2017, Piotr Dałek wrote:
> On 04/06/2017 03:25 PM, Sage Weil wrote:
> > On Thu, 6 Apr 2017, Piotr Dałek wrote:
> > > Hello,
> > > 
> > > We recently had an interesting issue with RBD images and filestore on
> > > Jewel
> > > 10.2.5:
> > > We have a pool with RBD images, all of them mostly untouched (large areas
> > > of
> > > those images unused), and once we added 3 new OSDs to cluster, objects
> > > representing these images grew substantially on new OSDs: objects hosting
> > > unused areas of these images on original OSDs remained small (~8K of space
> > > actually used, 4M allocated), but on new OSDs were large (4M allocated
> > > *and*
> > > actually used). After investigation we concluded that Ceph didn't
> > > propagate
> > > sparse file information during cluster rebalance, resulting in correct
> > > data
> > > contents on all OSDs, but no sparse file data on new OSDs, hence disk
> > > space
> > > usage increase on those.
> > > 
> > > [..]
> > 
> > I think the solution here is to use sparse_read during recovery.  The
> > PushOp data representation already supports it; it's just a matter of
> > skipping the zeros.  The recovery code could also have an option to check
> > for fully-zero regions of the data and turn those into holes as well.  For
> > ReplicatedBackend, see build_push_op().
> 
> Can we abuse that to reduce amount of regular (client/inter-osd) network
> traffic?

Yeah... I wouldn't call it abuse :).  sparse_read() will use 
SEEK_HOLE/SEEK_DATA on filestore (if enabled).  On bluestore we have the 
metadata on-hand.  It may be a bit slower, though... more complexity 
and such.  They recently implemented something like this for the kernel 
NFS server and found it was faster for very sparse files but the rest of 
the time it was a fair bit slower.

sage
--8323329-974734899-1491486908=:2999--
