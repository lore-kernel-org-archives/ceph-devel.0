From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 1/2] ceph: avoid NULL pointer dereference in ceph_crypto_key_destroy()
Date: Mon, 5 Feb 2018 16:48:22 +0100
Message-ID: <CAOi1vP_344rFCgdP2jo46QAsYXMsLkJEE69ORj-WpVNDyRtunQ@mail.gmail.com>
References: <1517738929-229785-1-git-send-email-cgxu519@icloud.com>
 <CAOi1vP8bFvd5OjC+whKQMSaLV46YyErF5DA-Q4udzWpFuCk7Dw@mail.gmail.com>
 <EA91EF3C-968A-4277-A887-2FD6E22A1030@icloud.com> <CAOi1vP_edS5MRhO0tJo6Zg9t4M-7yJY+1J-kOzS4pg02EwtNOQ@mail.gmail.com>
 <1A67A945-18DF-414F-954E-D1F6A813844F@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:55990 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbeBEPsX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 10:48:23 -0500
Received: by mail-it0-f47.google.com with SMTP id b66so6083169itd.5
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 07:48:23 -0800 (PST)
In-Reply-To: <1A67A945-18DF-414F-954E-D1F6A813844F@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>

On Mon, Feb 5, 2018 at 2:40 PM, Chengguang Xu <cgxu519@icloud.com> wrote:
> Yeah, you are right, I misread that bit. Should I resend second patch?

Yes, it doesn't apply.

Thanks,

                Ilya
