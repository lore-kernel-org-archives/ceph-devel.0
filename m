From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: qemu drive-mirror to rbd storage : no sparse rbd image
Date: Wed, 08 Oct 2014 13:15:47 +0200 (CEST)
Message-ID: <749ee402-bce4-45cb-97f2-8946542437fc@mailpro>
References: <54c55fc6-b12a-42e5-b99d-9752c8a9b19b@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50620 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092AbaJHLPz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Oct 2014 07:15:55 -0400
In-Reply-To: <54c55fc6-b12a-42e5-b99d-9752c8a9b19b@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

Hi,

I'm currently planning to migrate our storage to ceph/rbd through qemu drive-mirror

and It seem that drive-mirror with rbd block driver, don't create a sparse image. (all zeros are copied to the target rbd).

Also note, that it's working fine with "qemu-img convert" , the rbd volume is sparse after conversion.


Could it be related to the "bdrv_co_write_zeroes" missing features in block/rbd.c ?

(It's available in other block drivers (scsi,gluster,raw-aio) , and I don't have this problem with theses block drivers).



Regards,

Alexandre Derumier


