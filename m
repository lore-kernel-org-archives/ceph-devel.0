From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: Problem with radosgw in 0.37
Date: Tue, 8 Nov 2011 13:51:39 -0800
Message-ID: <CAC-hyiG84ni-Pw-57pccXDS5jOUyOQ99G5BjQHE6UBj5i1ZCQA@mail.gmail.com>
References: <CAMwB3ThOq=z9ELN+dQkg2pif_Q_CXsJoU2D7wR4MMrnbwSVDYA@mail.gmail.com>
	<CAC-hyiE5VYLzN6L5rkVCG7SeTJ4qPdRGvVCpZzCrPgiaD7zsDg@mail.gmail.com>
	<CAMwB3TiJPSzpSTP5LN5LQZm=7iNgXO8W3s33aXptKy8JaU6jTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53021 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab1KHVvk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 16:51:40 -0500
Received: by bke11 with SMTP id 11so857256bke.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2011 13:51:39 -0800 (PST)
In-Reply-To: <CAMwB3TiJPSzpSTP5LN5LQZm=7iNgXO8W3s33aXptKy8JaU6jTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

2011/11/8 S=C5=82awomir Skowron <szibis@gmail.com>:
> Thank you very much. That's solve the problem. I was looking in sourc=
e
> code for that today, and i found i think self documented code for tha=
t
> too :)
>
=2E..
>
> Theoreticaly, 100-continue is working with nginx, but i will dig this
> soon. Now development can go on again.

As I said before, haven't looked at nginx for quite a while now, so
I'm not sure what's its status. When I looked at it a while back, it
was sending 100-continue responses, but it did that unconditionally
(when used with fastcgi), so we couldn't control the response timing.
We had he same issue also with both apache and lighttpd. For apache we
modified the fastcgi module so that we could actually control the
100-continue response. The specified configuration param should be set
to true only when the modified apache module is being used.

>
> But, there is no info in changelog, or I miss something about rgw
> cache capability, or maybe many more features, that can be useful in
> any other ceph piece in future.
>
Yeah, we're a bit lacking on the documentation. We hope that'll be fixe=
d soon.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
