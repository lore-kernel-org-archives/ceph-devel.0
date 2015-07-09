From: Casey Bodley <cbodley@gmail.com>
Subject: Re: About Fio backend with ObjectStore API
Date: Thu, 9 Jul 2015 12:19:27 -0400
Message-ID: <CAMeBU_3eyRiEvgG=sPe3m=QiQiRBkeVquBpo+XpJ4GtTq4K+8Q@mail.gmail.com>
References: <CACJqLyZcAzb5wocrN8b8WoK6j3ynWF-_3=T+1aQkDko4Mv_SmQ@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B319D0D@SSIEXCH-MB3.ssi.samsung.com>
	<CAMeBU_3ty6ae5VXP=_D8py1_Pk4rLKxCa4Larz0oKnyTYDtz8w@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B319DF2@SSIEXCH-MB3.ssi.samsung.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B31A700@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34958 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbbGIQT2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jul 2015 12:19:28 -0400
Received: by qkbp125 with SMTP id p125so189098256qkb.2
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jul 2015 09:19:27 -0700 (PDT)
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C03B31A700@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi James,

In the job file src/test/filestore.fio, you can modify the line
"objectstore=3Dfilestore" to use any objectstore type supported by the
ObjectStore::create() factory.

Casey

On Wed, Jul 8, 2015 at 8:02 PM, James (Fei) Liu-SSI
<james.liu@ssi.samsung.com> wrote:
> Hi Casey,
>   Quick questions, The code in the trunk only cover the test for file=
store. I was wondering do you have any plan to cover the test for kvsto=
re and newstore?
>
>   Thanks,
>   James
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of James (Fei) Liu-SSI
> Sent: Tuesday, June 30, 2015 2:19 PM
> To: Casey Bodley
> Cc: Haomai Wang; ceph-devel@vger.kernel.org
> Subject: RE: About Fio backend with ObjectStore API
>
> Hi Casey,
>
>   Thanks a lot.
>
>   Regards,
>   James
>
> -----Original Message-----
> From: Casey Bodley [mailto:cbodley@gmail.com]
> Sent: Tuesday, June 30, 2015 2:16 PM
> To: James (Fei) Liu-SSI
> Cc: Haomai Wang; ceph-devel@vger.kernel.org
> Subject: Re: About Fio backend with ObjectStore API
>
> Hi,
>
> When Danny Al-Gaaf & Daniel Gollub published "Ceph Performance
> Analysis: fio and RBD" at
> https://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-analy=
sis_fio_rbd.html,
> they also mentioned a fio engine that linked directly into ceph's Fil=
eStore. I was able to find Daniel's branch on github at https://github.=
com/gollub/ceph/tree/fio_filestore_v2, and did some more work on it at =
the time.
>
> I just rebased that work onto the latest ceph master branch, and push=
ed to our github at https://github.com/linuxbox2/linuxbox-ceph/tree/fio=
-objectstore. You can find the source in src/test/fio_ceph_filestore.cc=
, and run fio with the provided example fio job file in src/test/filest=
ore.fio.
>
> I didn't have a chance to confirm that it builds with automake, but t=
he cmake version built for me. I'm happy to help if you run into proble=
ms, Casey
>
> On Tue, Jun 30, 2015 at 2:31 PM, James (Fei) Liu-SSI <james.liu@ssi.s=
amsung.com> wrote:
>> Hi Haomai,
>>   What are you trying to ask is to benchmark local objectstore(like =
kvstore/filestore/newstore) locally with FIO(ObjectStore engine)? You w=
ant to purely compare the performance locally for these objectstores, r=
ight?
>>
>>   Regards,
>>   James
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wang
>> Sent: Tuesday, June 30, 2015 9:06 AM
>> To: ceph-devel@vger.kernel.org
>> Subject: About Fio backend with ObjectStore API
>>
>> Hi all,
>>
>> Long long ago, is there someone said about fio backend with Ceph Obj=
ectStore API? So we could use the existing mature fio facility to bench=
mark ceph objectstore.
>>
>> --
>> Best Regards,
>>
>> Wheat
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>   {.n +       +%  lzwm  b =EB=A7=B2  r  y=C7=A9 =D7=AFzX     =DC=A8} =
  =C6=A0z &j:+v        zZ+  +zf   h   ~    i   z   w   ?    & )=DF=A2 f
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
