From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD, trouble in buffer.c
Date: Thu, 10 Dec 2015 16:03:21 +0100
Message-ID: <56699439.3090006@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:55823 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbbLJPEC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Dec 2015 10:04:02 -0500
In-Reply-To: <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I have a failure in:
  ./unittest_erasure_code_shec_arguments
All tests befor this PASS. (other than rbd which is disabled to
the time being)

Which I traceback to code in ErasureCodeShec.cc
Line 218:
	unsigned blocksize = (*chunks.begin()).second.length();
After a few iterations I get a "negative" blocksize, which causes
allocations further on to really thrash the system out of swap.

At first I expected it could be due to a Clang typecasting problem.
But after more debugging I found the following in
buffer.h
     unsigned length() const {
#if 0
       // DEBUG: verify _len
       unsigned len = 0;
       for (std::list<ptr>::const_iterator it = _buffers.begin();
            it != _buffers.end();
            it++) {
         len += (*it).length();
       }
       assert(len == _len);
#endif
       return _len;
     }

Which suggests that debugging was needed at this point earlier in life.
If I enable this debug block, I do get the assert affected.

Now the next question is why? Given the debug snippet it needed 
analyzing before.
And the derived question then is:
	What is the easiest path to find out what is actually wrong here.

All suggestions welcome.

--WjW
