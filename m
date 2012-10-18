From: Alex Elder <elder@inktank.com>
Subject: Re: limit of maximum number of rbd devices that can be mapped
Date: Wed, 17 Oct 2012 21:18:25 -0500
Message-ID: <507F66F1.4000509@inktank.com>
References: <CAP5wSLc0fGo03Sh0mric3pb_yNkOY=0bEkMHR0Nmq2u8F0nJAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39980 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab2JRCS2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Oct 2012 22:18:28 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so12995671iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 17 Oct 2012 19:18:28 -0700 (PDT)
In-Reply-To: <CAP5wSLc0fGo03Sh0mric3pb_yNkOY=0bEkMHR0Nmq2u8F0nJAw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Huang <ythuang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 10/17/2012 09:15 PM, Christian Huang wrote:
> Hi,
>     what is the maximum number of rbd devices that can be mapped on a
> single host?
>     we recently did a test to mount a large number of rbd devices and
> hit a wall around 230
>     with the following message

That sounds about right.  We were just discussing this earlier
this week.  It's limited at the moment by the number of major
device numbers available on the system, and I think you found
that limit.  We would obviously like to have a solution for
this but we've only just started considering options.

					-Alex

> with 230 rbd devices already mapped, the next one yielded this.
> Console output
> wistor@wistor-002:~$ sudo rbd map test299
> add failed: (16) Device or resource busy
> 
> dmesg
> [77962.346749] register_blkdev: failed to get major for rbd229
> 
> Chris.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

