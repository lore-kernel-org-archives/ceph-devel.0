From: Fam Zheng <famz@redhat.com>
Subject: Re: [Qemu-devel] qemu drive-mirror to rbd storage : no sparse rbd
 image
Date: Sat, 11 Oct 2014 15:01:18 +0800
Message-ID: <20141011070118.GB4965@fam-t430.nay.redhat.com>
References: <54c55fc6-b12a-42e5-b99d-9752c8a9b19b@mailpro>
 <749ee402-bce4-45cb-97f2-8946542437fc@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63947 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbaJKHBR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 11 Oct 2014 03:01:17 -0400
Content-Disposition: inline
In-Reply-To: <749ee402-bce4-45cb-97f2-8946542437fc@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ceph Devel <ceph-devel@vger.kernel.org>

On Wed, 10/08 13:15, Alexandre DERUMIER wrote:
> Hi,
> 
> I'm currently planning to migrate our storage to ceph/rbd through qemu drive-mirror
> 
> and It seem that drive-mirror with rbd block driver, don't create a sparse image. (all zeros are copied to the target rbd).
> 
> Also note, that it's working fine with "qemu-img convert" , the rbd volume is sparse after conversion.

What is the source format? If the zero clusters are actually unallocated in the
source image, drive-mirror will not write those clusters either. I.e. with
"drive-mirror sync=top", both source and target should have the same "qemu-img
map" output.

Fam

> 
> 
> Could it be related to the "bdrv_co_write_zeroes" missing features in block/rbd.c ?
> 
> (It's available in other block drivers (scsi,gluster,raw-aio) , and I don't have this problem with theses block drivers).
> 
> 
> 
> Regards,
> 
> Alexandre Derumier
> 
> 
> 
