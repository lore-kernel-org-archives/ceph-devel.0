From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 23:25:57 +0200
Message-ID: <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>
References: <1395736765.2823.29.camel@localhost>
	<CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
	<53316D18.7040103@ieee.org>
	<CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
	<53317BC2.9010700@ieee.org>
	<CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
	<1395753516.2823.37.camel@localhost>
	<533184AF.9050101@ieee.org>
	<5331853D.40408@ieee.org>
	<1395767705.9967.5.camel@localhost>
	<5331C05D.1060008@ieee.org>
	<1395773582.2076.10.camel@localhost>
	<5331D2E8.6060002@ieee.org>
	<CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>
	<1395778894.2076.12.camel@localhost>
	<1395780835.2076.15.camel@localhost>
	<1395781847.2076.21.camel@localhost>
	<CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>
	<1395782577.2076.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:47527 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbaCYVZ6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 17:25:58 -0400
Received: by mail-qc0-f169.google.com with SMTP id i17so1536177qcy.0
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 14:25:57 -0700 (PDT)
In-Reply-To: <1395782577.2076.23.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Mar 25, 2014 at 11:22 PM, Olivier Bonvalet <ceph.list@daevel.fr=
> wrote:
> Le mardi 25 mars 2014 =E0 23:20 +0200, Ilya Dryomov a =E9crit :
>> On Tue, Mar 25, 2014 at 11:10 PM, Olivier Bonvalet <ceph.list@daevel=
=2Efr> wrote:
>> > The third (now with rbd_assort(0)) :
>> >
>> > Mar 25 22:08:12 alg kernel: [  598.301895] rbd_img_obj_callback: b=
ad image object request information:
>> > Mar 25 22:08:12 alg kernel: [  598.301900] obj_request ffff8802240=
9e1b8
>> > Mar 25 22:08:12 alg kernel: [  598.301901]     ->object_name <(nul=
l)>
>> > Mar 25 22:08:12 alg kernel: [  598.301902]     ->offset 0
>> > Mar 25 22:08:12 alg kernel: [  598.301903]     ->length 8192
>> > Mar 25 22:08:12 alg kernel: [  598.301904]     ->type 0x1
>> > Mar 25 22:08:12 alg kernel: [  598.301905]     ->flags 0x3
>> > Mar 25 22:08:12 alg kernel: [  598.301906]     ->which 4294967295
>> > Mar 25 22:08:12 alg kernel: [  598.301906]     ->xferred 8192
>> > Mar 25 22:08:12 alg kernel: [  598.301907]     ->result 0
>> > Mar 25 22:08:12 alg kernel: [  598.301908] img_request ffff8802303=
bff10
>> > Mar 25 22:08:12 alg kernel: [  598.301909]     ->snap 0xffff880227=
11f500
>> > Mar 25 22:08:12 alg kernel: [  598.301910]     ->offset 4492079104
>> > Mar 25 22:08:12 alg kernel: [  598.301911]     ->length 28672
>> > Mar 25 22:08:12 alg kernel: [  598.301912]     ->flags 0x1
>> > Mar 25 22:08:12 alg kernel: [  598.301913]     ->obj_request_count=
 0
>> > Mar 25 22:08:12 alg kernel: [  598.301913]     ->next_completion 2
>> > Mar 25 22:08:12 alg kernel: [  598.301914]     ->xferred 28672
>> > Mar 25 22:08:12 alg kernel: [  598.301915]     ->result 0
>> > Mar 25 22:08:12 alg kernel: [  598.301916]
>> > Mar 25 22:08:12 alg kernel: [  598.301916] Assertion failure in rb=
d_img_obj_callback() at line 2159:
>> > Mar 25 22:08:12 alg kernel: [  598.301916]
>> > Mar 25 22:08:12 alg kernel: [  598.301916]      rbd_assert(0);
>> > Mar 25 22:08:12 alg kernel: [  598.301916]
>> > Mar 25 22:08:12 alg kernel: [  598.302093] ------------[ cut here =
]------------
>>
>> Hmm...  Can you attach your drivers/block/rbd.c as of this third
>> occurence?
>>
>> Thanks,
>>
>>                 Ilya
>>
>
> Of course.

Sorry, I asked for the drivers/block/rbd.c C source file.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
