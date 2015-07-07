From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: About Fio backend with ObjectStore API
Date: Tue, 7 Jul 2015 16:17:40 +0800
Message-ID: <CACJqLyZVLKEAS7+CTXHxDymXTzk2dZVQQkZrjx40pDRz=rStow@mail.gmail.com>
References: <CACJqLyZcAzb5wocrN8b8WoK6j3ynWF-_3=T+1aQkDko4Mv_SmQ@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B319D0D@SSIEXCH-MB3.ssi.samsung.com>
	<CAMeBU_3ty6ae5VXP=_D8py1_Pk4rLKxCa4Larz0oKnyTYDtz8w@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B319DF2@SSIEXCH-MB3.ssi.samsung.com>
	<55931A5E.5000408@redhat.com>
	<55931EEE.9070604@kernel.dk>
	<CAHAfqgPMyfVtYrAp8ox11uA=q+zEDKP7Zoc2WveuYat=0hD8zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35947 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbbGGIRl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jul 2015 04:17:41 -0400
Received: by ykdr198 with SMTP id r198so170862887ykd.3
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2015 01:17:41 -0700 (PDT)
In-Reply-To: <CAHAfqgPMyfVtYrAp8ox11uA=q+zEDKP7Zoc2WveuYat=0hD8zg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Gollub <daniel.gollub@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josh Durgin <jdurgin@redhat.com>, Mark Nelson <mnelson@redhat.com>, "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, Casey Bodley <cbodley@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Danny Al-Gaaf <danny.al-gaaf@bisect.de>

On Wed, Jul 1, 2015 at 1:58 PM, Daniel Gollub <daniel.gollub@gmail.com>=
 wrote:
> Hi Jens,
>
> as Josh already mentioned the engine would use Ceph internal ObjectSt=
ore API
> ... which is not stable.
> So as Josh proposed, my idea was to build this C++ ObjectStorage engi=
ne as
> an external FIO engine inside Ceph (optionally).
>
> We just need to keep fio working with for external C++ engines - so t=
his
> external engine can exists.
> That was the intend when I did push various "build"-fixes for C++ fio
> headers, to get the external ObjectStorage fio engine building, becau=
se it's
> written in C++.
>
> I am no longer with DT, so I don't have a Ceph cluster right now to t=
est
> things. But I'm happy to help to get the ObjectStorage fio engine ups=
tream
> into Ceph. Josh, Casey do you need any help on this? I guess
> https://github.com/linuxbox2/linuxbox-ceph/tree/fio-objectstore is  g=
ood
> base to continue. Casey, thank you for cleaning things up ;)
>

Cool, do you have plan to do this recently? If not, I'm willing to help=
 :-)

>
> Best Regards,
> Daniel
>
>
> On Wed, Jul 1, 2015 at 12:57 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> I'd be more than happy to include it. Daniel has contributed to fio
>> before.
>>
>> Daniel (CC'ed), was it your intent to get this upstream? How do we m=
ake
>> this happen?
>>
>>
>> On 06/30/2015 04:38 PM, Mark Nelson wrote:
>>>
>>> It would be fantastic if folks decided to work on this and got it p=
ushed
>>> upstream into fio proper. :D
>>>
>>> Mark
>>>
>>> On 06/30/2015 04:19 PM, James (Fei) Liu-SSI wrote:
>>>>
>>>> Hi Casey,
>>>>
>>>>    Thanks a lot.
>>>>
>>>>    Regards,
>>>>    James
>>>>
>>>> -----Original Message-----
>>>> From: Casey Bodley [mailto:cbodley@gmail.com]
>>>> Sent: Tuesday, June 30, 2015 2:16 PM
>>>> To: James (Fei) Liu-SSI
>>>> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>>>> Subject: Re: About Fio backend with ObjectStore API
>>>>
>>>> Hi,
>>>>
>>>> When Danny Al-Gaaf & Daniel Gollub published "Ceph Performance
>>>> Analysis: fio and RBD" at
>>>>
>>>> https://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-an=
alysis_fio_rbd.html,
>>>>
>>>> they also mentioned a fio engine that linked directly into ceph's
>>>> FileStore. I was able to find Daniel's branch on github at
>>>> https://github.com/gollub/ceph/tree/fio_filestore_v2, and did some
>>>> more work on it at the time.
>>>>
>>>> I just rebased that work onto the latest ceph master branch, and
>>>> pushed to our github at
>>>> https://github.com/linuxbox2/linuxbox-ceph/tree/fio-objectstore. Y=
ou
>>>> can find the source in src/test/fio_ceph_filestore.cc, and run fio
>>>> with the provided example fio job file in src/test/filestore.fio.
>>>>
>>>> I didn't have a chance to confirm that it builds with automake, bu=
t
>>>> the cmake version built for me. I'm happy to help if you run into
>>>> problems, Casey
>>>>
>>>> On Tue, Jun 30, 2015 at 2:31 PM, James (Fei) Liu-SSI
>>>> <james.liu@ssi.samsung.com> wrote:
>>>>>
>>>>> Hi Haomai,
>>>>>    What are you trying to ask is to benchmark local objectstore(l=
ike
>>>>> kvstore/filestore/newstore) locally with FIO(ObjectStore engine)?=
 You
>>>>> want to purely compare the performance locally for these
>>>>> objectstores, right?
>>>>>
>>>>>    Regards,
>>>>>    James
>>>>>
>>>>> -----Original Message-----
>>>>> From: ceph-devel-owner@vger.kernel.org
>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wan=
g
>>>>> Sent: Tuesday, June 30, 2015 9:06 AM
>>>>> To: ceph-devel@vger.kernel.org
>>>>> Subject: About Fio backend with ObjectStore API
>>>>>
>>>>> Hi all,
>>>>>
>>>>> Long long ago, is there someone said about fio backend with Ceph
>>>>> ObjectStore API? So we could use the existing mature fio facility=
 to
>>>>> benchmark ceph objectstore.
>>>>>
>>>>> --
>>>>> Best Regards,
>>>>>
>>>>> Wheat
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
>>>>> in the body of a message to majordomo@vger.kernel.org More majord=
omo
>>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=
=EF=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD=
^=EF=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=
=BF=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD =CA=87=DA=99=EF=BF=BD,j =EF=BF=BD=EF=
=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=
 =EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD
>>>> =EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BD=
j=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=
=BF=BD=EF=BF=BD!tml=3D
>>>>
>>>>
>>
>>
>> --
>> Jens Axboe
>>
>



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
