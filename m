From: Chengguang Xu <cgxu519@icloud.com>
Subject: Re: Adding more checks for fscache options
Date: Wed, 31 Jan 2018 09:49:56 +0800
Message-ID: <FC60E345-F706-4F70-AD1F-3A4E4F37527A@icloud.com>
References: <8299B0B2-B1B2-4C85-A1FC-4C15740F32FA@icloud.com>
 <CAOi1vP__sp1uZZHPGKDFLFJOGq5Qv=ROzikRWmiHrCg-po+3Kg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv33p36im-asmtp002.me.com ([17.142.213.63]:23086 "EHLO
        pv33p36im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbeAaBuH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jan 2018 20:50:07 -0500
Received: from process-dkim-sign-daemon.pv33p36im-asmtp002.me.com by
 pv33p36im-asmtp002.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3E00E00D0E2D00@pv33p36im-asmtp002.me.com> for
 ceph-devel@vger.kernel.org; Wed, 31 Jan 2018 01:50:06 +0000 (GMT)
In-reply-to: <CAOi1vP__sp1uZZHPGKDFLFJOGq5Qv=ROzikRWmiHrCg-po+3Kg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Ilya

I looked at nfs code of option parsing and found nfs is the same as =
ceph,
but in 9P fscache related options are carefully surrounded by =
CONFIG_9P_FSCACHE,
if you agree this I=A1=AFll make a patch to handle this in ceph.



Thanks,
Chengguang.



> =D4=DA 2018=C4=EA1=D4=C230=C8=D5=A3=AC=CF=C2=CE=E79:39=A3=ACIlya =
Dryomov <idryomov@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On Tue, Jan 30, 2018 at 2:17 PM, Chengguang Xu <cgxu519@icloud.com> =
wrote:
>> Hi Zheng, Ilya
>>=20
>> Recently I=A1=AFve just tested some mount option of cephfs and found =
though
>> fscache kernel module was disabled but when I specified -o fsc to =
mount.ceph
>> there is no any indication of warning or failure.
>>=20
>> I think it may cause enduser's misunderstanding of fscache function,
>> so I plan to add extra checks to parsing fscache related options in =
kernel side.
>>=20
>> There are two approaches as below, could you tell me which will be =
better?
>>=20
>> If we get conflict condition about fscache.
>>=20
>> A. Print error message && Exit mount immediately
>>=20
>> B. Only print error message but continue mount process.
>=20
> Hi Chengguang,
>=20
> I'd look at and follow nfs behaviour here.
>=20
> Thanks,
>=20
>                Ilya

