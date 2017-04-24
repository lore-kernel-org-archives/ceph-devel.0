From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: cephfs issue, get_reply data > preallocated
Date: Mon, 24 Apr 2017 20:48:36 +0200
Message-ID: <CAOi1vP9LUyuXgj1gOQNLxNsvuQbKqpkGaaZvWU=EnfMVkks8xQ@mail.gmail.com>
References: <CAGbvivLexKgh7L5hhLXjWSJiPj-nEwuxC4O3Hefxt5WGWjHpgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:33564 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S972836AbdDXSsi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Apr 2017 14:48:38 -0400
Received: by mail-ua0-f179.google.com with SMTP id j59so74390963uad.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Apr 2017 11:48:38 -0700 (PDT)
In-Reply-To: <CAGbvivLexKgh7L5hhLXjWSJiPj-nEwuxC4O3Hefxt5WGWjHpgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Apr 24, 2017 at 5:51 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> Ubuntu 16.04.1
> Ceph 10.2.5
> Linux 4.9.10 kernel
>
> We are having problems accessing some files in cephfs, the process
> reading the files become hung when trying to read them (md5sum, for
> example).  When these hangups occur, there are messages in the system
> logs that look like this:
>
> "libceph: get_reply osd6 tid 55 data 1305852 > preallocated 1048576, skipping"
>
> The cluster shows healthy status and all OSD are reporting as up/up.
>
> Wondering if our hanging read issues are related to the messages being
> reported, they seem to be since we only see the messages once we
> encounter the issue reading the files.

Definitely -- this message is printed when the reply is dropped on the
floor.  Can you tell us more about these files and/or provide a sample
of these messages?

Thanks,

                Ilya
