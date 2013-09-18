From: Rutger ter Borg <rutger@terborg.net>
Subject: Rados and user-provided buffers
Date: Wed, 18 Sep 2013 21:57:55 +0200
Message-ID: <l1d0jr$jqa$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43430 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430Ab3IRT6G (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Sep 2013 15:58:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1VMNsz-0006p8-OA
	for ceph-devel@vger.kernel.org; Wed, 18 Sep 2013 21:58:05 +0200
Received: from 77-173-143-102.ip.telfort.nl ([77.173.143.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 18 Sep 2013 21:58:05 +0200
Received: from rutger by 77-173-143-102.ip.telfort.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 18 Sep 2013 21:58:05 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Dear all,

I've a question regarding buffers in rados (using the C++ API). I'm 
allocating and using my own buffers, and would like to read and write 
directly into and from them. I'm using a bufferlist consisting of 
static_buffers, which are passed to Rados' aio_read and aio_write.

For aio_write, rados works as expected, i.e., the bufferlist is returned 
as it was before the call. However, when doing aio_read, it seems that 
the bufferlist is destroyed (not used) in the call, despite all the 
buffers being static.

Is this expected behaviour? I read a thread "read/write on RADOS using 
external buffer" from this mailing list from 2010, but wasn't able to 
figure out whether rados does or doesn't support reading into 
user-provided static_buffers.

Thanks in advance,
Cheers,

Rutger



