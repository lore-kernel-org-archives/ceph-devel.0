From: =?gb2312?B?zNW2rLas?= <tdd21151186@gmail.com>
Subject: Re: client isn't responding to mclientcaps
Date: Wed, 17 Jan 2018 14:17:51 +0800
Message-ID: <A5875655-F788-425A-9C75-BACB9C1F99E3@gmail.com>
References: <CAJACTucim=9i_xOaVo-sJ7VuFEeTaK-hZvrqqrsKH7TpL0WK8g@mail.gmail.com>
 <CAAM7YA=zLKAS+CSSsCAHUZiQbNauSrBdJxKYoMATrukZhOQ5uA@mail.gmail.com>
 <CAJACTud8S++SJ4RdyzBiNHN1jQvzaD8pUAE-qz6CRMyBCzS=uQ@mail.gmail.com>
 <CAJACTud1L8nitFCXCr8KLFZnkiZui_gWGO3Crd3-LpRY1NmsVA@mail.gmail.com>
 <04E3D376-C095-44C1-9F61-1B0780138221@gmail.com>
 <CAJACTudqg6+pb7A4-p2npEFD=JAFas0=Qrh_9jBbgHSw-u18qw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:34833 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeAQGR5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jan 2018 01:17:57 -0500
Received: by mail-it0-f54.google.com with SMTP id e1so7746106ita.0
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jan 2018 22:17:57 -0800 (PST)
In-Reply-To: <CAJACTudqg6+pb7A4-p2npEFD=JAFas0=Qrh_9jBbgHSw-u18qw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

but from your log, mds did not trying to revoke =A1=B0Fr=A1=B1 cap
> =D4=DA 2018=C4=EA1=D4=C217=C8=D5=A3=AC=CF=C2=CE=E72:14=A3=ACXuehan Xu =
<xxhdx1985126@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On 17 January 2018 at 13:15, =CC=D5=B6=AC=B6=AC =
<tdd21151186@gmail.com> wrote:
>> Hi Xuehan,
>> Fsc need to be revoked if another client is trying to write the file =
at the same time.
>> because the cache of the =A1=B0read=A1=B1 client may not be valid any =
more.
>=20
> I understand that, but the pending caps is "Fr" which is also a "read"
> cap, so I think maybe the issued caps doesn't need to be revoked

