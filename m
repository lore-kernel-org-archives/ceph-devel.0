From: huang jun <hjwsm1989@gmail.com>
Subject: Re: [ceph-users] Discuss: New default recovery config settings
Date: Mon, 1 Jun 2015 16:57:06 +0800
Message-ID: <CABAwU-bCuFrRHDO-48dAS=DWzpUek1yxoWbL2w8LNh_K47zk_w@mail.gmail.com>
References: <1939533999.9756941.1432935747903.JavaMail.zimbra@redhat.com>
	<1394947829.9758745.1432936033017.JavaMail.zimbra@redhat.com>
	<CAC6JEv8LyM1SRsOszDCj6tLxhZ=hvrEkinDARW8BvyQHDCz+LQ@mail.gmail.com>
	<9555849C-7C6E-485E-B60C-BB4996F96E32@schermer.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36193 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbbFAI5I convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jun 2015 04:57:08 -0400
Received: by lbbqq2 with SMTP id qq2so79914867lbb.3
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2015 01:57:06 -0700 (PDT)
In-Reply-To: <9555849C-7C6E-485E-B60C-BB4996F96E32@schermer.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Schermer <jan@schermer.cz>
Cc: Gregory Farnum <greg@gregs42.com>, Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

hi,jan

2015-06-01 15:43 GMT+08:00 Jan Schermer <jan@schermer.cz>:
> We had to disable deep scrub or the cluster would me unusable - we ne=
ed to turn it back on sooner or later, though.
> With minimal scrubbing and recovery settings, everything is mostly go=
od. Turned out many issues we had were due to too few PGs - once we inc=
reased them from 4K to 16K everything sped up nicely (because the chunk=
s are smaller), but during heavy activity we are still getting some =E2=
=80=9Cslow IOs=E2=80=9D.

How many PGs do you set ?  we get "slow requests" many times, but
didn't relate it to PG number.
And we follow the equation below for every pool:

                    (OSDs * 100)
Total PGs =3D  ---------------------
                      pool size
our cluster has 157 OSDs and 3 POOLs, we set pg_num to  8192 for every =
pool,
but osd cpu utlity percentage is up to 300% after restart, we think
it's  loading pgs during the period.
and we will try different PG number when we get "slow request"

thanks!

> I believe there is an ionice knob in newer versions (we still run Dum=
pling), and that should do the trick no matter how much additional =E2=80=
=9Cload=E2=80=9D is put on the OSDs.
> Everybody=E2=80=99s bottleneck will be different - we run all flash s=
o disk IO is not a problem but an OSD daemon is - no ionice setting wil=
l help with that, it just needs to be faster ;-)
>
> Jan
>
>
>> On 30 May 2015, at 01:17, Gregory Farnum <greg@gregs42.com> wrote:
>>
>> On Fri, May 29, 2015 at 2:47 PM, Samuel Just <sjust@redhat.com> wrot=
e:
>>> Many people have reported that they need to lower the osd recovery =
config options to minimize the impact of recovery on client io.  We are=
 talking about changing the defaults as follows:
>>>
>>> osd_max_backfills to 1 (from 10)
>>> osd_recovery_max_active to 3 (from 15)
>>> osd_recovery_op_priority to 1 (from 10)
>>> osd_recovery_max_single_start to 1 (from 5)
>>
>> I'm under the (possibly erroneous) impression that reducing the numb=
er
>> of max backfills doesn't actually reduce recovery speed much (but wi=
ll
>> reduce memory use), but that dropping the op priority can. I'd rathe=
r
>> we make users manually adjust values which can have a material impac=
t
>> on their data safety, even if most of them choose to do so.
>>
>> After all, even under our worst behavior we're still doing a lot
>> better than a resilvering RAID array. ;)
>> -Greg
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
thanks
huangjun
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
