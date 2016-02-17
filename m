From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] hw/9pfs: fix alignment issue when host filesystem
 block size is larger than client msize
Date: Wed, 17 Feb 2016 11:24:19 +0100
Message-ID: <20160217112419.62c49792@bahia.huguette.org>
References: <56C02E4F.6030303@gmail.com>
	<87y4an8l93.fsf@linux.vnet.ibm.com>
	<56C41DE8.2030904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:56641 "EHLO
	e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933325AbcBQKY3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Feb 2016 05:24:29 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <ceph-devel@vger.kernel.org> from <gkurz@linux.vnet.ibm.com>;
	Wed, 17 Feb 2016 10:24:27 -0000
In-Reply-To: <56C41DE8.2030904@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, qemu-devel@nongnu.org, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, mst@redhat.com, sage@newdream.net, gfarnum@redhat.com, haomaiwang@gmail.com

On Wed, 17 Feb 2016 15:14:48 +0800
Jevon Qiao <scaleqiao@gmail.com> wrote:

> Hi Aneesh,
> 
> Thank you for reviewing my code, please see my reply in-line.

Jevon,

Please read comments below.

> On 14/2/16 21:38, Aneesh Kumar K.V wrote:
> > Jevon Qiao <scaleqiao@gmail.com> writes:
> >  
> >> The following patch is to fix alignment issue when host filesystem block
> >> size
> >> is larger than client msize.
> >>
> >> Thanks,
> >> Jevon  
> > That is not the right format to send patch. You can send them as a
> > series using git-send-email.  
> Yes, you're correct. I will send the patches later after I address all 
> the technical comments.
> >> From: Jevon Qiao <scaleqiao@gmail.com>
> >> Date: Sun, 14 Feb 2016 15:11:08 +0800
> >> Subject: [PATCH] hw/9pfs: fix alignment issue when host filesystem block
> >> size
> >>    is larger than client msize.
> >>
> >> Per the previous implementation, iounit will be assigned to be 0 after the
> >> first if statement as (s->msize - P9_IOHDRSZ)/stbuf.f_bsize will be zero
> >> when
> >> host filesystem block size is larger than msize. Finally, iounit will be
> >> equal
> >> to s->msize - P9_IOHDRSZ, which is usually not aligned.
> >>
> >> Signed-off-by: Jevon Qiao <scaleqiao@gmail.com>
> >> ---
> >>    hw/9pfs/virtio-9p.c | 19 ++++++++++++++++---

Hmmm I just realize your tree is not up-to-date since hw/9pfs/virtio-9p.c got
renamed with this recent commit:

commit 60ce86c7140d5ca33d5fd87ce821681165d06b2a
Author: Wei Liu <wei.liu2@citrix.com>
Date:   Thu Jan 7 18:42:20 2016 +0000

    9pfs: rename virtio-9p.c to 9p.c

Also 9p.c only contains generic code now, not related to virtio... see below.

> >>    1 file changed, 16 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/9pfs/virtio-9p.c b/hw/9pfs/virtio-9p.c
> >> index f972731..005d3a8 100644
> >> --- a/hw/9pfs/virtio-9p.c
> >> +++ b/hw/9pfs/virtio-9p.c
> >> @@ -1326,7 +1326,7 @@ out_nofid:
> >>    static int32_t get_iounit(V9fsPDU *pdu, V9fsPath *path)
> >>    {
> >>        struct statfs stbuf;
> >> -    int32_t iounit = 0;
> >> +    int32_t iounit = 0, unit = 0;
> >>        V9fsState *s = pdu->s;
> >>
> >>        /*
> >> @@ -1334,8 +1334,21 @@ static int32_t get_iounit(V9fsPDU *pdu, V9fsPath
> >> *path)
> >>         * and as well as less than (client msize - P9_IOHDRSZ))
> >>         */
> >>        if (!v9fs_co_statfs(pdu, path, &stbuf)) {
> >> -        iounit = stbuf.f_bsize;
> >> -        iounit *= (s->msize - P9_IOHDRSZ)/stbuf.f_bsize;
> >> +    /*
> >> +     * If host filesystem block size is larger than client msize,
> >> +     * we will use PAGESIZE as the unit. The reason why we choose
> >> +     * PAGESIZE is because the data will be splitted in terms of
> >> +     * PAGESIZE in the virtio layer. In this case, the final

... and here you mention virtio. Does this code really belong here ?

> >> +     * iounit is equal to the value of ((msize/unit) - 1) * unit.
> >> +     */
> >> +    if (stbuf.f_bsize > s->msize) {
> >> +        iounit = 4096;
> >> +        unit = 4096;  

This looks weird when reading the initial comment in get_iounit()... is
iounit a multiple of stbuf.f_bsize in this case ?

> > What page size it should be guest or host ?. Also why 4096 ?. ppc64 use
> > 64K page size.  
> The data to be read or written will be divided into pieces according to the
> size of iounit and msize firstly, and then mapped to pages before being 
> added
> into virtqueue. Since all these operations happen in the guest side, so the
> page size should be guest. Please correct me if I'm wrong.
> 
> As for the number 4096, It's the default value in Linux OS. I did not take
> other platforms into account, it's my fault. To make it suitable for all 
> platforms,
> shall I use the function getpagesize() here?
> 

getpagesize() will return the host page size. If you need the guest page size,
you should use TARGET_PAGE_SIZE.

And then you will hit another problem: the 9p.c file is in common-obj and
cannot contain target specific code...

Along with the other remark, I'm beginning to think you may need to move this
to virtio-9p-device.c.

> Thanks,
> Jevon
> >> +    } else {
> >> +            iounit = stbuf.f_bsize;
> >> +        unit = stbuf.f_bsize;
> >> +    }
> >> +        iounit *= (s->msize - P9_IOHDRSZ)/unit;
> >>        }
> >>        if (!iounit) {
> >>            iounit = s->msize - P9_IOHDRSZ;
> >> --   
> > -aneesh
> >  
> 

