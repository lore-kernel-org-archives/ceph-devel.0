From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: [PATCH 2/2] rbd: add an option for md5 checksumming (v2)
Date: Thu, 25 Aug 2011 14:18:40 -0700
Message-ID: <CAC-hyiHoHSDNBVwaVY=zgp9oCmCNYUk6W-LAvFzKzNnFca+h0A@mail.gmail.com>
References: <20110825110316.GB6517@sir.fritz.box>
	<CAORUGqCz8Y4_VF=PrH5QGx60nm_bziwuiyX-9rSvxqsdcLigqQ@mail.gmail.com>
	<CAC-hyiEqfKQtdOQ3s46QEU0PMLCfGuHvjeSsQJPArvDo=fQi3Q@mail.gmail.com>
	<CAORUGqAUn-xGh2umb6GD01mVU-boq76ofdpPmMtYoPTTur=8Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54889 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab1HYVSl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2011 17:18:41 -0400
Received: by bke11 with SMTP id 11so2053838bke.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2011 14:18:40 -0700 (PDT)
In-Reply-To: <CAORUGqAUn-xGh2umb6GD01mVU-boq76ofdpPmMtYoPTTur=8Dg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

On Thu, Aug 25, 2011 at 2:05 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Thu, Aug 25, 2011 at 13:38, Yehuda Sadeh Weinraub
> <yehuda.sadeh@dreamhost.com> wrote:
>> On Thu, Aug 25, 2011 at 1:32 PM, Tommi Virtanen
>> <tommi.virtanen@dreamhost.com> wrote:
>>> On Thu, Aug 25, 2011 at 04:03, Christian Brunner <chb@muc.de> wrote=
:
>>>> + =A0if (buf) {
>>>> + =A0 =A0dif =3D ofs-lastofs;
>>>> + =A0 =A0if (dif > 0) {
>>>> + =A0 =A0 =A0byte *tempbuf =3D (byte *) malloc(dif);
>>>> + =A0 =A0 =A0memset(tempbuf, 0, dif);
>>>> + =A0 =A0 =A0Hash->Update((const byte *) tempbuf, dif);
>>>> + =A0 =A0 =A0free(tempbuf);
>>>> + =A0 =A0}
>>>> +
>>>> + =A0 =A0Hash->Update((const byte *) buf, len);
>>>> + =A0 =A0lastofs =3D ofs + len;
>>>> + =A0}
>>>
>>> Does this mean a file with a 100GB hole in it will make you malloc(=
100GB)?
>>>
>> That's in the read_iterate() callback. It wouldn't be called with
>> anything larger than a single block size.
>>
>> Unless I'm somehow missing, it's still missing the holes. Now it jus=
t
>> ignores them, it should be taking them into account as zero data.
>
> To my reading, that is *exactly* what the quoted code does -- it just
> assumes that a hole can fit fully in RAM.
>
Oh, right, misread that snippet. The test should go the other way
around; something like:

byte *hashbuf =3D buf;
byte *tempbuf =3D NULL;
if (!buf) {
  tempbuf =3D (byte *) calloc(len);
  if (!tempbuf)
    return -ENOMEM;
  hashbuf =3D tempbuf;
}
Hash->Update((const byte *) hashbuf, len);
free(tempbuf);
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
