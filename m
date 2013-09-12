From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: still crashes with tapdisk rbd
Date: Thu, 12 Sep 2013 23:50:02 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B664E7BDE@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B664DF854@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1309120726120.23229@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:46680 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834Ab3ILXuN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Sep 2013 19:50:13 -0400
In-Reply-To: <alpine.DEB.2.00.1309120726120.23229@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> There isn't a simple magic string I can point to except for struct
> ceph_msg_header, but I doubt that will help, since it is reading the
> headers and message bodies into different buffers.

Ok thanks.

> I forget: are you able
> to reproduce any of this with debugging enabled?  I would suggest adding
> pointers to the debug statements in msg/Pipe.cc to narrow down what is
> using some of this memory.

I'll have a look. gdb is useless as it crashes most of the time and when it doesn't it doesn't give me a stack trace. The only way I can do anything is via another machine running a newer gdb (debian Jessie instead of Wheezy), but even then it still gets confused about threads sometimes.

> You might also want to just look at read_message, connect, and accept in
> Pipe.cc as I think those are the only places where data is read off the
> network into a buffer/struct on the stack.
> 

Thanks for the pointers.

James
