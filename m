From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: client isn't responding to mclientcaps
Date: Wed, 17 Jan 2018 14:14:35 +0800
Message-ID: <CAJACTudqg6+pb7A4-p2npEFD=JAFas0=Qrh_9jBbgHSw-u18qw@mail.gmail.com>
References: <CAJACTucim=9i_xOaVo-sJ7VuFEeTaK-hZvrqqrsKH7TpL0WK8g@mail.gmail.com>
 <CAAM7YA=zLKAS+CSSsCAHUZiQbNauSrBdJxKYoMATrukZhOQ5uA@mail.gmail.com>
 <CAJACTud8S++SJ4RdyzBiNHN1jQvzaD8pUAE-qz6CRMyBCzS=uQ@mail.gmail.com>
 <CAJACTud1L8nitFCXCr8KLFZnkiZui_gWGO3Crd3-LpRY1NmsVA@mail.gmail.com> <04E3D376-C095-44C1-9F61-1B0780138221@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:39630 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeAQGOh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jan 2018 01:14:37 -0500
Received: by mail-oi0-f47.google.com with SMTP id t8so12371287oie.6
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jan 2018 22:14:37 -0800 (PST)
In-Reply-To: <04E3D376-C095-44C1-9F61-1B0780138221@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 17 January 2018 at 13:15, =E9=99=B6=E5=86=AC=E5=86=AC <tdd21151186@gmail=
.com> wrote:
> Hi Xuehan,
>  Fsc need to be revoked if another client is trying to write the file at =
the same time.
>  because the cache of the =E2=80=9Cread=E2=80=9D client may not be valid =
any more.

I understand that, but the pending caps is "Fr" which is also a "read"
cap, so I think maybe the issued caps doesn't need to be revoked
