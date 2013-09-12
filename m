From: James Harper <james.harper@bendigoit.com.au>
Subject: still crashes with tapdisk rbd
Date: Thu, 12 Sep 2013 11:21:03 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B664DF854@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:46034 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab3ILLVP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Sep 2013 07:21:15 -0400
Received: from bitcom1.int.sbss.com.au ([2001:388:e000:712:a5ca:4fd3:14f:ad5d])
	by smtp2.bendigoit.com.au with esmtp (Exim 4.80)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1VK4xT-0002cL-UN
	for ceph-devel@vger.kernel.org; Thu, 12 Sep 2013 21:21:12 +1000
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm still getting crashes with tapdisk rbd. Most of the time it crashes gdb if I try. When I do get something, the crashing thread is always segfaulting in pthread_cond_wait and the stack is always corrupt:

(gdb) bt
#0  0x00007faae20c52d7 in pthread_cond_wait@@GLIBC_2.3.2 () from remote:/lib/x86_64-linux-gnu/libpthread.so.0
#1  0x00c1c435c10e782c in ?? ()
#2  0xe0bc294e52000010 in ?? ()
#3  0x08481380b00400fa in ?? ()
#4  0x3326aab400000000 in ?? ()
#5  0x0000000008001e00 in ?? ()
#6  0x000004043326aab4 in ?? ()
#7  0x7aef0100040595ef in ?? ()

When I examine the memory on the stack I get like:

0x7faae3cc7c10: 0x00    0x00    0x00    0x00    0xb4    0xaa    0x26    0x32
0x7faae3cc7c18: 0x00    0x1e    0x00    0x08    0x00    0x00    0x00    0x00
0x7faae3cc7c20: 0xb4    0xaa    0x26    0x32    0x04    0x04    0x00    0x00
0x7faae3cc7c28: 0xef    0x95    0x05    0x04    0x00    0x01    0xef    0x79
0x7faae3cc7c30: 0x06    0x04    0x00    0x00    0x00    0x01    0x2b    0xf8
0x7faae3cc7c38: 0x2c    0x78    0x0e    0xc1    0x35    0xc4    0xc1    0x00
0x7faae3cc7c40: 0x10    0x00    0x00    0x52    0x4e    0x29    0xbc    0xe0
0x7faae3cc7c48: 0xfa    0x00    0x04    0xb0    0x80    0x13    0x48    0x08
0x7faae3cc7c50: 0x00    0x00    0x00    0x00    0xb4    0xaa    0x26    0x33
0x7faae3cc7c58: 0x00    0x1e    0x00    0x08    0x00    0x00    0x00    0x00
0x7faae3cc7c60: 0xb4    0xaa    0x26    0x33    0x04    0x04    0x00    0x00
0x7faae3cc7c68: 0xef    0x95    0x05    0x04    0x00    0x01    0xef    0x7a
0x7faae3cc7c70: 0x06    0x04    0x00    0x00    0x00    0x01    0x2c    0x38
0x7faae3cc7c78: 0x2c    0xb8    0x0e    0xc1    0x35    0xc5    0xc1    0x00
0x7faae3cc7c80: 0x10    0x00    0x00    0x52    0x4e    0x29    0xbc    0xe0
0x7faae3cc7c88: 0xfa    0x00    0x04    0xb0    0x80    0x13    0x5c    0x08

And I see very similar byte patterns in a tcpdump taken at the time of the crash, so I'm wondering if data read from or to be written to the network is overflowing a buffer somewhere and corrupting the stack.

Does ceph use a magic start of message number or something that I could identify?

Thanks

James
