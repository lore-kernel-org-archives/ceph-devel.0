From: Jens Axboe <axboe@kernel.dk>
Subject: Re: About Fio backend with ObjectStore API
Date: Tue, 30 Jun 2015 16:57:50 -0600
Message-ID: <55931EEE.9070604@kernel.dk>
References: <CACJqLyZcAzb5wocrN8b8WoK6j3ynWF-_3=T+1aQkDko4Mv_SmQ@mail.gmail.com>	<99767EA2E27DD44DB4E9F9B9ACA458C03B319D0D@SSIEXCH-MB3.ssi.samsung.com> <CAMeBU_3ty6ae5VXP=_D8py1_Pk4rLKxCa4Larz0oKnyTYDtz8w@mail.gmail.com> <99767EA2E27DD44DB4E9F9B9ACA458C03B319DF2@SSIEXCH-MB3.ssi.samsung.com> <55931A5E.5000408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:32831 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbbF3W5y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jun 2015 18:57:54 -0400
Received: by pdjd13 with SMTP id d13so13746581pdj.0
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 15:57:52 -0700 (PDT)
In-Reply-To: <55931A5E.5000408@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, Casey Bodley <cbodley@gmail.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, daniel.gollub@gmail.com

I'd be more than happy to include it. Daniel has contributed to fio bef=
ore.

Daniel (CC'ed), was it your intent to get this upstream? How do we make=
=20
this happen?


On 06/30/2015 04:38 PM, Mark Nelson wrote:
> It would be fantastic if folks decided to work on this and got it pus=
hed
> upstream into fio proper. :D
>
> Mark
>
> On 06/30/2015 04:19 PM, James (Fei) Liu-SSI wrote:
>> Hi Casey,
>>
>>    Thanks a lot.
>>
>>    Regards,
>>    James
>>
>> -----Original Message-----
>> From: Casey Bodley [mailto:cbodley@gmail.com]
>> Sent: Tuesday, June 30, 2015 2:16 PM
>> To: James (Fei) Liu-SSI
>> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>> Subject: Re: About Fio backend with ObjectStore API
>>
>> Hi,
>>
>> When Danny Al-Gaaf & Daniel Gollub published "Ceph Performance
>> Analysis: fio and RBD" at
>> https://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-anal=
ysis_fio_rbd.html,
>>
>> they also mentioned a fio engine that linked directly into ceph's
>> FileStore. I was able to find Daniel's branch on github at
>> https://github.com/gollub/ceph/tree/fio_filestore_v2, and did some
>> more work on it at the time.
>>
>> I just rebased that work onto the latest ceph master branch, and
>> pushed to our github at
>> https://github.com/linuxbox2/linuxbox-ceph/tree/fio-objectstore. You
>> can find the source in src/test/fio_ceph_filestore.cc, and run fio
>> with the provided example fio job file in src/test/filestore.fio.
>>
>> I didn't have a chance to confirm that it builds with automake, but
>> the cmake version built for me. I'm happy to help if you run into
>> problems, Casey
>>
>> On Tue, Jun 30, 2015 at 2:31 PM, James (Fei) Liu-SSI
>> <james.liu@ssi.samsung.com> wrote:
>>> Hi Haomai,
>>>    What are you trying to ask is to benchmark local objectstore(lik=
e
>>> kvstore/filestore/newstore) locally with FIO(ObjectStore engine)? Y=
ou
>>> want to purely compare the performance locally for these
>>> objectstores, right?
>>>
>>>    Regards,
>>>    James
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wang
>>> Sent: Tuesday, June 30, 2015 9:06 AM
>>> To: ceph-devel@vger.kernel.org
>>> Subject: About Fio backend with ObjectStore API
>>>
>>> Hi all,
>>>
>>> Long long ago, is there someone said about fio backend with Ceph
>>> ObjectStore API? So we could use the existing mature fio facility t=
o
>>> benchmark ceph objectstore.
>>>
>>> --
>>> Best Regards,
>>>
>>> Wheat
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o
>>> info at  http://vger.kernel.org/majordomo-info.html
>> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>>
>>


--=20
Jens Axboe

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
