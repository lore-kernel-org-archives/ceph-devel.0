From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 09/33] libceph: fix crush_decode() call site in osdmap_decode()
Date: Fri, 28 Mar 2014 16:57:41 +0200
Message-ID: <CALFYKtCcZiRG2z8VW7Ja8WT7o=0qdGxg6ETvak-b333DruCgtg@mail.gmail.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
	<1395944299-21970-10-git-send-email-ilya.dryomov@inktank.com>
	<53347FDB.5030203@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:63300 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbaC1O5m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Mar 2014 10:57:42 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so5312431qaq.38
        for <ceph-devel@vger.kernel.org>; Fri, 28 Mar 2014 07:57:41 -0700 (PDT)
In-Reply-To: <53347FDB.5030203@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 27, 2014 at 9:45 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
>> The size of the memory area feeded to crush_decode() should be limited
>> not only by osdmap end, but also by the crush map length.  Also, drop
>
> You're also letting crush_decode() verify it has the buffer space
> it needs internally, rather than checking it before making the call,
> which is good.  (Though I guess you don't have to mention it.)

Yes.

>
>> unnecessary dout() (dout() in crush_decode() conveys the same info) and
>> step past crush map only if it is decoded successfully.
>
> I actually think crush_decode() should take a (void **)
> instead, as its first argument and advance the pointer
> by as much as it uses (like most of the other routines do).
> That's a suggestion, but I don't really care, this is fine.

Me too, and I considered it, but it's the only decode helper that takes
a (void *) and it even names it "pbyval", which suggests that it was
intentional, so I kept it the way it is.

Thanks,

                Ilya
