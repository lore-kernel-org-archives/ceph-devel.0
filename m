From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: "1 hosts down" health warning?
Date: Tue, 10 May 2016 12:20:18 -0700
Message-ID: <CAFMfnwpkUAu73XhaOEE+CgRA_LWbs4GARnPrBSd3-NWY5Crh_A@mail.gmail.com>
References: <alpine.DEB.2.11.1605091232040.1841@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33489 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbcEJTUT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 15:20:19 -0400
Received: by mail-yw0-f169.google.com with SMTP id t10so24450957ywa.0
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2016 12:20:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605091232040.1841@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I really like this, +1 :)

On Mon, May 9, 2016 at 9:36 AM, Sage Weil <sweil@redhat.com> wrote:
> We have a feature (mon_osd_reporter_subtree_level = host) that makes it so
> that if an entire host is down (or whatever the configured hierarchy
> level is) the osds aren't automatically marked out after 5 minutes.
>
> This is confusing on an actual cluster because you see something like
>
>             48/5661 in osds are down
>
> bit it never clears.  It's not until you look at the ceph osd tree output
> that you can see why they aren't getting marked out.
>
> It would be great if the health warning said something like
>
>             48/5661 in osds are down
>             1/142 hosts are down (accounting for 48/48 down osds)
>
> and the health detail said something like
>
>   host foo is down with 48 OSDs
>
> I think this would be pretty easy to implement given the mon is
> already doing the subtree-based checks.
>
> Thoughts? Any takers?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 

Kyle Bader
