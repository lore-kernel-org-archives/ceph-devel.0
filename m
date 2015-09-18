From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Re: What should be in the next hammer/firefly release ?
Date: Thu, 17 Sep 2015 18:44:56 -0600
Message-ID: <CAANLjFo8Knp1OHy69fnxxtDE0WKzZkmk3U3yCPpW16pxtaKDtQ@mail.gmail.com>
References: <870DE8DBB716524BAE51B2D499EC81E40AB98467@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36074 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbbIRAxJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Sep 2015 20:53:09 -0400
Received: by vkfp126 with SMTP id p126so21272324vkf.3
        for <ceph-devel@vger.kernel.org>; Thu, 17 Sep 2015 17:53:09 -0700 (PDT)
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AB98467@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "PVonStamwitz@us.fujitsu.com" <PVonStamwitz@us.fujitsu.com>, "Toshine, Naoyoshi" <toshine@jp.fujitsu.com>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Can we get http://tracker.ceph.com/issues/10399 into hammer. We hit thi=
s today.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Thu, Sep 10, 2015 at 4:57 AM, Miyamae, Takeshi  wrote:
> Hi Loic,
>
> As the last pull request #5257 was committed into the main trunk,
> we believe all the SHEC codes in main trunk are ready to be backporte=
d into Hammer branch.
> What can we do at this moment?
>
> Best regards,
> Takeshi Miyamae
>
> -----Original Message-----
> From: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Sent: Thursday, September 3, 2015 4:09 PM
> To: 'ceph-devel-owner@vger.kernel.org'
> Cc: Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com); Toshine, Naoyosh=
i/=E5=88=A9=E6=A0=B9 =E7=9B=B4=E4=BD=B3; Shiozawa, Kensuke/=E5=A1=A9=E6=
=B2=A2 =E8=B3=A2=E8=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=
=E8=A9=94 (nakao.takanori@jp.fujitsu.com)
> Subject: Re: What should be in the next hammer/firefly release ?
>
> Dear Loic,
>
> We would like to let following two patches be backported to hammer v0=
=2E94.4.
> (And our wish is finally backporting these patches to RHCS v1.3.) Can=
 it be possible? If possible, please let us know what should be started=
 at first.
> (Caution: #5257 has not been committed to master branch yet.)
>
> erasure-code: shec plugin feature #5493
> https://github.com/ceph/ceph/pull/5493
>
> erasure code: shec performance optimization by decoding cache #5257
> https://github.com/ceph/ceph/pull/5257
>
> Best regards,
> Takeshi Miyamae
>
> -----Original Message-----
> From: Loic Dachary  dachary.org>
> Subject: What should be in the next hammer/firefly release ?
> Newsgroups: gmane.comp.file-systems.ceph.devel
> Date: 2015-09-02 11:00:53 GMT (15 hours and 32 minutes ago) Hi,
>
> I added a link to
>
> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO#Overview-of=
-the-backports-in-progress
>
> to show all issues that should be in the next point release for
>
> hammer v0.94.4 : http://tracker.ceph.com/versions/495
> firefly v0.80.11 : http://tracker.ceph.com/versions/480
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.0.2
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJV+16ECRDmVDuy+mK58QAANCsP/jmNpzoF+k24vrsgYa54
Yy4dD9WO1uK/eT11ZqQGt/eN+ISiia8ztI2zoXkUsMZNOT4sBpzyHdvJTgRP
27wFVppWy7Lrk9rwfk650WyJJDxyb8O6nERVPtd3aOs1uHVuTo3tzdJcrIhM
85rSkSGU23NnGFj9D0OluNVx/ZsmuqHNjJz5tb4YO5rHmB9CZ92tVqrCNxaj
cfEmVE+h2CGQyGHyGgFgDGSCRgZiKScGLJfq2FG5WCyVaXShwbVj0ffkKDEP
xC87wECZatlSpNkMrFRLAVe91rth7RRexLS3aFQh6YGAhCkblxcI0HxbXRwg
hMUiL9AN5NxvhWMYJv6gU9BALDAsmRBS/m3F/ENToWTw6xWTPnA6xbAh+JKs
DCT7iTgwww0TLMAjUrDBTarW1ZyXEsFoWmHTaPGdwSKWo69mfFCOshOnThv7
0IRUCmk4Can4WIMRUj/gUoY2qjBF6V/f9LsKns15EdlJrfYyjtdBxqaDH2vP
YFLwdj4ff5K/Ya9Ex7Wx38wwspd5i1XPkJMg7jsNTFN179nhOgbTrTp1FzTN
JKTrrCtbxJ328SzhCLWhoPrMNUmFMj10ifX7U2Hi05ihln3BmgGLIKaJdhRy
ZhtA+jahhCuUrT9tcs/pbUiYkKokfz2efBpB17oVBTROEYELEYxZkYXtRsLN
0R1+
=3DfXlI
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
