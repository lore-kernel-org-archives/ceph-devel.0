From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: RE: bitmap allocator granularity
Date: Wed, 7 Sep 2016 06:02:47 +0000
Message-ID: <BLUPR0201MB18093BA9C03CA8CE6F7FDC3985F80@BLUPR0201MB1809.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1609061922340.31624@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0043.outbound.protection.outlook.com ([104.47.40.43]:8880
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750856AbcIGGSa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Sep 2016 02:18:30 -0400
In-Reply-To: <alpine.DEB.2.11.1609061922340.31624@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

Thanks for root causing this and pin pointing the problem.

In my opinion keeping it persistent is good way to go.

This is because min_alloc_size is the unit that allocator has to guarantee =
that it will allocate contiguous.

If we store something else smaller (block size) in allocator, then we might=
 end up searching for N contiguous bits every time even for single unit all=
ocation.

This might happen in any case but aligning it to min_alloc_size will at lea=
st avoid it in good configurations.

Also in some misconfiguration where block size is very small,  the allocato=
r might take more memory even if minimum allocation unit is larger.

I assume that min_alloc_size is not something that will change too frequent=
ly in lifetime of OSD and we have to just make sure it works so whatever yo=
u suggested for persisting minimum min_alloc_size will work.
It can be stored in superblock or with Freelist manger metadata during moun=
t and unmount time?

If you suggest I can do these changes?

-Ramesh


> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Wednesday, September 07, 2016 12:57 AM
> To: Ramesh Chander; ceph-devel@vger.kernel.org
> Subject: bitmap allocator granularity
>
> Hi Ramesh,
>
> It looks like fsck error I've been chasing on my branch is a general prob=
lem
> with the bitmap granularity.  The
> ObjectStore/StoreTest.SyntheticMatrixCsumVsCompression/2 test sets
> min_alloc_size to 32k and then to something smaller after that.  My branc=
h
> adds an occasional umount+fsck+mount to the synthetic workload test that
> uncovers a problem: if we start with a small min_alloc_size, write some
> objects, and then umount and remount with a larger min_alloc_size (say,
> 32k), things can go wrong.  The allocator defines its bits in terms of
> min_alloc_size, but some used extents are smaller than that, and when the=
y
> get released we trigger an assert like
>
> /home/sage/src/ceph/src/os/bluestore/BitMapAllocator.cc: In function 'voi=
d
> BitMapAllocator::insert_free(uint64_t, uint64_t)' thread 7ffb44deb700 tim=
e
> 2016-09-06 15:23:39.055902
> /home/sage/src/ceph/src/os/bluestore/BitMapAllocator.cc: 76: FAILED
> assert(!(off % m_block_size))
>
> There was a related issue with fsck that its used_blcoks bitmap was
> min_alloc_size granularity.
>
> I see two options: we can either unconditionally maintain the bitmap in
> block_size units, or we can store persistently the smallest min_alloc_siz=
e that
> we have ever mounted with and use that ("min_min_alloc_size?").
>
> What do you think?
> sage
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
