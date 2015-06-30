From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: About Fio backend with ObjectStore API
Date: Tue, 30 Jun 2015 16:18:36 -0700
Message-ID: <559323CC.1000003@redhat.com>
References: <CACJqLyZcAzb5wocrN8b8WoK6j3ynWF-_3=T+1aQkDko4Mv_SmQ@mail.gmail.com>	<99767EA2E27DD44DB4E9F9B9ACA458C03B319D0D@SSIEXCH-MB3.ssi.samsung.com> <CAMeBU_3ty6ae5VXP=_D8py1_Pk4rLKxCa4Larz0oKnyTYDtz8w@mail.gmail.com> <99767EA2E27DD44DB4E9F9B9ACA458C03B319DF2@SSIEXCH-MB3.ssi.samsung.com> <55931A5E.5000408@redhat.com> <55931EEE.9070604@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41022 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119AbbF3XSg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jun 2015 19:18:36 -0400
In-Reply-To: <55931EEE.9070604@kernel.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Mark Nelson <mnelson@redhat.com>, "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, Casey Bodley <cbodley@gmail.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, daniel.gollub@gmail.com

Note that ceph's ObjectStore api is internal, and not stable. Maybe not
the best thing to include in packages, though keeping it as an option
at build time might make sense. The api itself isn't that prone to
change, but internal symbols (hooray c++...) certainly are, so any
update of ceph would likely need a recompile of the backend.

Josh

On 06/30/2015 03:57 PM, Jens Axboe wrote:
> I'd be more than happy to include it. Daniel has contributed to fio b=
efore.
>
> Daniel (CC'ed), was it your intent to get this upstream? How do we ma=
ke
> this happen?
>
>
> On 06/30/2015 04:38 PM, Mark Nelson wrote:
>> It would be fantastic if folks decided to work on this and got it pu=
shed
>> upstream into fio proper. :D
>>
>> Mark
>>
>> On 06/30/2015 04:19 PM, James (Fei) Liu-SSI wrote:
>>> Hi Casey,
>>>
>>>    Thanks a lot.
>>>
>>>    Regards,
>>>    James
>>>
>>> -----Original Message-----
>>> From: Casey Bodley [mailto:cbodley@gmail.com]
>>> Sent: Tuesday, June 30, 2015 2:16 PM
>>> To: James (Fei) Liu-SSI
>>> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>>> Subject: Re: About Fio backend with ObjectStore API
>>>
>>> Hi,
>>>
>>> When Danny Al-Gaaf & Daniel Gollub published "Ceph Performance
>>> Analysis: fio and RBD" at
>>> https://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-ana=
lysis_fio_rbd.html,
>>>
>>>
>>> they also mentioned a fio engine that linked directly into ceph's
>>> FileStore. I was able to find Daniel's branch on github at
>>> https://github.com/gollub/ceph/tree/fio_filestore_v2, and did some
>>> more work on it at the time.
>>>
>>> I just rebased that work onto the latest ceph master branch, and
>>> pushed to our github at
>>> https://github.com/linuxbox2/linuxbox-ceph/tree/fio-objectstore. Yo=
u
>>> can find the source in src/test/fio_ceph_filestore.cc, and run fio
>>> with the provided example fio job file in src/test/filestore.fio.
>>>
>>> I didn't have a chance to confirm that it builds with automake, but
>>> the cmake version built for me. I'm happy to help if you run into
>>> problems, Casey
>>>
>>> On Tue, Jun 30, 2015 at 2:31 PM, James (Fei) Liu-SSI
>>> <james.liu@ssi.samsung.com> wrote:
>>>> Hi Haomai,
>>>>    What are you trying to ask is to benchmark local objectstore(li=
ke
>>>> kvstore/filestore/newstore) locally with FIO(ObjectStore engine)? =
You
>>>> want to purely compare the performance locally for these
>>>> objectstores, right?
>>>>
>>>>    Regards,
>>>>    James
>>>>
>>>> -----Original Message-----
>>>> From: ceph-devel-owner@vger.kernel.org
>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wang
>>>> Sent: Tuesday, June 30, 2015 9:06 AM
>>>> To: ceph-devel@vger.kernel.org
>>>> Subject: About Fio backend with ObjectStore API
>>>>
>>>> Hi all,
>>>>
>>>> Long long ago, is there someone said about fio backend with Ceph
>>>> ObjectStore API? So we could use the existing mature fio facility =
to
>>>> benchmark ceph objectstore.
>>>>
>>>> --
>>>> Best Regards,
>>>>
>>>> Wheat
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>>>> in the body of a message to majordomo@vger.kernel.org More majordo=
mo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>>>
>>>
>>>
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
