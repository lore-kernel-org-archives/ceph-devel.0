From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Effects of varying page size on OSD writes
Date: Mon, 4 May 2015 10:23:41 -0700
Message-ID: <CAC6JEv9SrAt-q-Q2mTDGjbiW+WqnUfnEZRJi7HNBcBoU3CgBvg@mail.gmail.com>
References: <CAPvkgC1psL7xc8V_n+tzHoWdgLviyYw7T3m_Lg5Ej-kaMzYB7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38586 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbEDRXn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 May 2015 13:23:43 -0400
Received: by igbhj9 with SMTP id hj9so89217433igb.1
        for <ceph-devel@vger.kernel.org>; Mon, 04 May 2015 10:23:42 -0700 (PDT)
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com. [209.85.213.174])
        by mx.google.com with ESMTPSA id v14sm5569522igd.12.2015.05.04.10.23.42
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2015 10:23:42 -0700 (PDT)
Received: by igbyr2 with SMTP id yr2so90604873igb.0
        for <ceph-devel@vger.kernel.org>; Mon, 04 May 2015 10:23:42 -0700 (PDT)
In-Reply-To: <CAPvkgC1psL7xc8V_n+tzHoWdgLviyYw7T3m_Lg5Ej-kaMzYB7w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, May 1, 2015 at 7:54 AM, Steve Capper <steve.capper@linaro.org> wrote:
> Hello,
> Whilst testing Ceph 0.94.1 on 64-bit ARM hardware, I noticed that
> switching the kernel PAGE_SIZE from 4KB to 64KB caused an increase by
> a factor of ~6 in the total amount of data written to disk (according
> to blktrace) by the OSD when running the RBD bench-write test (with
> --io-pattern rand, --io-size=4096, --num-threads=16, --io-total=$((50
> << 20))).
>
> Delving into the source, it is apparent that the FileJournal code uses
> the current page size for the block size. I was wondering why
> something like the block device sector size wasn't used instead? Is
> there a mmap somewhere that I missed, or are fewer larger blocks
> better for most use cases? (The use case above may be overly
> contrived?).

This isn't an area of the kernel I know much about, but doesn't the
page cache work in memory page size, regardless of what the disk is
doing? FileJournal/FileStore are definitely trying to be friendly to
what the page cache is up to.
-Greg
