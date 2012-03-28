From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: Build error in 0.44
Date: Wed, 28 Mar 2012 10:40:11 +0800
Message-ID: <CANExM-NJ2eK-e3vHxO9pbRyS1fPPeWG8ycFxu97ugbf8TxhGaw@mail.gmail.com>
References: <20120327171741.D52F.33BC0F0F@bit-isle.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33945 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757948Ab2C1CkL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 22:40:11 -0400
Received: by iagz16 with SMTP id z16so795217iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 19:40:11 -0700 (PDT)
In-Reply-To: <20120327171741.D52F.33BC0F0F@bit-isle.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomoki BENIYA <beniya@bit-isle.co.jp>
Cc: ceph-devel@vger.kernel.org

I guess you need to the following submodule initialization before you
build the debs:
git submodule init
git submodule update

Henry

=E5=9C=A8 2012=E5=B9=B43=E6=9C=8827=E6=97=A5=E4=B8=8B=E5=8D=884:43=EF=BC=
=8CTomoki BENIYA <beniya@bit-isle.co.jp> =E5=AF=AB=E9=81=93=EF=BC=9A
> Hi all
>
> When I build ceph 0.44, it occured error and failed to build.
> They said following error
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> make: *** [build-stamp] Error 1
> dpkg-buildpackage: error: debian/rules build gave error exit status 2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> What should I do?
>
>
> # cat /etc/debian_version
> wheezy/sid
>
> # uname -a
> Linux debian7 3.1.0-1-amd64 #1 SMP Tue Jan 10 05:01:58 UTC 2012 x86_6=
4 GNU/Linux
>
> # dpkg-buildpackage
> ......
> autoreconf: running: /usr/bin/autoheader --force
> autoreconf: running: automake --add-missing --copy --force-missing
> Makefile.am:182: `lib/libgtest.a' is not a standard libtool library n=
ame
> Makefile.am:182: did you mean `lib/libgtest.la'?
> Makefile.am:182: `lib/libgtest_main.a' is not a standard libtool libr=
ary name
> Makefile.am:182: did you mean `lib/libgtest_main.la'?
> autoreconf: Leaving directory `.'
> autoreconf: `configure.ac' or `configure.in' is required
> make: *** [build-stamp] Error 1
> dpkg-buildpackage: error: debian/rules build gave error exit status 2
>
>
> --
> Tomoki BENIYA <beniya@bit-isle.co.jp>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
