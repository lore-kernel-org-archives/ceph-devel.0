From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: debugging librbd async - valgrind memtest hit
Date: Fri, 30 Aug 2013 23:39:00 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B664B6EA2@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B664B63F0@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308300820380.24783@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:43073 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3H3XjT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Aug 2013 19:39:19 -0400
In-Reply-To: <alpine.DEB.2.00.1308300820380.24783@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Sylvain Munaut (s.munaut@whatever-company.com)" <s.munaut@whatever-company.com>

> 
> On Fri, 30 Aug 2013, James Harper wrote:
> > I finally got a valgrind memtest hit... output attached below email. I
> > recompiled all of tapdisk and ceph without any -O options (thought I had
> > already...) and it seems to have done the trick
> 
> What version is this?  The line numbers don't seem to match up with my
> source tree.

0.67.2, but I've peppered it with debug prints

> > Basically it looks like an instance of AioRead is being accessed after
> > being free'd. I need some hints on what api behaviour by the tapdisk
> > driver could be causing this to happen in librbd...
> 
> It looks like refcounting for the AioCompletion is off.  My first guess
> would be premature (or extra) calls to rados_aio_release or
> AioCompletion::release().
> 
> I did a quick look at the code and it looks like aio_read() is carrying a
> ref for the AioComplete for the entire duration of the function, so it
> should not be disappearing (and taking the AioRead request struct with it)
> until well after where the invalid read is.  Maybe there is an error path
> somewhere what is dropping a ref it shouldn't?
> 

I'll see if I can find a way to track that. It's the c->get() and c->put() that track this right?
 
The crash seems a little bit different every time, so it could still be something stomping on memory, eg overwriting the ref count or something.

Thanks

James

