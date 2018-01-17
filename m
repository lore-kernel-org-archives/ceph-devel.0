From: =?gb2312?B?zNW2rLas?= <tdd21151186@gmail.com>
Subject: Re: client isn't responding to mclientcaps
Date: Wed, 17 Jan 2018 13:15:37 +0800
Message-ID: <04E3D376-C095-44C1-9F61-1B0780138221@gmail.com>
References: <CAJACTucim=9i_xOaVo-sJ7VuFEeTaK-hZvrqqrsKH7TpL0WK8g@mail.gmail.com>
 <CAAM7YA=zLKAS+CSSsCAHUZiQbNauSrBdJxKYoMATrukZhOQ5uA@mail.gmail.com>
 <CAJACTud8S++SJ4RdyzBiNHN1jQvzaD8pUAE-qz6CRMyBCzS=uQ@mail.gmail.com>
 <CAJACTud1L8nitFCXCr8KLFZnkiZui_gWGO3Crd3-LpRY1NmsVA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:41640 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbeAQFPn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jan 2018 00:15:43 -0500
Received: by mail-pg0-f41.google.com with SMTP id 136so10137852pgd.8
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jan 2018 21:15:43 -0800 (PST)
In-Reply-To: <CAJACTud1L8nitFCXCr8KLFZnkiZui_gWGO3Crd3-LpRY1NmsVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Xuehan,
 Fsc need to be revoked if another client is trying to write the file at =
the same time.
 because the cache of the =A1=B0read=A1=B1 client may not be valid any =
more.
> =D4=DA 2018=C4=EA1=D4=C217=C8=D5=A3=AC=C9=CF=CE=E711:24=A3=ACXuehan Xu =
<xxhdx1985126@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On 17 January 2018 at 10:58, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>> On 17 January 2018 at 10:06, Yan, Zheng <ukernel@gmail.com> wrote:
>>> On Tue, Jan 16, 2018 at 5:06 PM, Xuehan Xu <xxhdx1985126@gmail.com> =
wrote:
>>>> Hi, everyone.
>>>>=20
>>>> In our online cephfs, we occasionally encounter the error "Client.
>>>> isn't responding to mclientcaps", the client kernel we are using is
>>>> centos's "3.10.0-514".
>>>=20
>>> Is the error persistent and just temporary ?
>>>=20
>>=20
>> It's temporary, but lasts for about 1.5 minutes, and the cephfs
>> cluster is under no heavy load.
>> Thanks:-)
>=20
> By the way, in our logs, there is such statements: "client.4607906
> isn't responding to mclientcaps(revoke), ino 0x10000001d30 pending
> pAsLsXsFr issued pAsLsXsFscr, sent 62.743469 seconds ago"
>=20
> It seems that "Fscr" is all read capabilities, and "Fr" is all read
> capabilities, so it seems that the "issued" caps doesn't need to be
> revoked. Is this right?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

