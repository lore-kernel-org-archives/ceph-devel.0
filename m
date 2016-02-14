From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] add CephFS support in VirtFS
Date: Sun, 14 Feb 2016 11:31:23 +0530
Message-ID: <874mdbakzw.fsf@linux.vnet.ibm.com>
References: <56C00B60.6000502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:53278 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbcBNGBm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Feb 2016 01:01:42 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <ceph-devel@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Sat, 13 Feb 2016 23:01:42 -0700
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4B17F19D8045
	for <ceph-devel@vger.kernel.org>; Sat, 13 Feb 2016 22:49:37 -0700 (MST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u1E61SFL36372556
	for <ceph-devel@vger.kernel.org>; Sun, 14 Feb 2016 06:01:28 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u1E61RBr019739
	for <ceph-devel@vger.kernel.org>; Sun, 14 Feb 2016 01:01:27 -0500
In-Reply-To: <56C00B60.6000502@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, qemu-devel@nongnu.org
Cc: mst@redhat.com, gkurz@linux.vnet.ibm.com, Sage Weil <sage@newdream.net>, gfarnum@redhat.com, haomaiwang@gmail.com


> diff --git a/hw/9pfs/virtio-9p.c b/hw/9pfs/virtio-9p.c
> index f972731..385c01d 100644
> --- a/hw/9pfs/virtio-9p.c
> +++ b/hw/9pfs/virtio-9p.c
> @@ -1326,7 +1326,7 @@ out_nofid:
>   static int32_t get_iounit(V9fsPDU *pdu, V9fsPath *path)
>   {
>       struct statfs stbuf;
> -    int32_t iounit = 0;
> +    int32_t iounit = 0, unit = 0;
>       V9fsState *s = pdu->s;
>
>       /*
> @@ -1334,8 +1334,21 @@ static int32_t get_iounit(V9fsPDU *pdu, V9fsPath 
> *path)
>        * and as well as less than (client msize - P9_IOHDRSZ))
>        */
>       if (!v9fs_co_statfs(pdu, path, &stbuf)) {
> -        iounit = stbuf.f_bsize;
> -        iounit *= (s->msize - P9_IOHDRSZ)/stbuf.f_bsize;
> +    /*
> +     * If host filesystem block size is larger than client msize,
> +     * we will use AGESIZE as the unit. The reason why we choose
> +     * AGESIZE is because the data will be splitted in terms of
> +     * AGESIZE in the virtio layer. In this case, the final
> +     * iounit is equal to the value of ((msize/unit) - 1) * unit.
> +     */
> +    if (stbuf.f_bsize > s->msize) {
> +        iounit = 4096;
> +        unit = 4096;
> +    } else {
> +            iounit = stbuf.f_bsize;
> +        unit = stbuf.f_bsize;
> +    }
> +        iounit *= (s->msize - P9_IOHDRSZ)/unit;
>       }
>       if (!iounit) {
>           iounit = s->msize - P9_IOHDRSZ;
> --


Can you split this out as a separate patch ?. Also explain what is
AGESIZE.

-aneesh

