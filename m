From: Lakshminarayana Mavunduri <Lakshminarayana.Mavunduri@sandisk.com>
Subject: Read from clones
Date: Tue, 15 Jul 2014 05:44:19 +0000
Message-ID: <3ADFB25A75C80A4BA0183C65FE86C53404934AB4@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2lp0241.outbound.protection.outlook.com ([207.46.163.241]:19092
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751739AbaGOFoY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jul 2014 01:44:24 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>

Hi,

Following the below set of steps, we are seeing data loss while reading from clones.

1)Create an image with image format 2 (in this case we have made the size to be 1024MB).
        rbd create image1 --size 1024 --image-format 2
2)Map the image and write 1024MB worth of data to it.
3)Create a snapshot for the image created in step 1)
        rbd snap create image1@snap1
4)Create a clone for the snapshot created in step 3)
        rbd clone image1@snap1 clone1
5)Create a snapshot for the clone created in step 4)
        rbd snap create clone1@snap2
6)Create a clone for the snapshot created in step 5)
        rbd clone clone1@snap2 clone2
7)Shrink the size of the clone created in step 4) (in this case we have made it to half of its size)
        rbd resize -s 512 --allow-shrink clone1
8)Map the clone created in step 6) and try reading 1024MB worth of data.
9)Our observation is that, only the first 512MB worth data is intact, the rest is not copied over. (In fact, it's only the parent overlap worth data of clone1 that is always copied over!)

After the above set of steps, the parent overlap for clone2 would be 1024MB, whereas the parent overlap for clone1 would be 512MB. Our understanding is, since clone2's parent snapshot is taken before a shrink is performed on clone1, any reads worth parent overlap data on clone2 should be serviced from it's parent (at least, as long as there are no overwrites done on clone2, which is the case here), and we are not finding that to be true in this case.

To augment our theory, if the parent image (a base RBD image, which is not a clone) is shrinked, any reads on the clones that are created before the shrink, are as expected to our understanding.

Wanted to check if this is indeed a bug or if we are missing anything here. The tests are run across ceph version 0.80.

Thanks,
M.Laks...


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

