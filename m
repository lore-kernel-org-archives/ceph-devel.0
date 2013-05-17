From: Milosz Tanski <milosz@adfin.com>
Subject: Re: fscache support
Date: Fri, 17 May 2013 19:06:48 -0400
Message-ID: <CANP1eJFCd6ceT1nT6OaVu0K7cK02EnwqrPe2NBbYjQ2iCqoo1A@mail.gmail.com>
References: <CANP1eJEKUErEYiNaPd=bsHF4Mz5hvyhFTDUkOhWbypDFmrnGPg@mail.gmail.com>
	<alpine.DEB.2.00.1305171134450.16140@cobra.newdream.net>
	<CANP1eJErmvTDS=h70U-tBuePi91iAHm3mGiLM+C4Yg32FsbB8w@mail.gmail.com>
	<CANP1eJFncKWfOaibZvvLSGJFo3Mg=yDXZw6e4SqJJJo6VS=HRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:37402 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3EQXGt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 May 2013 19:06:49 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so10753161iet.28
        for <ceph-devel@vger.kernel.org>; Fri, 17 May 2013 16:06:48 -0700 (PDT)
In-Reply-To: <CANP1eJFncKWfOaibZvvLSGJFo3Mg=yDXZw6e4SqJJJo6VS=HRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Sage,

>>> Does the cache persist across restarts/remounts?  That is a bit more
>>> difficult, although it's possible we have a version field we can use for
>>> that as well...
>>
>> I was planing to make it work across remounts, if it's possible. I
>> haven't gotten there yet.
>
> I forgot to add, that I was planning to use the version field in the
> ceph_mds_reply_inode struct. Is that good way of telling?

Never mind, I ended up looking what CIFS and NFS do. They save the old
mtime and size. So until I have something better I'm going to test
with this.

Also, I forgot to reply-all to the mailing list last time. Sorry.

- Milosz
