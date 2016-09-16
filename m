From: Haomai Wang <haomai@xsky.com>
Subject: Re: filestore_fiemap is bad, memstore is buggy.
Date: Fri, 16 Sep 2016 11:40:16 +0800
Message-ID: <CACJqLyZPOJ8R-4=hZxPMZMzZj2WEGDdqrMNbuxHUsLjwVN6wMA@mail.gmail.com>
References: <alpine.DEB.2.11.1609152142570.19761@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0118.outbound.protection.outlook.com ([104.47.125.118]:52554
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751948AbcIPDkb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Sep 2016 23:40:31 -0400
Received: by mail-vk0-f54.google.com with SMTP id b133so8743446vka.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Sep 2016 20:40:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1609152142570.19761@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Sep 16, 2016 at 5:48 AM, Sage Weil <sweil@redhat.com> wrote:
> I was adding tests for clone_range in preparation for improving the
> bluestore implementation and got stuck on memstore and filestore bugs!
>
> The most alarming is that filestore very quickly fails the tests if
> filestore_fiemap is enabled.  It's off by default (phew!) but the
> ceph_test_objectstore test was explicitly enabling it to get better
> coverage.  For now I've just removed that so we stick with the default (no
> fiemap == good).  I wonder if we should consider removing fiemap from the
> code entirely, though, since it is clearly buggy, even on a modern kernel
> (I'm running 4.4 and XFS).

I tried with the new test case, I found even disable fiemap, I will
ran into failure. So I suspect the splice codes, I disable it, test
passed.

But fiemap and seek_data/seek_hole is still failing even disable
splice, I would like to dive into more to verify our codes if correct
since _do_seek_hole_data is copied from fiemap....

>
> I also hit bugs in memstore.  I fixed the one in the BufferlistObject
> implementation, but the PageSet one I couldn't figure out after 20
> minutes, so I changed the default config to memstore_page_set = false for
> now.  Perhaps Casey or Adam or whoever wrote that can take a look?  It's
> very easy to reproduce.
>
> See this PR:
>
>         https://github.com/ceph/ceph/pull/11103
>
> Thanks!
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
