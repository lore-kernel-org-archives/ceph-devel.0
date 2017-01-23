From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: Lots of radosgw-admin commands fail after upgrade
Date: Mon, 23 Jan 2017 09:45:47 +0200
Message-ID: <CABo9giQ-z99UtL7YfVmqwRVSuB5gh1tCpqvCSXvjGsVQA-CDCw@mail.gmail.com>
References: <CAFehDbCTSPLmh8LY03q0cfV1v2ACzF24ZShAk+OgSXYJLVjPqg@mail.gmail.com>
 <CABo9giRVAb-+2zvKWTWhRVF4fftG=szDxgrXBXNmDpH-yQrWMw@mail.gmail.com>
 <CAFehDbC6yBsbQCPVmwE+DCod-Xmbafp1MU_r1wYZ0xd_q3Dt3Q@mail.gmail.com>
 <CABo9giTbFUrW1uE4iO5c5=4S4sT9mtxoD+8gi1vemcLCf3RVew@mail.gmail.com>
 <CAFehDbAeF6UqhGHUVYOjvTDhE-+qDAGfLPnk==bbjEUypzeWPw@mail.gmail.com>
 <CABo9giRgopdCqURUJQX3OHCG=O_Q17ZuoJxeX-1-tc1aXpzN1g@mail.gmail.com>
 <CAFehDbDaDdMHTtxLqq8kjd5Xd9RePqDDCXtJm7_7UMCD7Q3LOg@mail.gmail.com>
 <CABo9giTWVHYGdrqpmtYP8-iDY5tM+a4MrBczwha27=g-HzmRcw@mail.gmail.com>
 <CAFehDbDDF0cMiHre0DnbSD2-sxc6cFubLVHSOs2HMTtLbkeKJA@mail.gmail.com>
 <CABo9giQWq_unoXu_qwEkmrqod9rLk8bmUh+k_jotyvAAW7L+9Q@mail.gmail.com>
 <CAFehDbBO4bsPPuWqEJ_K0L8oh3Wj=L=NscZgR_hjoJ5e=ZPvvA@mail.gmail.com>
 <CABo9giS-FajcA0gcC1PR4v+4rnVLRyph_DQKkF-bSbKM7RM47g@mail.gmail.com>
 <CAFehDbBvHcNGy61X2o_7aw+VuouL_SGRC_TFB=am69ENL81sZw@mail.gmail.com>
 <CABo9giQaYsahOM4jxcueT=DU_==KRwJBfdz2wPkT9GidN58_+g@mail.gmail.com> <CAFehDbCfSvvPW7Sk0_4fM5nbKuATpDyd0A=uFi4Y_+ceL8Q6yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37365 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAWHpy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 02:45:54 -0500
Received: by mail-wm0-f54.google.com with SMTP id c206so140268618wme.0
        for <ceph-devel@vger.kernel.org>; Sun, 22 Jan 2017 23:45:48 -0800 (PST)
In-Reply-To: <CAFehDbCfSvvPW7Sk0_4fM5nbKuATpDyd0A=uFi4Y_+ceL8Q6yg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mustafa Muhammad <mustafa1024m@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jan 23, 2017 at 9:40 AM, Mustafa Muhammad
<mustafa1024m@gmail.com> wrote:
> On Sun, Jan 22, 2017 at 4:34 PM, Orit Wasserman <owasserm@redhat.com> wrote:
>> On Sun, Jan 22, 2017 at 12:00 PM, Mustafa Muhammad
>> <mustafa1024m@gmail.com> wrote:
>>> On Sun, Jan 22, 2017 at 12:04 PM, Orit Wasserman <owasserm@redhat.com> wrote:
>>>> On Sat, Jan 21, 2017 at 10:24 AM, Mustafa Muhammad
>>>> <mustafa1024m@gmail.com> wrote:
>>>>> Hello again :)
>>>>>
>>>>> It still doesn't work for me using 10.2.5:
>>>>>
>>>>> [root@monitor3 ~]# ceph -v
>>>>> ceph version 10.2.5 (c461ee19ecbc0c5c330aca20f7392c9a00730367)
>>>>> [root@monitor3 ~]# radosgw-admin period update --commit
>>>>> 2017-01-21 11:06:20.659487 7f2ca18979c0  0 zonegroup default missing
>>>>> zone for master_zone=
>>>>> couldn't init storage provider
>>>>>
>>>>> I think I am hitting:
>>>>> http://tracker.ceph.com/issues/17364
>>>>>
>>>>> So I created new RPMs with this patch:
>>>>> https://github.com/ceph/ceph/pull/12315
>>>>>
>>>>> But now, it crashes when I try to update the period, I've attached the
>>>>> output and the details of my zonegroup, I also tried the just released
>>>>> Kraken, also crashes.
>>>>>
>>>>
>>>> I am working on a fix.
>>>> Will you be able to try it?
>>>>
>>
>> https://github.com/ceph/ceph/pull/13054
>>
>> Good luck!
>
> This *kind of* worked, it doesn't crash anymore, and zonegroup now
> have master zone, but now I don't have my placement-targets anymore
> I used:
>
> radosgw-admin zone set --rgw-zone=default < new-default-zone.json
> radosgw-admin zonegroup set --rgw-zonegroup=default < new-default-zg.json
> radosgw-admin zonegroupmap set < new-zonegroupmap.json
>

You don't need this and I suspect this it is the problem.
Can you try without this command?

> radosgw-admin zonegroup default --rgw-zonegroup=default
> radosgw-admin zone default --rgw-zone=default
> radosgw-admin period update --commit
>
> Is there something wrong I am doing? Can I update zonegroupmap
> directly (like I did) or should I only set zone and zonegroup, tried
> several things, still only getting:
>
>                 "placement_targets": [
>                     {
>                         "name": "default-placement",
>                         "tags": []
>                     }
>                 ]
>
>
> Regards
> Mustafa
>
>>
>>>
>>> Yes, of course :)
>>>
>>> Thank you
>>>
>>> Mustafa
>>>
>>>> Orit
>>>>> What do you think, what should I do?
>>>>>
>>>>> Thanks a lot in advance
>>>>>
>>>>> Regards
>>>>> Mustafa Muhammad
