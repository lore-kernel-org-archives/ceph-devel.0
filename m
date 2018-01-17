From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: client isn't responding to mclientcaps
Date: Wed, 17 Jan 2018 14:47:54 +0800
Message-ID: <CAAM7YAmcOabyjiJwsdJmD4XSGx0JLmPAqaktZNU21Bzrck2aBQ@mail.gmail.com>
References: <CAJACTucim=9i_xOaVo-sJ7VuFEeTaK-hZvrqqrsKH7TpL0WK8g@mail.gmail.com>
 <CAAM7YA=zLKAS+CSSsCAHUZiQbNauSrBdJxKYoMATrukZhOQ5uA@mail.gmail.com>
 <CAJACTud8S++SJ4RdyzBiNHN1jQvzaD8pUAE-qz6CRMyBCzS=uQ@mail.gmail.com>
 <CAJACTud1L8nitFCXCr8KLFZnkiZui_gWGO3Crd3-LpRY1NmsVA@mail.gmail.com>
 <04E3D376-C095-44C1-9F61-1B0780138221@gmail.com> <CAJACTudqg6+pb7A4-p2npEFD=JAFas0=Qrh_9jBbgHSw-u18qw@mail.gmail.com>
 <A5875655-F788-425A-9C75-BACB9C1F99E3@gmail.com> <CAJACTudSPdx8jXkLFd=AiX6DmkVCt64BEeZ3WFjVPFdnhk8Rxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:42908 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeAQGrz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jan 2018 01:47:55 -0500
Received: by mail-ot0-f175.google.com with SMTP id s3so15910641otc.9
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jan 2018 22:47:55 -0800 (PST)
In-Reply-To: <CAJACTudSPdx8jXkLFd=AiX6DmkVCt64BEeZ3WFjVPFdnhk8Rxw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 17, 2018 at 2:40 PM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> On 17 January 2018 at 14:17, =E9=99=B6=E5=86=AC=E5=86=AC <tdd21151186@gma=
il.com> wrote:
>> but from your log, mds did not trying to revoke =E2=80=9CFr=E2=80=9D cap
>
> I mean, since the pending caps is "Fr", which is also a read, the
> issued "Fscr" seems not needed to revoked

The revoking caps is Fsc. This issue seems like
http://tracker.ceph.com/issues/18798
