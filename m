From: John Spray <john.spray@redhat.com>
Subject: Re: Request for comments
Date: Fri, 10 Oct 2014 18:04:02 +0100
Message-ID: <CAGd4Wr3VOoBHT5OHPLu8y-X-cqOST7q-Cw1QFr1QQKs+2iKqbw@mail.gmail.com>
References: <CAMzumdaE+pPP2RzRhDrfsV1LjNAqQuM3qHQ5rB37ffsHFaySdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:37614 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbaJJREE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 13:04:04 -0400
Received: by mail-lb0-f181.google.com with SMTP id l4so3400184lbv.26
        for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 10:04:02 -0700 (PDT)
In-Reply-To: <CAMzumdaE+pPP2RzRhDrfsV1LjNAqQuM3qHQ5rB37ffsHFaySdA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Barclay Jameson <almightybeeij@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

We do have a lot of functions that bubble up standard error numbers --
in general callers of these functions have to accommodate the
possibility of any error code (including errors they don't
understand).  I notice that ::mount is a bit unusual in additionally
having some explicit 'magic' return codes to indicate which stage of
init failed.

A pull request to document the magic -1001, -1002 etc returns from
that function would be welcome, it might not be useful to try and
enumerate all possible error numbers for all API calls though -- it
could be hard to prove that the list was comprehensive, and callers
should always handle unexpected codes too.

Cheers,
John

On Fri, Oct 10, 2014 at 5:22 PM, Barclay Jameson
<almightybeeij@gmail.com> wrote:
> When reading code for libcephfs.cc (giant branch) it wasn't apparent
> to me for the lines 95 and lines 101 what the return values was
> expected from the function calls init and mount other than 0.
>
> It was only after tracing a bit of code did I see that error code such
> as: -ENOENT and -EEXIST could be returned as well.
>
> It would be awesome if comments were added for these functions to show
> what the expected return values are going to be for these functions.
>
> Thanks,
>
> almightybeeij
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
