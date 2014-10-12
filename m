From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: qemu drive-mirror to rbd storage : no sparse rbd image
Date: Sun, 12 Oct 2014 15:02:12 +0200
Message-ID: <543A7BD4.4030601@redhat.com>
References: <54c55fc6-b12a-42e5-b99d-9752c8a9b19b@mailpro> <749ee402-bce4-45cb-97f2-8946542437fc@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:55764 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbaJLNC0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Oct 2014 09:02:26 -0400
Received: by mail-wg0-f46.google.com with SMTP id l18so6949634wgh.29
        for <ceph-devel@vger.kernel.org>; Sun, 12 Oct 2014 06:02:25 -0700 (PDT)
In-Reply-To: <749ee402-bce4-45cb-97f2-8946542437fc@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

Il 08/10/2014 13:15, Alexandre DERUMIER ha scritto:
> Hi,
> 
> I'm currently planning to migrate our storage to ceph/rbd through qemu drive-mirror
> 
> and It seem that drive-mirror with rbd block driver, don't create a sparse image. (all zeros are copied to the target rbd).
> 
> Also note, that it's working fine with "qemu-img convert" , the rbd volume is sparse after conversion.
> 
> 
> Could it be related to the "bdrv_co_write_zeroes" missing features in block/rbd.c ?
> 
> (It's available in other block drivers (scsi,gluster,raw-aio) , and I don't have this problem with theses block drivers).

Lack of bdrv_co_write_zeroes is why detect-zeroes does not work.

Lack of bdrv_get_block_status is why sparse->sparse does not work
without detect-zeroes.

Paolo
