From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: debugging librbd async
Date: Wed, 28 Aug 2013 21:40:42 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B664B2BA2@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B66498C5D@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308152206200.1479@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B66498DAD@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308152242310.1479@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B66498EC6@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308160856010.26808@cobra.newdream.net>
  <6035A0D088A63A46850C3988ED045A4B6649D242@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B664B16E7@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:46228 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340Ab3H1Vlc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Aug 2013 17:41:32 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B664B16E7@BITCOM1.int.sbss.com.au>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Sylvain Munaut (s.munaut@whatever-company.com)" <s.munaut@whatever-company.com>

I have set the logfile to be opened with SYNC and that seems to be giving me more consistent output

I see the crash is mostly happening around queue_aio_write. Most of the time the last thing I see is this entry "librados: queue_aio_write 0x7f0928004390 completion 0x1ea65d0 write_seq 147". I've never seen it happen in a read operation. And always where there are lots of writes queued.

From adding further debug statements, I can see that the exact point of the crash is very soon after that but not at a constant point.

I'm thinking that the crash is actually happening somewhere in the callback chain, although definitely before librbd callbacks are invoked as debug prints in the rados end of the callbacks shows nothing.

Where is the 'top' of the callback chain on a write? I can see that librados calls librbd (which then calls the callback in tapdisk), but what calls librados?

Thanks

James

