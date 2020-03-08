From: XuYun <yunxu@me.com>
Subject: Re: [ceph-users] ceph rbd volumes/images IO details
Date: Sun, 8 Mar 2020 14:58:42 +0800
Message-ID: <B6D7DD2C-7F32-40D0-A24B-CE955B33438F@me.com>
References: <CANA9Uk54Ygo98sjozbU_HcAGjocSV2ui=-=imrDTCpdLOHhx6Q@mail.gmail.com>
 <CANA9Uk5eR41ZBYU_XGpgQoLwO8MnGTFuu6L+OKKvEBhs2YXCiA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv50p00im-zteg10011401.me.com ([17.58.6.41]:49912 "EHLO
        pv50p00im-zteg10011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbgCHHFn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Mar 2020 03:05:43 -0400
In-Reply-To: <CANA9Uk5eR41ZBYU_XGpgQoLwO8MnGTFuu6L+OKKvEBhs2YXCiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: M Ranga Swami Reddy <swamireddy@gmail.com>
Cc: ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, Brad Hubbard <bhubbard@redhat.com>, Robert LeBlanc <robert@leblancnet.us>, ceph-users <ceph-users@ceph.com>, Ceph Community <ceph-community@lists.ceph.com>

You can enable prometheus module of mgr if you are running Nautilus.

> 2020=E5=B9=B43=E6=9C=888=E6=97=A5 =E4=B8=8A=E5=8D=882:15=EF=BC=8CM =
Ranga Swami Reddy <swamireddy@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Mar 6, 2020 at 1:06 AM M Ranga Swami Reddy =
<swamireddy@gmail.com>
> wrote:
>=20
>> Hello,
>> Can we get the IOPs of any rbd image/volume?
>>=20
>> For ex: I have created volumes via OpenStack Cinder. Want to know
>> the IOPs of these volumes.
>>=20
>> In general - we can get pool stats, but not seen the per volumes =
stats.
>>=20
>> Any hint here? Appreciated.
>>=20
> _______________________________________________
> ceph-users mailing list -- ceph-users@ceph.io
> To unsubscribe send an email to ceph-users-leave@ceph.io
