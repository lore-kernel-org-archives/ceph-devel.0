From: Sage Weil <sage@inktank.com>
Subject: Re: still crashes with tapdisk rbd
Date: Thu, 12 Sep 2013 07:31:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309120726120.23229@cobra.newdream.net>
References: <6035A0D088A63A46850C3988ED045A4B664DF854@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54598 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab3ILObB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Sep 2013 10:31:01 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B664DF854@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi James,

On Thu, 12 Sep 2013, James Harper wrote:
> I'm still getting crashes with tapdisk rbd. Most of the time it crashes gdb if I try. When I do get something, the crashing thread is always segfaulting in pthread_cond_wait and the stack is always corrupt:
> 
> (gdb) bt
> #0  0x00007faae20c52d7 in pthread_cond_wait@@GLIBC_2.3.2 () from remote:/lib/x86_64-linux-gnu/libpthread.so.0
> #1  0x00c1c435c10e782c in ?? ()
> #2  0xe0bc294e52000010 in ?? ()
> #3  0x08481380b00400fa in ?? ()
> #4  0x3326aab400000000 in ?? ()
> #5  0x0000000008001e00 in ?? ()
> #6  0x000004043326aab4 in ?? ()
> #7  0x7aef0100040595ef in ?? ()
> 
> When I examine the memory on the stack I get like:
> 
> 0x7faae3cc7c10: 0x00    0x00    0x00    0x00    0xb4    0xaa    0x26    0x32
> 0x7faae3cc7c18: 0x00    0x1e    0x00    0x08    0x00    0x00    0x00    0x00
> 0x7faae3cc7c20: 0xb4    0xaa    0x26    0x32    0x04    0x04    0x00    0x00
> 0x7faae3cc7c28: 0xef    0x95    0x05    0x04    0x00    0x01    0xef    0x79
> 0x7faae3cc7c30: 0x06    0x04    0x00    0x00    0x00    0x01    0x2b    0xf8
> 0x7faae3cc7c38: 0x2c    0x78    0x0e    0xc1    0x35    0xc4    0xc1    0x00
> 0x7faae3cc7c40: 0x10    0x00    0x00    0x52    0x4e    0x29    0xbc    0xe0
> 0x7faae3cc7c48: 0xfa    0x00    0x04    0xb0    0x80    0x13    0x48    0x08
> 0x7faae3cc7c50: 0x00    0x00    0x00    0x00    0xb4    0xaa    0x26    0x33
> 0x7faae3cc7c58: 0x00    0x1e    0x00    0x08    0x00    0x00    0x00    0x00
> 0x7faae3cc7c60: 0xb4    0xaa    0x26    0x33    0x04    0x04    0x00    0x00
> 0x7faae3cc7c68: 0xef    0x95    0x05    0x04    0x00    0x01    0xef    0x7a
> 0x7faae3cc7c70: 0x06    0x04    0x00    0x00    0x00    0x01    0x2c    0x38
> 0x7faae3cc7c78: 0x2c    0xb8    0x0e    0xc1    0x35    0xc5    0xc1    0x00
> 0x7faae3cc7c80: 0x10    0x00    0x00    0x52    0x4e    0x29    0xbc    0xe0
> 0x7faae3cc7c88: 0xfa    0x00    0x04    0xb0    0x80    0x13    0x5c    0x08
> 
> And I see very similar byte patterns in a tcpdump taken at the time of the crash, so I'm wondering if data read from or to be written to the network is overflowing a buffer somewhere and corrupting the stack.
> 
> Does ceph use a magic start of message number or something that I could identify?

There isn't a simple magic string I can point to except for struct 
ceph_msg_header, but I doubt that will help, since it is reading the 
headers and message bodies into different buffers.  I forget: are you able 
to reproduce any of this with debugging enabled?  I would suggest adding 
pointers to the debug statements in msg/Pipe.cc to narrow down what is 
using some of this memory.

You might also want to just look at read_message, connect, and accept in 
Pipe.cc as I think those are the only places where data is read off the 
network into a buffer/struct on the stack.

sage
