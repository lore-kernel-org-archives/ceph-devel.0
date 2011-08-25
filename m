From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH 2/2] rbd: add an option for md5 checksumming (v2)
Date: Thu, 25 Aug 2011 14:05:38 -0700
Message-ID: <CAORUGqAUn-xGh2umb6GD01mVU-boq76ofdpPmMtYoPTTur=8Dg@mail.gmail.com>
References: <20110825110316.GB6517@sir.fritz.box> <CAORUGqCz8Y4_VF=PrH5QGx60nm_bziwuiyX-9rSvxqsdcLigqQ@mail.gmail.com>
 <CAC-hyiEqfKQtdOQ3s46QEU0PMLCfGuHvjeSsQJPArvDo=fQi3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39262 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381Ab1HYVF6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2011 17:05:58 -0400
Received: by gya6 with SMTP id 6so2111285gya.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2011 14:05:58 -0700 (PDT)
In-Reply-To: <CAC-hyiEqfKQtdOQ3s46QEU0PMLCfGuHvjeSsQJPArvDo=fQi3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

On Thu, Aug 25, 2011 at 13:38, Yehuda Sadeh Weinraub
<yehuda.sadeh@dreamhost.com> wrote:
> On Thu, Aug 25, 2011 at 1:32 PM, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
>> On Thu, Aug 25, 2011 at 04:03, Christian Brunner <chb@muc.de> wrote:
>>> + =C2=A0if (buf) {
>>> + =C2=A0 =C2=A0dif =3D ofs-lastofs;
>>> + =C2=A0 =C2=A0if (dif > 0) {
>>> + =C2=A0 =C2=A0 =C2=A0byte *tempbuf =3D (byte *) malloc(dif);
>>> + =C2=A0 =C2=A0 =C2=A0memset(tempbuf, 0, dif);
>>> + =C2=A0 =C2=A0 =C2=A0Hash->Update((const byte *) tempbuf, dif);
>>> + =C2=A0 =C2=A0 =C2=A0free(tempbuf);
>>> + =C2=A0 =C2=A0}
>>> +
>>> + =C2=A0 =C2=A0Hash->Update((const byte *) buf, len);
>>> + =C2=A0 =C2=A0lastofs =3D ofs + len;
>>> + =C2=A0}
>>
>> Does this mean a file with a 100GB hole in it will make you malloc(1=
00GB)?
>>
> That's in the read_iterate() callback. It wouldn't be called with
> anything larger than a single block size.
>
> Unless I'm somehow missing, it's still missing the holes. Now it just
> ignores them, it should be taking them into account as zero data.

To my reading, that is *exactly* what the quoted code does -- it just
assumes that a hole can fit fully in RAM.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
