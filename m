From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Newbie question about metadata_list.
Date: Fri, 7 Aug 2015 10:59:34 +0300
Message-ID: <CAOi1vP8rbGZ1spmxyLmQa2D_-k5ZXFNGPhASmrEv9ORwhJ9XYA@mail.gmail.com>
References: <20150806112630.d3c4ed783a07dfefb0d6dbc6@corp.ovh.com>
	<CAOi1vP-S8zui8vwhbzc1i7t=LLJx6PW2Lmtg-OeZectL_umpFA@mail.gmail.com>
	<20150807091225.1c18016d0c28add3f52897d8@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34609 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187AbbHGH7g convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Aug 2015 03:59:36 -0400
Received: by wicne3 with SMTP id ne3so50496063wic.1
        for <ceph-devel@vger.kernel.org>; Fri, 07 Aug 2015 00:59:35 -0700 (PDT)
In-Reply-To: <20150807091225.1c18016d0c28add3f52897d8@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?=C5=81ukasz_Szymczyk?= <lukasz.szymczyk@corp.ovh.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Aug 7, 2015 at 10:12 AM, =C5=81ukasz Szymczyk
<lukasz.szymczyk@corp.ovh.com> wrote:
> On Thu, 6 Aug 2015 15:01:54 +0300
> Ilya Dryomov <idryomov@gmail.com> wrote:
>
> Hi,
>
>> On Thu, Aug 6, 2015 at 12:26 PM, =C5=81ukasz Szymczyk
>> <lukasz.szymczyk@corp.ovh.com> wrote:
>> > Hi,
>> >
>> > I'm writing some program to replace image in cluster with it's cop=
y.
>> > But I have problem with metadata_list.
>
>> >         librbd::ImageCtx *ic =3D (librbd::ImageCtx*)im;
>> >         std::string start;
>> >         int max =3D 1000;
>> >         bufferlist in, out;
>> >         ::encode(start, in);
>> >         ::encode(max, in);
>> >         ret =3D ((librados::IoCtx*)&io)->exec(ic->header_oid, "rbd=
", "metadata_list", in, out);
>> >         if (ret < 0) printf("fail\n");
>>
>> You should use rbd_metadata_list() C API instead of this.
>
> Looks like my ceph version doesn't have it.
>
>>
>> >
>> >         return 0;
>> >
>> > }
>> >
>> > So, my question is: what should be set/enabled to get those metada=
ta?
>> > Or maybe what I'm doing wrong here.
>>
>> Try "rbd image-meta list image"?
>
> I've got this:
> # rbd image-meta list image
> rbd: error parsing command 'image-meta'; -h or --help for usage
>
>>
>> It's a fairly recent feature, are you sure your OSDs support it?
>> What's the output of "ceph daemon osd.0 version"?
>
> # ceph daemon osd.0 version
> {"version":"0.80.9"}

image metadata was introduced in v9.0.0.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
