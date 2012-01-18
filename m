From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: another Problem / question
Date: Wed, 18 Jan 2012 09:04:12 -0800
Message-ID: <CAORUGqCsMHbqy+ALn9huvOnZG0Rzy+uMPNNx5q+KZWcyU0Oz4A@mail.gmail.com>
References: <4F16C582.7010403@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56086 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932196Ab2ARREd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 12:04:33 -0500
Received: by mail-ww0-f44.google.com with SMTP id dq11so3434794wgb.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 09:04:33 -0800 (PST)
In-Reply-To: <4F16C582.7010403@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Jens_Rehp=C3=B6hler?= <jens.rehpoehler@filoo.de>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 18, 2012 at 05:13, Jens Rehp=C3=B6hler <jens.rehpoehler@fil=
oo.de> wrote:
> Hi all,
>
> todo i've done few performance tests with my two clusters.
>
> I've used : rados -p data load-gen --run-length 10 --target-throughpu=
t 50
>
> to generate some load. Now i have a question regarding "ceph -w" outp=
ut.
>
> The output before the test was:
>
> 2012-01-18 11:55:28.621107 =C2=A0 =C2=A0pg v113011: 594 pgs: 594 peer=
ing; 61022 MB
> data, 120 GB used, 244 GB / 372 GB avail
>
> here is the output after the test:
>
> 2012-01-18 13:53:30.190602 =C2=A0 =C2=A0pg v113119: 594 pgs: 594 acti=
ve+clean;
> 1058 GB data, 120 GB used, 244 GB / 372 GB avail
>
> How can i have more Data then the available discspace ? Is there any
> possiblity to identify the rados objects of this test and delete them
> manualy ?

A quick read of the source seems to say "rados load-gen" writes at
random offsets..

  size_t off =3D get_random(0, info.len);

which means you have a lot of sparse objects. And that makes the "1058
GB data, 120 GB used" make sense.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
