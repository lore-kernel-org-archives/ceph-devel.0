From: =?UTF-8?B?UGVkcm8gTMOzcGV6LUFkZXZh?= <plopezadeva@gmail.com>
Subject: Re: An algorithm to fix uneven CRUSH distributions in Ceph
Date: Fri, 12 May 2017 22:39:36 +0200
Message-ID: <CAFdhnjds6kV5FwWbGpz0z3LcfDY3rR7CnfTdK2arNV0bUxxc+w@mail.gmail.com>
References: <66e67a16-9cb2-aa2c-cf81-fc66b03e16d8@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36565 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdELUjh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 12 May 2017 16:39:37 -0400
Received: by mail-qt0-f178.google.com with SMTP id f55so8737946qta.3
        for <ceph-devel@vger.kernel.org>; Fri, 12 May 2017 13:39:37 -0700 (PDT)
In-Reply-To: <66e67a16-9cb2-aa2c-cf81-fc66b03e16d8@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I will have a look in more detail but the first thing that has come to
my mind is Coordinate Descent
(https://en.wikipedia.org/wiki/Coordinate_descent), so it might make
sense it converges to some point. The fact that it converges always to
zero or near zero error seems more related maybe to this particular
problem and I wonder if it's possible to engineer some instance where
the algorithm gets stuck on some local minimum.

Cheers,
Pedro.


2017-05-12 13:26 GMT+02:00 Loic Dachary <loic@dachary.org>:
> Hi Pedro,
>
> After significant testing I believe the algorithm described at http://dac=
hary.org/?p=3D4055 works. I'll publish an implementation next week with pyt=
hon-crush[1]. There is however something I don't understand other than intu=
itively. Why does it converge in all cases ? The core of the algorithm is:
>
> repeat while the distribution improves
>          run a simulation
>          lower the weight of the most overfilled device
>          increase the weight of the most underfilled device
>
> Which we can do because we can run a simulation with all the values. We a=
lways know the full set of values (PGs in the Ceph parlance but you can thi=
nk of them as files) that are distributed to devices. The loss function is =
the sum of the absolute value of the difference between the expected distri=
bution and the actual distribution for each device. The Kullback-Liebler di=
vergence also works and has a fancier name but that does not seem to be bet=
ter.
>
> With a better understanding of why it works we may be able to come up wit=
h a faster faster implementation and get closer to the perfect distribution=
 in some cases.
>
> I'm curious to know what you think about that :-)
>
> Cheers
>
> [1] http://crush.readthedocs.io/
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
