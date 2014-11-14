From: Gregory Farnum <greg@gregs42.com>
Subject: Re: XAttrs limited to 100 bytes
Date: Fri, 14 Nov 2014 07:07:16 -0800
Message-ID: <CAC6JEv84zupBwdLRQ-=ViCagTnb1szTZg7u73Ftr5sLMARTqGA@mail.gmail.com>
References: <54661092.7010804@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37572 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935367AbaKNPHS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Nov 2014 10:07:18 -0500
Received: by mail-ig0-f169.google.com with SMTP id hn18so3269450igb.2
        for <ceph-devel@vger.kernel.org>; Fri, 14 Nov 2014 07:07:17 -0800 (PST)
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com. [209.85.213.177])
        by mx.google.com with ESMTPSA id b77sm14502713ioe.35.2014.11.14.07.07.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Nov 2014 07:07:16 -0800 (PST)
Received: by mail-ig0-f177.google.com with SMTP id uq10so376986igb.4
        for <ceph-devel@vger.kernel.org>; Fri, 14 Nov 2014 07:07:16 -0800 (PST)
In-Reply-To: <54661092.7010804@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joaquim Rocha <joaquim.rocha@cern.ch>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Nov 14, 2014 at 6:24 AM, Joaquim Rocha <joaquim.rocha@cern.ch> wrote:
> Hi folks,
>
> I found out recently that xattributes are limited to 100 chars in length so
> I saw the commits that introduced this change [1] but I don't understand why
> this is needed if we take into account that by default xattributes are going
> into the omap.
>
> In those changes it also prevents that limit to go over 100 even configured
> that way so I would like to know the reason for this limit and if there is
> any other way we can override it I might be missing.
>
> For my use case I will need a much larger length so I think that there
> should be a way to easily increase the limit (or even have a much larger
> value as the default).
>
> [1] https://github.com/ceph/ceph/pull/2111

These are just setting limits on the length of the xattr *names*, not
the xattr contents. This is because filesystems impose limits on name
size and we do store xattrs in the filesystem in the default
configuration with most releases of Ceph (they overflow into leveldb
if there are too many).
If that's really going to be a problem for you...I don't know what to
say, sorry. These are close to limits you should have been following
already fi you want your stuff to work on e.g. ext4. :)
-Greg
