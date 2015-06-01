From: Jan Schermer <jan@schermer.cz>
Subject: Re: [ceph-users] Discuss: New default recovery config settings
Date: Mon, 1 Jun 2015 11:01:14 +0200
Message-ID: <B5257B32-FF5E-43E9-87CD-BA86CB1C9BD8@schermer.cz>
References: <1939533999.9756941.1432935747903.JavaMail.zimbra@redhat.com> <1394947829.9758745.1432936033017.JavaMail.zimbra@redhat.com> <CAC6JEv8LyM1SRsOszDCj6tLxhZ=hvrEkinDARW8BvyQHDCz+LQ@mail.gmail.com> <9555849C-7C6E-485E-B60C-BB4996F96E32@schermer.cz> <CABAwU-bCuFrRHDO-48dAS=DWzpUek1yxoWbL2w8LNh_K47zk_w@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38139 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbbFAJBR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jun 2015 05:01:17 -0400
Received: by wizo1 with SMTP id o1so95825872wiz.1
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2015 02:01:15 -0700 (PDT)
In-Reply-To: <CABAwU-bCuFrRHDO-48dAS=DWzpUek1yxoWbL2w8LNh_K47zk_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: Gregory Farnum <greg@gregs42.com>, Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Slow requests are not exactly tied to the PG number, but we were gettin=
g slow requests whenever backfills or recoveries fired up - increasing =
the number of PGs helped with this as the =E2=80=9Cblocks=E2=80=9D of w=
ork are much smaller than before.

We have roughly the same number of OSDs as you but only one really impo=
rtant pool (=E2=80=9Cvolumes=E2=80=9D), we ended with 16384 PGs for thi=
s one.
Number of threads increased exponentionaly, some latencies wet down, so=
me went up, in the end it works just as well as before with the added b=
enefit of better data distribution and a better behaving cluster.
But YMMV - once you go up you can=E2=80=99t go down.

Jan


> On 01 Jun 2015, at 10:57, huang jun <hjwsm1989@gmail.com> wrote:
>=20
> hi,jan
>=20
> 2015-06-01 15:43 GMT+08:00 Jan Schermer <jan@schermer.cz>:
>> We had to disable deep scrub or the cluster would me unusable - we n=
eed to turn it back on sooner or later, though.
>> With minimal scrubbing and recovery settings, everything is mostly g=
ood. Turned out many issues we had were due to too few PGs - once we in=
creased them from 4K to 16K everything sped up nicely (because the chun=
ks are smaller), but during heavy activity we are still getting some =E2=
=80=9Cslow IOs=E2=80=9D.
>=20
> How many PGs do you set ?  we get "slow requests" many times, but
> didn't relate it to PG number.
> And we follow the equation below for every pool:
>=20
>                    (OSDs * 100)
> Total PGs =3D  ---------------------
>                      pool size
> our cluster has 157 OSDs and 3 POOLs, we set pg_num to  8192 for ever=
y pool,
> but osd cpu utlity percentage is up to 300% after restart, we think
> it's  loading pgs during the period.
> and we will try different PG number when we get "slow request"
>=20
> thanks!
>=20
>> I believe there is an ionice knob in newer versions (we still run Du=
mpling), and that should do the trick no matter how much additional =E2=
=80=9Cload=E2=80=9D is put on the OSDs.
>> Everybody=E2=80=99s bottleneck will be different - we run all flash =
so disk IO is not a problem but an OSD daemon is - no ionice setting wi=
ll help with that, it just needs to be faster ;-)
>>=20
>> Jan
>>=20
>>=20
>>> On 30 May 2015, at 01:17, Gregory Farnum <greg@gregs42.com> wrote:
>>>=20
>>> On Fri, May 29, 2015 at 2:47 PM, Samuel Just <sjust@redhat.com> wro=
te:
>>>> Many people have reported that they need to lower the osd recovery=
 config options to minimize the impact of recovery on client io.  We ar=
e talking about changing the defaults as follows:
>>>>=20
>>>> osd_max_backfills to 1 (from 10)
>>>> osd_recovery_max_active to 3 (from 15)
>>>> osd_recovery_op_priority to 1 (from 10)
>>>> osd_recovery_max_single_start to 1 (from 5)
>>>=20
>>> I'm under the (possibly erroneous) impression that reducing the num=
ber
>>> of max backfills doesn't actually reduce recovery speed much (but w=
ill
>>> reduce memory use), but that dropping the op priority can. I'd rath=
er
>>> we make users manually adjust values which can have a material impa=
ct
>>> on their data safety, even if most of them choose to do so.
>>>=20
>>> After all, even under our worst behavior we're still doing a lot
>>> better than a resilvering RAID array. ;)
>>> -Greg
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
> --=20
> thanks
> huangjun

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
