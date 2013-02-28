From: Samuel Just <sam.just@inktank.com>
Subject: Re: OSD memory usage
Date: Thu, 28 Feb 2013 11:35:10 -0800
Message-ID: <CA+4uBUbx=dLraKRLrRHJT7qBgTOSKusXEMqHsLRXmCVyqA_-tg@mail.gmail.com>
References: <201302281857.r1SIvikH000790@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:58407 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266Ab3B1TfL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Feb 2013 14:35:11 -0500
Received: by mail-ve0-f170.google.com with SMTP id 14so2215584vea.15
        for <ceph-devel@vger.kernel.org>; Thu, 28 Feb 2013 11:35:10 -0800 (PST)
In-Reply-To: <201302281857.r1SIvikH000790@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bkw1a@ayesha.phys.virginia.edu
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Looks like it would have to be the pg_interval_t maps copied into the
MOSDPGNotify messages or something in the OSDMap...  Can you confirm
that all of your OSDs are all running the same version?  There are two
paths in that method, one for handling contemporary OSDs and a second
path for handling OSDs prior to 0.5something.  Thanks for the heap
map!
-Sam

On Thu, Feb 28, 2013 at 10:57 AM, Bryan K. Wright
<bkw1a@ayesha.phys.virginia.edu> wrote:
> Hi folks,
>
>         I've been looking into my problem with OSDs that use
> up a lot of memory.  Let running, I've seen them swell to
> over 8 GB of resident memory.  I'd really like to have some
> way of limiting the maximum memory footprint of an OSD.
> Is there a knob to do this?
>
>         I've just today recompiled ceph-osd with tcmalloc
> turned on, so I could do some memory profiling.  (The RPMS
> from ceph.com don't have it turned on.)  Here's an example
> of what I see from pprof:
>
> http://ayesha.phys.virginia.edu/~bryan/junk2.pdf
>
> Any suggestions would be appreciated.
>
>                                         Thanks,
>                                         Bryan
>
> --
> ========================================================================
> Bryan Wright              |"If you take cranberries and stew them like
> Physics Department        | applesauce, they taste much more like prunes
> University of Virginia    | than rhubarb does."  --  Groucho
> Charlottesville, VA  22901|
> (434) 924-7218            |         bryan@virginia.edu
> ========================================================================
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
