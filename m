From: Libin Wu <hzwulibin@gmail.com>
Subject: Fwd: [ceph-users] poor performance when recovering
Date: Tue, 8 Dec 2015 09:13:18 +0800
Message-ID: <CAN4gH2OAEuRDORra1pua8MXgAsT6ME+zMpRG_O=2yKPDC7jO+A@mail.gmail.com>
References: <CAN4gH2P0WeVxXd1hDbc5T_-_2mBd4wsAiqDt=9sFXnY=AgikZQ@mail.gmail.com>
	<CAN4gH2P152bX-XeyqYc97XvHZqw624-x9AzgBfwXtXyFB0xptg@mail.gmail.com>
	<566597CF.3060903@ip-interactive.de>
	<CAN4gH2Ntpbza8S0GbMp86x=x=jYB=XcDjUZtbqSy7JYHmWSY8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33755 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114AbbLHBNU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Dec 2015 20:13:20 -0500
Received: by wmuu63 with SMTP id u63so1770083wmu.0
        for <ceph-devel@vger.kernel.org>; Mon, 07 Dec 2015 17:13:19 -0800 (PST)
In-Reply-To: <CAN4gH2Ntpbza8S0GbMp86x=x=jYB=XcDjUZtbqSy7JYHmWSY8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

---------- Forwarded message ----------
=46rom: Libin Wu <hzwulibin@gmail.com>
Date: 2015-12-08 9:12 GMT+08:00
Subject: Re: [ceph-users] poor performance when recovering
To: Oliver Dzombic <info@ip-interactive.de>
=E6=8A=84=E9=80=81=EF=BC=9A ceph-users <ceph-users@lists.ceph.com>


Yeah, we will upgrade in the near future. But i'm afraid the recovery
problem also existed in the hammer version.
So, why recovery affect performance so much, any plan to improve it?

2015-12-07 22:29 GMT+08:00 Oliver Dzombic <info@ip-interactive.de>:
> Hi,
>
> maybe you should first upgrade.
>
> "
>
>     Posted by sage
>     November 19th, 2015
>
> This is a bugfix release for Firefly.  As the Firefly 0.80.x series i=
s
> nearing its planned end of life in January 2016 it may also be the la=
st.
> "
>
> I think you are wasting time, trying to analyse/fix issues on a versi=
on
> which will be EOL in 3 weeks...
>
>
> --
> Mit freundlichen Gruessen / Best regards
>
> Oliver Dzombic
>
> Am 07.12.2015 um 15:26 schrieb Libin Wu:
>> Btw, my ceph version is 0.80.11
>>
>> 2015-12-07 21:45 GMT+08:00 Libin Wu <hzwulibin@gmail.com>:
>>> Hi, cephers
>>>
>>> I'm doing the performance test of ceph when recovering. The scene i=
s simple:
>>> 1. run fio on 6 krbd device
>>> 2. stop one OSD for 10 seconds
>>> 3. start that OSD
>>>
>>> However, when the OSD up and start recovering, the performance of f=
io
>>> drop down from 9k to 1k for about 20 seconds. At the same tiime, we
>>> found the SSD of that OSD's latency is more than 100ms, so it seems
>>> the SSD become the bottleneck=E3=80=82
>>>
>>> So we want to slow down the recovery speed to lighten the load of t=
he
>>> SSD when recovery. But configuration like:
>>>     osd_recovery_max_active
>>>     osd_recovery_max_chunk
>>>     osd_max_backfills
>>>     osd_recovery_op_priority
>>> are all useless.
>>>
>>> After reading and change some code, we want add a flow control in t=
he
>>> process of:
>>>     OSD::do_recovery
>>>
>>> So, will it be possible to do so and if this solution has some
>>> potential problem?
>>>
>>> Thanks!
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
