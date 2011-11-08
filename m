From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: Problem with radosgw in 0.37
Date: Tue, 8 Nov 2011 23:26:42 +0100
Message-ID: <CAMvP8PB08=6x56bnm1bnAdPAqj-QMk5RG3rvx4hS3u8Ni7Tuhg@mail.gmail.com>
References: <CAMwB3ThOq=z9ELN+dQkg2pif_Q_CXsJoU2D7wR4MMrnbwSVDYA@mail.gmail.com>
 <CAC-hyiE5VYLzN6L5rkVCG7SeTJ4qPdRGvVCpZzCrPgiaD7zsDg@mail.gmail.com>
 <CAMwB3TiJPSzpSTP5LN5LQZm=7iNgXO8W3s33aXptKy8JaU6jTA@mail.gmail.com> <CAC-hyiG84ni-Pw-57pccXDS5jOUyOQ99G5BjQHE6UBj5i1ZCQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53665 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab1KHW1F convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 17:27:05 -0500
Received: by ggnb2 with SMTP id b2so1067484ggn.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2011 14:27:05 -0800 (PST)
In-Reply-To: <CAC-hyiG84ni-Pw-57pccXDS5jOUyOQ99G5BjQHE6UBj5i1ZCQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>, ceph-devel@vger.kernel.org

One more quick question. Is it possible to setup multiple hosts with
radosgw operating on single bucket ?

2011/11/8 Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>:
> 2011/11/8 S=C5=82awomir Skowron <szibis@gmail.com>:
>> Thank you very much. That's solve the problem. I was looking in sour=
ce
>> code for that today, and i found i think self documented code for th=
at
>> too :)
>>
> ...
>>
>> Theoreticaly, 100-continue is working with nginx, but i will dig thi=
s
>> soon. Now development can go on again.
>
> As I said before, haven't looked at nginx for quite a while now, so
> I'm not sure what's its status. When I looked at it a while back, it
> was sending 100-continue responses, but it did that unconditionally
> (when used with fastcgi), so we couldn't control the response timing.
> We had he same issue also with both apache and lighttpd. For apache w=
e
> modified the fastcgi module so that we could actually control the
> 100-continue response. The specified configuration param should be se=
t
> to true only when the modified apache module is being used.
>
>>
>> But, there is no info in changelog, or I miss something about rgw
>> cache capability, or maybe many more features, that can be useful in
>> any other ceph piece in future.
>>
> Yeah, we're a bit lacking on the documentation. We hope that'll be fi=
xed soon.
>
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
