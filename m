From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Journaler::_flush
Date: Mon, 27 Nov 2017 17:11:08 +0800
Message-ID: <CAAM7YAkwCfTojuj5xpB6fT+QfgsjOwSfCTotWVeyZqW6MBrmEw@mail.gmail.com>
References: <3E5F298A-2C7C-4E70-893F-A624A7C6BB10@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:39872 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdK0JLJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Nov 2017 04:11:09 -0500
Received: by mail-oi0-f45.google.com with SMTP id r190so18873518oie.6
        for <ceph-devel@vger.kernel.org>; Mon, 27 Nov 2017 01:11:09 -0800 (PST)
In-Reply-To: <3E5F298A-2C7C-4E70-893F-A624A7C6BB10@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>

On Sun, Nov 26, 2017 at 11:19 PM, =E9=99=B6=E5=86=AC=E5=86=AC <tdd21151186@=
gmail.com> wrote:
> Hi Zheng,
>
> i  have one question about Journaler flush,
> suppose there are two in flight flushes ?
> first is flushing (a, b),  second is flushing (b+1, c)
> let's assume these two range belong to two adjacent objects.
> is that possible that the second flush got the reply first ?

yes

> if that so, the safe_pos would be wrong ?
>

no. check Journaler::_finish_flush



> Thanks,
> Dongdong
