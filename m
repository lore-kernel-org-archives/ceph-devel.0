From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: The cache problem of re-export NFS test
Date: Thu, 14 Apr 2011 10:56:56 -0700
Message-ID: <BANLkTin_PT2+X4iDQHpBW=6yYDbstYtn6Q@mail.gmail.com>
References: <BANLkTim_34TkwKzTpwnciW41Dn9Bq1Zskw@mail.gmail.com>
	<Pine.LNX.4.64.1104120834100.12198@cobra.newdream.net>
	<BANLkTinV8T5Vq8P5grvLtuwxB2BO-T=vLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39555 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933234Ab1DNR45 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 13:56:57 -0400
Received: by fxm17 with SMTP id 17so1343710fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 10:56:56 -0700 (PDT)
In-Reply-To: <BANLkTinV8T5Vq8P5grvLtuwxB2BO-T=vLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Apr 14, 2011 at 1:52 AM, Sylar Shen <kimulaaa@gmail.com> wrote:
> Hi Sage,
> Thanks for your reply. I really appreciated.
> I tried what you suggested to set the argument "sync" in /etc/exports.
> I also checked "man 5 exports" and it showed that sync means reply to
> requests only after the changes have been committed to stable storage.
> It didn't mention that the export server won't do the cache task.
> However, after I did the experiment, I found that the memory usage of
> Ceph-client still went up to maximum value while writing the data
> which means Ceph-client did the cache task.
> So...are there other possible ways to solve my problem?

I don't think the page cache is a "problem," really. It is there to
improve performance!

However, if you really want to remove pages from the page cache, there
is a little-known syscall called fadvise. fadvise(FADV_DONTNEED, ...)
will request that the kernel flush a region of the file out of the
page cache. I think someone wrote a patch for tar(1) that calls
fadvise(FADV_DONTNEED) the files after tar reads them, on the
assumption that they would probably not be read again in the near
future.

Also, there is this: http://code.google.com/p/pagecache-mangagement/

Of course, if you're trying to do performance measurement, I don't
think you want to tweak the page cache settings.

cheers,
Colin
