From: =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KHQsNGF0LjQvdC+0LI=?=
	<sakhinov@gmail.com>
Subject: Re: inconsistent pgs
Date: Mon, 10 Aug 2015 22:08:31 +0300
Message-ID: <CAJnOFArUmwW40=5-7HOF47y2JRcHPmLqyumt8G2h4ScyMhvPYw@mail.gmail.com>
References: <CAJnOFAqRjXcuO0bJN8PSLsnnMhBjYMOTJTFY8T+4Z36LaBiMfg@mail.gmail.com>
 <alpine.DEB.2.00.1508090712130.22099@cobra.newdream.net> <CAJnOFApACz47rukJpf50sY2hBvLoPM1+ZuSoTyaWXykxprrmtA@mail.gmail.com>
 <alpine.DEB.2.00.1508100531290.22099@cobra.newdream.net> <CAJnOFAqSX1UQ1iEFdHoNAoBXoxvRKOH60F1mPt-zR+w9veTSJQ@mail.gmail.com>
 <alpine.DEB.2.00.1508100641160.22099@cobra.newdream.net> <90559C83A9C7FA45B5846C975DFA612DDB53476094@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37235 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932598AbbHJTIw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Aug 2015 15:08:52 -0400
Received: by wibhh20 with SMTP id hh20so164027325wib.0
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2015 12:08:51 -0700 (PDT)
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB53476094@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Da=C5=82ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage, Piotr, sorry for your time and thanx for your help.
Memtest showed me red results. Will be digging for bad memory chips.

Thanks again.

=D0=A1=D0=B0=D1=85=D0=B8=D0=BD=D0=BE=D0=B2 =D0=9A=D0=BE=D0=BD=D1=81=D1=82=
=D0=B0=D0=BD=D1=82=D0=B8=D0=BD
=D1=82=D0=B5=D0=BB.: +7 (909) 945-89-42


2015-08-10 16:58 GMT+03:00 Da=C5=82ek, Piotr <Piotr.Dalek@ts.fujitsu.co=
m>:
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Sage Weil
>> Sent: Monday, August 10, 2015 3:52 PM
>> To: =D0=9A=D0=BE=D0=BD=D1=81=D1=82=D0=B0=D0=BD=D1=82=D0=B8=D0=BD =D0=
=A1=D0=B0=D1=85=D0=B8=D0=BD=D0=BE=D0=B2
>>
>> On Mon, 10 Aug 2015, ?????????? ??????? wrote:
>> > Uploaded another corrupted piece.
>> >
>> > 2015-08-10 16:18:40.027726 7f7979697700 -1 log_channel(cluster) lo=
g
>> > [ERR] : be_compare_scrubmaps: 3.fd shard 6: soid
>> > f2e832fd/rbd_data.ab7174b0dc51.0000000000000249/head//3 data_diges=
t
>> > 0x64e94460 !=3D known data_digest 0xaec3bea8 from auth shard 10
>> >
>> > # ceph-post-file ceph-6-rbd_data.ab7174b0dc51.0000000000000249
>> > ceph-post-file: e96e5828-b97c-45f1-8e3f-23abbf700865
>> >
>> > # ceph-post-file ceph-10-rbd_data.ab7174b0dc51.0000000000000249
>> > ceph-post-file: e1277a33-74a5-4d46-93c8-266bd81867db
>> >
>> > I dont' think of bad disk:
>> > - all OSDs SMART is clean,
>> > - I tried to ceph pg repair 3.d8 on another OSDs in the past with =
the
>> > same result. Then I rebalanced the cluster so that pg 3.d8 moved t=
o
>> > [7,1].
>>
>> Again, it's all single bit changes:
>>
>> [..]
>>
>> It looks like it's also always the least significant bit in a 4-byte=
 word.
>>
>> Can you see if there is any pattern to which OSDs are used for the
>> inconsistent PGs?
>
> I would check machines that host those PGs for memory errors, especia=
lly if they don't have ECC RAM sticks or ECC feature is disabled.
> http://www.memtest.org/ is a good tool for this purpose.
>
> With best regards / Pozdrawiam
> Piotr Da=C5=82ek
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
