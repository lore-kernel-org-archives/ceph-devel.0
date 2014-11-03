From: Aanchal Agrawal <Aanchal.Agrawal@sandisk.com>
Subject: RE: optimizing buffers, encode/decode
Date: Mon, 3 Nov 2014 07:52:55 +0000
Message-ID: <7F4FDDF05D5B3241ABA5EB82D169E31E09104D90@SACMBXIP03.sdcorp.global.sandisk.com>
References: <alpine.DEB.2.00.1410290957240.21856@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0060.outbound.protection.outlook.com ([65.55.169.60]:2144
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751106AbaKCHxB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Nov 2014 02:53:01 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>, "Matt W. Benjamin" <matt@linuxbox.com>, Haomai Wang <haomaiwang@gmail.com>

Hi All,

I have used 'Vtune profiler' to profile 4k random write for hotspots, locks-and-waits and hotspots by thread concurrency.

Thought of sharing the results with you guys if it can be of any help.
But attachments are nearly of 1MB and mail-server seems to reject it.

Can anyone tell me how can I share these vtune results?

Thanks,
Aanchal

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Wednesday, October 29, 2014 10:47 PM
To: ceph-devel@vger.kernel.org
Subject: optimizing buffers, encode/decode

We talked a bit about improving the performance encode/decode yesterday at CDS:

        http://pad.ceph.com/p/hammer-buffer_encoding

I think the main takeaways were:

1- We need some up to date profiling information to see

  - how much of it is buffer-related functions (e.g., append)
  - which data types are slowest or most frequently encoded (or otherwise
    show up in the profile)

2- For now we should probably focus on the efficiency of the encode/decode paths.  Possibilities include

  - making more things inline
  - improving the past path

3- Matt and the linuxbox folks have been playing with some general optimizations for the buffer::list class.  These include combining some of the function of ptr and raw so that, for the common single-reference case, we chain the raw pointers together directly from list using the boost intrusive list type, and fall back to the current list -> ptr -> raw strategy when there are additional refs.


For #2, one simple thought would be to cache a pointer and remaining bytes or end pointer into the append_buffer directly in list so that we avoid the duplicate asserts and size checks in the common append (encode) path.
Then a

  ::encode(myu64, bl);

would inline into something pretty quick, like

  remaining -= 8;
  if (remainining < 0) { // take slow path

  } else {
     *ptr = myu64;
     ptr += 8;
  }

Not sure if an end pointer would let us cut out the 2 arithmetic ops or not.  Or if it even matters on modern pipelining processors.

Anyway, any gains we make here will pay dividends across the entire code base.  And any profiling people want to do will help guide things...

Thanks!
sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

