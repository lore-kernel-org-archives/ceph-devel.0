From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD, trouble in buffer.c
Date: Fri, 11 Dec 2015 10:56:50 +0100
Message-ID: <566A9DE2.9070204@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <56699439.3090006@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:59017 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbbLKJ5G (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Dec 2015 04:57:06 -0500
In-Reply-To: <56699439.3090006@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 10-12-2015 16:03, Willem Jan Withagen wrote:
> I have a failure in:
>   ./unittest_erasure_code_shec_arguments
> All tests befor this PASS. (other than rbd which is disabled to
> the time being)
>
> Which I traceback to code in ErasureCodeShec.cc
> Line 218:
>      unsigned blocksize = (*chunks.begin()).second.length();
> After a few iterations I get a "negative" blocksize, which causes
> allocations further on to really thrash the system out of swap.
>
> At first I expected it could be due to a Clang typecasting problem.
> But after more debugging I found the following in
> buffer.h
>      unsigned length() const {
> #if 0
>        // DEBUG: verify _len
>        unsigned len = 0;
>        for (std::list<ptr>::const_iterator it = _buffers.begin();
>             it != _buffers.end();
>             it++) {
>          len += (*it).length();
>        }
>        assert(len == _len);
> #endif
>        return _len;
>      }
>
> Which suggests that debugging was needed at this point earlier in life.
> If I enable this debug block, I do get the assert affected.
>
> Now the next question is why? Given the debug snippet it needed
> analyzing before.
> And the derived question then is:
>      What is the easiest path to find out what is actually wrong here.


A further followup on this.

After some extensive debugging with gdb and watches, I've come to the 
conclusion
That the location of _len is used by more that one part of the code...
The location gets alternately written during:
TestErasureCodeShec_arguments.cc:136
     shec_table.insert(std::make_pair(table_key,table_value));

Old value = 63015016
New value = 4294954344
....
Old value = 4294954344
New value = 63015016
.....

To retain this value 4294954344, which is definitely not the length.
Because printing values on the Linux variant, it gives 32. Which sounds 
much more
sensible....

So there a few possibilities that I can think of:
  1) Clang gets it wrong
  2) There is a mixup of different type of libs that make for different 
offsets in
     the bufferlist structs
  3) the bufferlist code is has portability issues
  4) the bufferlist code has errors that do no show with gcc

Most likely it will be either 2) or 3) ....
But other suggestions are welcome...

And since bufferlists are at the center of Ceph, better get things right.
So I'm going to go over the test/bufferlist.cc code and see what is in 
there.
And/or extract a less convoluted example from 
TestErasureCodeShec_arguments.cc
and see if it is in there as well.

--WjW





	
