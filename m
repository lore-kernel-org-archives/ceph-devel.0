From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Adding more checks for fscache options
Date: Tue, 30 Jan 2018 14:39:15 +0100
Message-ID: <CAOi1vP__sp1uZZHPGKDFLFJOGq5Qv=ROzikRWmiHrCg-po+3Kg@mail.gmail.com>
References: <8299B0B2-B1B2-4C85-A1FC-4C15740F32FA@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:36422 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeA3NjQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jan 2018 08:39:16 -0500
Received: by mail-io0-f180.google.com with SMTP id l17so11491774ioc.3
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jan 2018 05:39:16 -0800 (PST)
In-Reply-To: <8299B0B2-B1B2-4C85-A1FC-4C15740F32FA@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jan 30, 2018 at 2:17 PM, Chengguang Xu <cgxu519@icloud.com> wrote:
> Hi Zheng, Ilya
>
> Recently I=E2=80=99ve just tested some mount option of cephfs and found t=
hough
> fscache kernel module was disabled but when I specified -o fsc to mount.c=
eph
> there is no any indication of warning or failure.
>
> I think it may cause enduser's misunderstanding of fscache function,
> so I plan to add extra checks to parsing fscache related options in kerne=
l side.
>
> There are two approaches as below, could you tell me which will be better=
?
>
> If we get conflict condition about fscache.
>
> A. Print error message && Exit mount immediately
>
> B. Only print error message but continue mount process.

Hi Chengguang,

I'd look at and follow nfs behaviour here.

Thanks,

                Ilya
