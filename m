From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: Computation in the storage
Date: Sun, 4 Dec 2016 15:02:13 -0800
Message-ID: <CAB2gnbVn0U_G12L8XV=hbznB2i_TMo40TpC5cVzJZKOr_MAQ7Q@mail.gmail.com>
References: <26283_1480676624_58415510_26283_122_1_EBBC07637B509B40B2E594A11E62C54F022DA808@OPEXCLILM32.corporate.adroot.infra.ftgroup>
 <d8129d7a-af37-ad74-38c8-f5a9d59f183b@suse.de> <CAF-wwdHPXaX3fe+dk9ovdAfc00N5xQrzj2TaRAuBOjH77L4yDg@mail.gmail.com>
 <200977EA-767F-41DA-9912-143C403D5D7B@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34101 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbcLDXCP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Dec 2016 18:02:15 -0500
Received: by mail-oi0-f54.google.com with SMTP id y198so322362306oia.1
        for <ceph-devel@vger.kernel.org>; Sun, 04 Dec 2016 15:02:14 -0800 (PST)
In-Reply-To: <200977EA-767F-41DA-9912-143C403D5D7B@Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Joao Eduardo Luis <joao@suse.de>, "nebil.benmabrouk@orange.com" <nebil.benmabrouk@orange.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Dec 2, 2016 at 3:04 PM, Kamble, Nitin A
<Nitin.Kamble@teradata.com> wrote:
>
> Is anybody using real RADOS object classes on ceph clusters? Any of them on github?
> I would like to look at some of the real world examples if it is there.
> And more documentation of this feature would definitely help too.

We use object classes [0] for a distributed shared log [1] on Ceph.

[0]: https://github.com/noahdesu/ceph/blob/zlog/jewel/src/cls/zlog/cls_zlog.cc
[1]: https://github.com/noahdesu/zlog
