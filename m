From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: still crashes with tapdisk rbd
Date: Fri, 13 Sep 2013 09:19:50 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B664E895A@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B664DF854@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1309120726120.23229@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:57288 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab3IMJUK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Sep 2013 05:20:10 -0400
In-Reply-To: <alpine.DEB.2.00.1309120726120.23229@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> You might also want to just look at read_message, connect, and accept in
> Pipe.cc as I think those are the only places where data is read off the
> network into a buffer/struct on the stack.
> 

After adding the following to the [client] section of the config file the problem seems to have gone away, or at least I haven't been able to reproduce it where previously I had figured out a way to reproduce it reliably:

[client]
ms rwthread stack bytes = 8388608

It seems that ceph uses a stack size of 1M in the absence of the above. I'm not sure if the original problem was a stack overflow and this fixes it, or if I'm just working around it by making the stack bigger...

Previously I'd created a wrapper around pthread_cond_wait, and had that wrapper:
. allocate a large (256KB when stack size was 1MB) array on the stack
. fill that array with increasing values (1, 2, 3, etc)
. protect the memory pages (whole pages only) in that array with mprotect
. call pthread_cond_wait proper
. unprotect the pages
. check the array to make sure it was still intact

It appears to pretty much always be the writer wait thread whose stack was being corrupted on wait, but nothing ever tripped up the above, and a lot of the time the above would itself crash half way through filling up the structure, always on a page boundary. Does gcc use a guard page on the stack?

James

