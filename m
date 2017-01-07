From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2] ceph: set io_pages bdi hint
Date: Sat, 7 Jan 2017 19:31:00 +0300
Message-ID: <CAOi1vP9b9=magMgdgW+tfwL2CW2ZEFLao7fAOSxnOfNiYbT2uA@mail.gmail.com>
References: <C3DA23CD-10FF-491D-BD31-0C1D8673105E@redhat.com> <1483622696-30353-1-git-send-email-andreas.gerstmayr@catalysts.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36716 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933289AbdAGQbC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Jan 2017 11:31:02 -0500
Received: by mail-wm0-f47.google.com with SMTP id c85so57423911wmi.1
        for <ceph-devel@vger.kernel.org>; Sat, 07 Jan 2017 08:31:01 -0800 (PST)
In-Reply-To: <1483622696-30353-1-git-send-email-andreas.gerstmayr@catalysts.cc>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, andreas.gerstmayr@gmail.com, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>

On Thu, Jan 5, 2017 at 4:23 PM, Andreas Gerstmayr
<andreas.gerstmayr@catalysts.cc> wrote:
> This patch sets the io_pages bdi hint based on the rvsize mount option.
> Without this patch large buffered reads (request size > max readahead)
> are processed sequentially in chunks of the readahead size (i.e. read
> requests are sent out up to the readahead size, then the
> do_generic_file_read() function waits until the first page is received).
>
> With this patch read requests are sent out up to the size specified in
> the new rvsize mount option at once (default: 64 MB).
>
> Signed-off-by: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
> ---
>
> Thanks for your review.
> On second thought, I think I should not reuse the rsize mount option
> (maximum read size per OSD request), therefore I created a new mount
> option rvsize with a default value of 64 MB (as you suggested).
>
> (Note: This patch depends on kernel version 4.10-rc1)

I'll defer to Zheng's judgement, but a separate mount option for this
seems overkill to me.  We should be able to work something out between
the existing rsize and rasize.

Thanks,

                Ilya
