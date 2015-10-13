From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: chooseleaf may cause some unnecessary pg migrations
Date: Tue, 13 Oct 2015 08:20:57 -0600
Message-ID: <CAANLjFpOPXCL0FEkejzR+hBYcH1=Wajvz-12v+XPZT3buA2z2A@mail.gmail.com>
References: <FF8D83DAE5DF57468726B79904321E06046B73@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33951 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbbJMOU7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 10:20:59 -0400
Received: by vkat63 with SMTP id t63so11072168vka.1
        for <ceph-devel@vger.kernel.org>; Tue, 13 Oct 2015 07:20:58 -0700 (PDT)
In-Reply-To: <FF8D83DAE5DF57468726B79904321E06046B73@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xusangdi <xu.sangdi@h3c.com>
Cc: "sweil@redhat.com" <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Are you testing with straw or straw2?
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Tue, Oct 13, 2015 at 2:22 AM, Xusangdi  wrote:
> Hi Sage,
>
> Recently when I was learning about the crush rules I noticed that the=
 step chooseleaf may cause some unnecessary pg migrations when OSDs are=
 outed.
> For example, for a cluster of 4 hosts with 2 OSDs each, after host1(o=
sd.2, osd.3) is down, the mapping differences would be like this:
> pgid    before <-> after        diff    diff_num
> 0.1e    [5, 1, 2] <-> [5, 1, 7]         [2]     1
> 0.1f    [0, 7, 3] <-> [0, 7, 4]         [3]     1
> 0.1a    [0, 4, 3] <-> [0, 4, 6]         [3]     1
> 0.5     [6, 3, 1] <-> [6, 0, 5]         [1, 3]  2
> 0.4     [5, 6, 2] <-> [5, 6, 0]         [2]     1
> 0.7     [3, 7, 0] <-> [7, 0, 4]         [3]     1
> 0.6     [2, 1, 7] <-> [0, 7, 4]         [1, 2]  2
> 0.9     [3, 4, 0] <-> [5, 0, 7]         [3, 4]  2
> 0.15    [2, 6, 1] <-> [6, 0, 5]         [1, 2]  2
> 0.14    [3, 6, 5] <-> [7, 4, 1]         [3, 5, 6]       3
> 0.17    [0, 5, 2] <-> [0, 5, 6]         [2]     1
> 0.16    [0, 4, 2] <-> [0, 4, 7]         [2]     1
> 0.11    [4, 7, 2] <-> [4, 7, 1]         [2]     1
> 0.10    [0, 3, 6] <-> [0, 7, 4]         [3, 6]  2
> 0.13    [1, 7, 3] <-> [1, 7, 4]         [3]     1
> 0.a     [0, 2, 7] <-> [0, 7, 4]         [2]     1
> 0.c     [5, 0, 3] <-> [5, 0, 6]         [3]     1
> 0.b     [2, 5, 7] <-> [4, 7, 0]         [2, 5]  2
> 0.18    [7, 2, 4] <-> [7, 4, 0]         [2]     1
> 0.f     [2, 7, 5] <-> [6, 4, 0]         [2, 5, 7]       3
> Changed pg ratio: 30 / 32
>
> I tried to change the code (please see https://github.com/ceph/ceph/p=
ull/6242) and after the modification the result would be like this:
> pgid    before <-> after        diff    diff_num
> 0.1e    [5, 0, 3] <-> [5, 0, 7]         [3]     1
> 0.1f    [0, 6, 3] <-> [0, 6, 4]         [3]     1
> 0.1a    [0, 5, 2] <-> [0, 5, 6]         [2]     1
> 0.5     [6, 3, 0] <-> [6, 0, 5]         [3]     1
> 0.4     [5, 7, 2] <-> [5, 7, 0]         [2]     1
> 0.7     [3, 7, 1] <-> [7, 1, 5]         [3]     1
> 0.6     [2, 0, 7] <-> [0, 7, 4]         [2]     1
> 0.9     [3, 5, 1] <-> [5, 1, 7]         [3]     1
> 0.15    [2, 6, 1] <-> [6, 1, 4]         [2]     1
> 0.14    [3, 7, 5] <-> [7, 5, 1]         [3]     1
> 0.17    [0, 4, 3] <-> [0, 4, 6]         [3]     1
> 0.16    [0, 4, 3] <-> [0, 4, 6]         [3]     1
> 0.11    [4, 6, 3] <-> [4, 6, 0]         [3]     1
> 0.10    [0, 3, 6] <-> [0, 6, 5]         [3]     1
> 0.13    [1, 7, 3] <-> [1, 7, 5]         [3]     1
> 0.a     [0, 3, 6] <-> [0, 6, 5]         [3]     1
> 0.c     [5, 0, 3] <-> [5, 0, 6]         [3]     1
> 0.b     [2, 4, 6] <-> [4, 6, 1]         [2]     1
> 0.18    [7, 3, 5] <-> [7, 5, 1]         [3]     1
> 0.f     [2, 6, 5] <-> [6, 5, 1]         [2]     1
> Changed pg ratio: 20 / 32
>
> Currently the only defect I can see from the change is that the chanc=
e for a given pg to successfully choose required available OSDs might b=
e a bit lower compared with before. However, I believe it will cause pr=
oblems only when the cluster is pretty small and degraded. And in that =
case, we can still make it workable by tuning some of the crushmap para=
meters such as chooseleaf_tries.
>
> Anyway I'm not sure if it would raise any other issues, could you ple=
ase review it and maybe give me some suggestions? Thank you!
>
> ----------
> Best regards,
> Sangdi
>
> ---------------------------------------------------------------------=
----------------------------------------------------------------
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=
=AB=E6=9C=89=E6=9D=AD=E5=B7=9E=E5=8D=8E=E4=B8=89=E9=80=9A=E4=BF=A1=E6=8A=
=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=
=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=
=BA
> =E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=
=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=
=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=
=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=
=81
> =E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=
=AD=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=
=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=
=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=
=AC
> =E9=82=AE=E4=BB=B6=EF=BC=81
> This e-mail and its attachments contain confidential information from=
 H3C, which is
