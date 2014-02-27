From: Gregory Farnum <greg@inktank.com>
Subject: Re: location-aware file placement in Ceph
Date: Thu, 27 Feb 2014 10:29:58 -0800
Message-ID: <CAPYLRzjxhFkETj7ijQXHSjyKBP9LXcuxSqJdSA98KFBrYVVAUQ@mail.gmail.com>
References: <530F3CAC.2040504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:50745 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbaB0S37 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Feb 2014 13:29:59 -0500
Received: by mail-qc0-f171.google.com with SMTP id x3so3822622qcv.30
        for <ceph-devel@vger.kernel.org>; Thu, 27 Feb 2014 10:29:58 -0800 (PST)
In-Reply-To: <530F3CAC.2040504@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhongliang Zhao <zhaozhongliang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There are some options within CRUSH to let you decide where you want
to place particular classes of data, but it's not really available on
a per-object or per-file basis. You should look through the CRUSH
stuff at ceph.com/docs to get an idea of what's possible.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Thu, Feb 27, 2014 at 5:25 AM, Zhongliang Zhao
<zhaozhongliang@gmail.com> wrote:
> Dear all,
>
> As new to ceph, may I ask in the crush algorithm, is there a way to
> configure where the file to be stored, not randomly.
> My requirement is to place the files that within the same location(within a
> geographic area), into the same OSD, instead of randomly placing them
> seperately.
>
> I guess crush may support this. But to do this, I just have to configure
> some parameters in some ceph commands? or I have to modify the ceph crush
> algorithm and re-compile ceph?
>
> Many thanks for any helpful pointers.
>
> Cheers, Giovanni
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
