From: Samuel Just <sam.just@inktank.com>
Subject: Re: why do we need SNAPDIR ?
Date: Fri, 2 Jan 2015 08:48:59 -0800
Message-ID: <CA+4uBUbQz0yRNKQpVQ9N8eG7cGdkAijVFYqyS-6LZ0ybiB7DMA@mail.gmail.com>
References: <CALZt5jwj=9KXTJu-T-bWqMXw9FHhbGen9QJfZ5fFDg_7jv3HhA@mail.gmail.com>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:45442 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbbABQtB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jan 2015 11:49:01 -0500
Received: by mail-la0-f49.google.com with SMTP id hs14so15214689lab.8
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jan 2015 08:48:59 -0800 (PST)
In-Reply-To: <CALZt5jwj=9KXTJu-T-bWqMXw9FHhbGen9QJfZ5fFDg_7jv3HhA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicheal <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

The SNAPDIR object only exists if the 1) head does not exist and 2)
there are clones.  The purpose of the object is to hold the snapset
xattr which would normally be on the head object.
-Sam

On Wed, Dec 24, 2014 at 7:27 PM, Nicheal <zay11022@gmail.com> wrote:
> Dear develops,
>
> I find that SNAPDIR means a special object in ceph. It is a read-only
> object since if a op write want to modify SNAPDIR object, it return
> -EINVAL immediately. But I cannot find when we need to create the
> SNAPDIR object? and what is used for?
>
> Based on my understanding, ceph snapshot is realized by snap_set Xattr
> and snapperMapper in omap. It does not cooperate with SNAPDIR object,
> so I am puzzled. Can anyone provide some guides to understand this?
>
>
> Regards,
> Ning Yao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