> intended only for the person or entity whose address is listed above.=
 Any use of the
> information contained herein in any way (including, but not limited t=
o, total or partial
> disclosure, reproduction, or dissemination) by persons other than the=
 intended
> recipient(s) is prohibited. If you receive this e-mail in error, plea=
se notify the sender
> by phone or email immediately and delete it!

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.0
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWHRM4CRDmVDuy+mK58QAARVMP/jhhtyRsiUXw4kl2ikso
=468CiAwPuGRMvFSa2CXqzvaHnNjiy8Q4uR8o0KgcR04eiLGPUeahjyAQ73+8k
geryb9ymjoDFjkKX2n7YxCHy/MnB5HayNIuUPi+KUFzpradx1v7S54XL2DHm
mDRR2DDeou9H6WcIqknRh4e6fc1a70E2CbpKr9qu7AiNiEfRZzXod//joavW
h0MkYC0Ug41UG64R9QTCJOKp+wSjri+IUgSSrs3WPYXb5W1jZPFIhsFkigws
VgitZTv3+rO5ZyHbtCR+3yNI5isU18Lhf+Dr01MExUuyCQQz6zODXV0W+xgP
wsMSe8ZXXr84a/8MKoP90mr2pNiiasMwWrcZ/klQ9J4AIqh8DJEHJeAWf+4N
pYWTiRFbq3NZzIUjTBqtP/AliKvCTDQhVP3E8hK1qYg4Gv0gQ0Zu76F5c5/p
rj9HTZa+o8rSQM0TDuiqKSMEJUcuMt/TScWmQNZF1GTb3HSx6LW6H+aOkLuE
N0Fi+rkYupxXC3P3HnU35GMzlum//j/svIFkLOA5V5abVAttcxrGg9jpebUO
i3f4DR6e86RNLMaakNoybYlK9J+7j3JjKydBTqkDn9sKBeMaE/oW21Ft99/z
eJDLf+8xGt02tV512mPDw8SWJZUws3/B4qc4yrkYUe2aWBeHrE7vIX8ZgC1M
icrE
=3D/pQd
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
