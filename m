From: Chengguang Xu <cgxu519@icloud.com>
Subject: Re: osdmap consistency during incremental applying in kernel client
Date: Mon, 12 Feb 2018 18:44:31 +0800
Message-ID: <58F2BA12-2C4D-4C35-BC8D-F4896D22F41C@icloud.com>
References: <302D379F-727B-489C-B257-633CF16577C8@icloud.com>
 <CAOi1vP9j=hBeZ73oguLBuXp-YDE5tk3h=HU5_MDJgOxY300kFQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv33p36im-asmtp002.me.com ([17.142.213.63]:28597 "EHLO
        pv33p36im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbeBLKol (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 05:44:41 -0500
Received: from process-dkim-sign-daemon.pv33p36im-asmtp002.me.com by
 pv33p36im-asmtp002.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P4100E009RIQF00@pv33p36im-asmtp002.me.com> for
 ceph-devel@vger.kernel.org; Mon, 12 Feb 2018 10:44:40 +0000 (GMT)
In-reply-to: <CAOi1vP9j=hBeZ73oguLBuXp-YDE5tk3h=HU5_MDJgOxY300kFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Ilya

Thanks for reply, please let me ask one more question, is there
no side-effect to ceph cluster side?

Thanks,
Chengguang.



> =D4=DA 2018=C4=EA2=D4=C212=C8=D5=A3=AC=CF=C2=CE=E75:37=A3=ACIlya =
Dryomov <idryomov@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On Mon, Feb 12, 2018 at 5:05 AM, Chengguang Xu <cgxu519@icloud.com> =
wrote:
>> Hi All,
>>=20
>> In ceph kernel client, osdmap_apply_incremental() can fail by failing =
of
>> allocation memory in many places, in this case, current osdmap can =
not
>> keep consistency after applying failure.
>>=20
>> I=A1=AFm not sure how much impact will be caused by this kind of =
inconsistency
>> but for safety it=A1=AFs better to keep osdmap consistency all the =
time even
>> failing from incremental applying.
>=20
> Hi Chengguang,
>=20
> Well, in practice those are rather small allocations, so if you see =
any
> of them failing, the system is likely in deep trouble.  In theory it =
is
> a valid point though.
>=20
> Thanks,
>=20
>                Ilya

