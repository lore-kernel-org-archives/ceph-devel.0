From: Samuel Just <sjust@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 09:48:43 -0800
Message-ID: <CAN=+7FU3cxZnr-9omBKqhL0NcLbg-rV66FuPcHPyYUnGmum2iQ@mail.gmail.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
	<1998646860.28019612.1449155791509.JavaMail.zimbra@redhat.com>
	<CO1PR02MB208F00D967903C505E92074F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
	<20151203171704.GA13420@ultraspiritum.redhat.com>
	<CO1PR02MB2081012549C4D8027F4BF80F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33528 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbLCRso (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 12:48:44 -0500
Received: by igcmv3 with SMTP id mv3so18357833igc.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 09:48:43 -0800 (PST)
In-Reply-To: <CO1PR02MB2081012549C4D8027F4BF80F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, Casey Bodley <cbodley@redhat.com>, Sage Weil <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I still want there to be a single instance.  You need to have the
interface take TransactionRef by rvalue ref to make that work
(TransactionRef &&) as Adam mentioned.  This forces the caller to
either pass an rvalue or use std::move() -- which forces it to be
explicit.  The point of unique_ptr is to enforces single ownership
(any current violation of which would be a serious bug) with minimal
overhead.  I suspect that the performance issue you saw initially was
that the compiler simply wasn't in-lining the construction?
shared_ptr is of course more expensive due to the need to maintain a
thread safe ref count.  Any user which actually needs the ref count
would probably be just as slow with a hand-rolled implementation
(assuming we use make_shared).  Any user which doesn't actually need
the ref count could be switched to use unique_ptr.
-Sam

On Thu, Dec 3, 2015 at 9:40 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Hmm..Thanks Adam, so, one of the cleanups on the Ceph path could be to introduce make_shared..
> We will come up with a prototype of optimized io path with removing unnecessary use of shared_ptr and see how much overall gain we are getting..
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Adam C. Emerson [mailto:aemerson@redhat.com]
> Sent: Thursday, December 03, 2015 9:17 AM
> To: Somnath Roy
> Cc: Casey Bodley; Sage Weil; Samuel Just (sam.just@inktank.com); ceph-devel@vger.kernel.org
> Subject: Re: queue_transaction interface + unique_ptr + performance
>
> On 03/12/2015, Somnath Roy wrote:
>> I don't think make_shared / make_unique is part of c++11 (and ceph is using that). It is part of c++14 I guess..
>
> std::make_shared is in C++11, std::make_unique is in C++14. In addition to performance, std::make_shared is also more correct, in that:
>
>   std::shared_ptr<T>(new T)
>
> can leak object allocated by 'new T' if the allocation for the shared_ptr fails.
>
> std::make_unique is nice for cleanliness and symmetry, but doesn't add anything for performance or safety. (Also you can write your own make_unique, where make_shared is intimately involved with the details of shared_ptr.)
