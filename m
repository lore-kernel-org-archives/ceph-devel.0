From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RadosGW admin API
Date: Fri, 18 Apr 2014 08:07:49 -0700
Message-ID: <CABBk=J84CNCdhxKpbQ5U7gPYwRzhX7UGDjHOAQQqFz6MFSvN6A@mail.gmail.com>
References: <CAK7XC_k+4epfF81F4kDmq7tS_R39-xpJi69Skw-GcBPrf24exw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:57727 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbaDRPHu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Apr 2014 11:07:50 -0400
Received: by mail-ve0-f177.google.com with SMTP id sa20so3038803veb.36
        for <ceph-devel@vger.kernel.org>; Fri, 18 Apr 2014 08:07:49 -0700 (PDT)
In-Reply-To: <CAK7XC_k+4epfF81F4kDmq7tS_R39-xpJi69Skw-GcBPrf24exw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alain Dechorgnat <dechorgnata@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Apr 18, 2014 at 2:36 AM, Alain Dechorgnat <dechorgnata@gmail.com> wrote:
> Hi all,
>
> I'm working on an administration GUI (Inkscope).
> For this, I am using RadosGW admin API from python scripts and it's
> working rather well.
> I achieve to call getUserInfo for a user
>
> But, in Radosgw admin ops API documentation, it's said for getUserInfo:
> " If no user is specified returns the list of all users along with
> suspension information."
>
> But when I don't put the uid, I got a 403 Forbidden error.
> In the radosgw.log file, I can see that signature is OK, op_mask is OK
> but it return 403.
> This happens on a Dumpling platform and an Emperor platform.
>
> Is this a bug in the documentation or the code, or am I doing something wrong?
>

Looking at the code now, it sounds like a documentation issue. You
should be able to list users through the metadata api.

Yehuda
