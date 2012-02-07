From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: raodsgw--s3 client can't display objects with prefix of "_"
Date: Mon, 6 Feb 2012 23:02:51 -0800
Message-ID: <CAC-hyiHLVD0Hvwo9WXf6juVB6Q9TFb-9EaehBsA-ORrXQmmp0Q@mail.gmail.com>
References: <CABAwU-Y_emMq1DBu3xkZsvXhD87f_tE8NnaYww_GxeFLm3mpeg@mail.gmail.com>
	<CAC-hyiG6mOmGNBNh6wVYF8QOdZ=cvXqB43piy3+C5bt_Q_6h4g@mail.gmail.com>
	<CABAwU-aaYHD3saGCOyBiGV9-OwM6NqKfcVBc=-kHks8AG1S=NA@mail.gmail.com>
	<CAC-hyiHvA1B+D=0borNwf2w9G1uTMXjm48-iTfH7_+h51pr6wg@mail.gmail.com>
	<CABAwU-YFCV+C2VOTsemArGDVdCNzB3yF2+QVXQ9Zqe5t+-9axg@mail.gmail.com>
	<CAC-hyiEFebiuP4vkX2s=Vg-TnDkLP2sBO=bAUvftbZm0Yb0K3A@mail.gmail.com>
	<CABAwU-Zb_9BhhpXNT1CT_+t_AtCALfdSJqZZubUcr9d-uzuO8A@mail.gmail.com>
	<CAC-hyiFNsxH--p11+eFE4cRKLx+SZDKr2hOF5vrE_QMuKNF84g@mail.gmail.com>
	<CABAwU-a=aAW5ScAh_GtGuru+SS38OrT5rO-Rov6UUW1nF-DjTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51671 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544Ab2BGHCw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2012 02:02:52 -0500
Received: by yhoo21 with SMTP id o21so2855500yho.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2012 23:02:51 -0800 (PST)
In-Reply-To: <CABAwU-a=aAW5ScAh_GtGuru+SS38OrT5rO-Rov6UUW1nF-DjTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>, ceph-devel@vger.kernel.org

On Mon, Feb 6, 2012 at 5:44 PM, huang jun <hjwsm1989@gmail.com> wrote:
> 2012/2/7 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
>> On Mon, Feb 6, 2012 at 5:03 PM, huang jun <hjwsm1989@gmail.com> wrot=
e:
>>> 2012/2/7 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
>>>> On Mon, Feb 6, 2012 at 4:55 PM, huang jun <hjwsm1989@gmail.com> wr=
ote:
>>>> Objects that were created earlier cannot be accessed after applyin=
g
>>>> that patch. New objects should be fine.
>>>
>>> yes, i created a new bucket to test the patch. but the object can
>>> neither be deleted or getxattr of it.
>>>
>> Can you provide rgw log for that? Add the following under your
>> ceph.conf [client] section:
>>
>> =A0debug rgw =3D 20
>> =A0debug ms =3D 1
>>
>> Also, do you have any other changes in the rgw code?
>>
>
> hi, i attach the log of apache, the operation is:
> 1) create an object "_file".
> 2)delete the object.
> hope that can give some infos.
>
> and my radosgw was not the newest one, it from v0.32, does that matte=
rs?
>
Yeah, pretty much. 0.32 is ancient history by now, and there were lots
of bugs that have since been fixed. The code that handling that stuff
has changed significantly.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
