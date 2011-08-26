From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 2/2] rbd: add an option for md5 checksumming (v3)
Date: Fri, 26 Aug 2011 12:59:43 -0700
Message-ID: <CAC-hyiFvbFfDAXQrJJotTzk684-g1Kr=eA5aaGg+MyOyyLrk7Q@mail.gmail.com>
References: <20110826185117.GA19365@sir.fritz.box>
	<CAC-hyiGwEZqaFGvSDnGoSn_vc5c7L_QatEpSER2JP2r-Ssj9cQ@mail.gmail.com>
	<CAO47_-_Ctyk5H_gOeCPRMc1AVXTqTQ_pwPri8XN-pXMUa1oWrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61703 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab1HZT7o convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Aug 2011 15:59:44 -0400
Received: by bke11 with SMTP id 11so2795905bke.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Aug 2011 12:59:43 -0700 (PDT)
In-Reply-To: <CAO47_-_Ctyk5H_gOeCPRMc1AVXTqTQ_pwPri8XN-pXMUa1oWrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

On Fri, Aug 26, 2011 at 12:52 PM, Christian Brunner <chb@muc.de> wrote:
> 2011/8/26 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
>> On Fri, Aug 26, 2011 at 11:51 AM, Christian Brunner <chb@muc.de> wro=
te:
>>> +static int hash_read_cb(uint64_t ofs, size_t len, const char *buf,=
 void *arg)
>>> +{
>>> + =A0ceph::crypto::Digest *Hash =3D (ceph::crypto::Digest *)arg;
>>> + =A0byte *hashbuf =3D (byte *) buf;
>>
>> Looking at it again, hashbuf is pretty much useless, you can use buf=
 directly.
>>
>>> + =A0byte *tempbuf =3D NULL;
>>> +
>>> + =A0if (!buf) {
>>> + =A0 =A0len =3D ofs-lastofs;
>>
>> Why setting len here? len was already passed in.
>
> Ah - then I didn't understand what read_iterate is doing. I was
> thinking, that the callback is not called for missing objects.
>
>>
>>> + =A0 =A0tempbuf =3D (byte *) malloc(len);
>
> Do we need a memset here?
>
You can memset, or calloc instead.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
