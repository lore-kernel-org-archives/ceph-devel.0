From: Christian Brunner <chb@muc.de>
Subject: Re: [PATCH 2/2] rbd: add an option for md5 checksumming (v2)
Date: Fri, 26 Aug 2011 20:49:22 +0200
Message-ID: <CAO47_-_-Kg0U4khA7yfJn3xNm2an=DmWY4WG1bMMwiUuhU_UfQ@mail.gmail.com>
References: <20110825110316.GB6517@sir.fritz.box>
	<CAORUGqCz8Y4_VF=PrH5QGx60nm_bziwuiyX-9rSvxqsdcLigqQ@mail.gmail.com>
	<CAC-hyiEqfKQtdOQ3s46QEU0PMLCfGuHvjeSsQJPArvDo=fQi3Q@mail.gmail.com>
	<CAORUGqAUn-xGh2umb6GD01mVU-boq76ofdpPmMtYoPTTur=8Dg@mail.gmail.com>
	<CAC-hyiHoHSDNBVwaVY=zgp9oCmCNYUk6W-LAvFzKzNnFca+h0A@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37415 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab1HZStX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Aug 2011 14:49:23 -0400
Received: by vxi9 with SMTP id 9so2854120vxi.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Aug 2011 11:49:22 -0700 (PDT)
In-Reply-To: <CAC-hyiHoHSDNBVwaVY=zgp9oCmCNYUk6W-LAvFzKzNnFca+h0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel@vger.kernel.org

2011/8/25 Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>:
>>>>> + =A0if (buf) {
>>>>> + =A0 =A0dif =3D ofs-lastofs;
>>>>> + =A0 =A0if (dif > 0) {
>>>>> + =A0 =A0 =A0byte *tempbuf =3D (byte *) malloc(dif);
>>>>> + =A0 =A0 =A0memset(tempbuf, 0, dif);
>>>>> + =A0 =A0 =A0Hash->Update((const byte *) tempbuf, dif);
>>>>> + =A0 =A0 =A0free(tempbuf);
>>>>> + =A0 =A0}
>>>>> +
>>>>> + =A0 =A0Hash->Update((const byte *) buf, len);
>>>>> + =A0 =A0lastofs =3D ofs + len;
>>>>> + =A0}
>>>>
>>>> Does this mean a file with a 100GB hole in it will make you malloc=
(100GB)?
>>>>
>>> That's in the read_iterate() callback. It wouldn't be called with
>>> anything larger than a single block size.
>>>
>>> Unless I'm somehow missing, it's still missing the holes. Now it ju=
st
>>> ignores them, it should be taking them into account as zero data.
>>
>> To my reading, that is *exactly* what the quoted code does -- it jus=
t
>> assumes that a hole can fit fully in RAM.
>>
> Oh, right, misread that snippet. The test should go the other way
> around; something like:
>
> byte *hashbuf =3D buf;
> byte *tempbuf =3D NULL;
> if (!buf) {
> =A0tempbuf =3D (byte *) calloc(len);
> =A0if (!tempbuf)
> =A0 =A0return -ENOMEM;
> =A0hashbuf =3D tempbuf;
> }
> Hash->Update((const byte *) hashbuf, len);
> free(tempbuf);

Of course you are right. Just skipping the holes would possibly lead
to large allocations, which is not a good idea. I will send an updated
patch...

Thanks,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
