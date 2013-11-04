From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: unable to compile
Date: Mon, 4 Nov 2013 06:34:52 -0800
Message-ID: <CA+Hcz59N=3nREPQtYqdE-NKC_LXrK_E_nOzYG7VwvVQWGtMdJQ@mail.gmail.com>
References: <94B89671-08D2-49DB-837B-B0377DE8120C@cs.utah.edu>
	<B9B45B52-0660-492A-AC51-597D3D01C5D5@cs.utah.edu>
	<CAB2gnbUmdbyVsQLF=RibhiiCKKAZsMY=aokM+Ke7JcwLOTPQRQ@mail.gmail.com>
	<5276CF55.2010304@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:57545 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab3KDOey (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Nov 2013 09:34:54 -0500
Received: by mail-qe0-f41.google.com with SMTP id x7so4151997qeu.0
        for <ceph-devel@vger.kernel.org>; Mon, 04 Nov 2013 06:34:52 -0800 (PST)
In-Reply-To: <5276CF55.2010304@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>
Cc: Noah Watkins <noahwatkins@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

This pull request (https://github.com/ceph/ceph/pull/812) reverts the
patch that changed the struct initialization. That is C99 style, but
apparently it isn't common in compilers, and GNU has just added it as
an extension.

I don't have a better solution at the moment, but as Greg mentioned,
perhaps detecting C++11 is an option, but that means a big nasty
ifdef. Another solution might be to just put the struct initialization
in a C file.

On Sun, Nov 3, 2013 at 2:33 PM, Xing Lin <xinglin@cs.utah.edu> wrote:
> Thanks, Noah!
>
> Xing
>
> On 11/3/2013 3:17 PM, Noah Watkins wrote:
>>
>> Thanks for looking at this. Unless there is a good solution I think
>> reverting it is ok as breaking the compile on a few platflorms is not ok.
>> Ill be lookong at this tonight.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
