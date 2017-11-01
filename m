From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: omap and xattrs clarifications
Date: Wed, 1 Nov 2017 13:27:26 -0700
Message-ID: <CAJ4mKGZCuE5yvMM3Et3azOGjnBMuoixRTSL64qRR3b8bXVFULg@mail.gmail.com>
References: <FF0E6C8D-BF21-4632-80AF-FBCCEB031A53@TERADATA.COM>
 <CAJ4mKGbms8Bm5uEBSx-ToEPoTvuQ_puSevX2HkqaGN7yJc0O=Q@mail.gmail.com> <4F4980A2-EC2B-4955-B436-121EFFF3197E@TERADATA.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:46548 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754899AbdKAU11 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Nov 2017 16:27:27 -0400
Received: by mail-io0-f177.google.com with SMTP id 101so8916166ioj.3
        for <ceph-devel@vger.kernel.org>; Wed, 01 Nov 2017 13:27:27 -0700 (PDT)
In-Reply-To: <4F4980A2-EC2B-4955-B436-121EFFF3197E@TERADATA.COM>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 30, 2017 at 4:45 PM Kamble, Nitin A
<Nitin.Kamble@teradata.com> wrote:
>
> Hi Greg,
>   I was going over the ceph-devel mailing list to understand omap better. I found your thread [1] explaining omap. I would like to ask few follow up questions, which should be useful for the whole ceph community.
>
> What is the need of both omap and xattrs?

It's fair to say there's some overlap here. The honest answer is that
xattrs exist because filesystems support them so we exposed it, and
then later on we added the omap interface because we needed more than
xattrs feasibly support. But there are some practical differences in
typical deployments (on Filestore).

>
> How is each used currently?

omap is used for lots of key-value data (for instance, RGW stores each
bucket index as a series of omap entries), whereas we use xattrs for
relatively fixed-size data.

>
> How to use them, and not misuse them?

In general:
1) xattrs have a good chance of being read into memory at the same
time as the object's local file inode is, which means if that's all
you need you can expect it to be faster/use less disk time.
2) omaps support vastly more entries than xattrs are efficient about
(if you use too many, the xattrs "spill over" into the leveldb/rocksdb
store we use to back omap, so it's not a huge deal).

Also, I believe in Bluestore systems xattrs and omaps are implemented
identically. But there's still the convention that xattrs are for
small constant-sized data and omaps are used for large lists.
-Greg
