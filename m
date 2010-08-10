From: Ulrich Oelmann <ulrich.oelmann@web.de>
Subject: Re: RBD performance is not good
Date: Tue, 10 Aug 2010 10:18:04 +0200 (CEST)
Message-ID: <341848787.2318972.1281428284840.JavaMail.fmail@mwmweb029>
References: <C88708CC.5980%haifeng@yahoo-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fmmailgate04.web.de ([217.72.192.242]:44318 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0HJISG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Aug 2010 04:18:06 -0400
Received: from mwmweb029  ( [172.20.18.38])
	by fmmailgate04.web.de (Postfix) with ESMTP id CF0A068A38CF
	for <ceph-devel@vger.kernel.org>; Tue, 10 Aug 2010 10:18:04 +0200 (CEST)
In-Reply-To: <C88708CC.5980%haifeng@yahoo-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi there,

I don't think that Xiaoguang saw the speed of 30-60 MB/s because of cac=
he
effects as the speed should be in the order of at least some hundred MB=
/s
then. Do you agree?

Could perhaps someone having an rbd-setup running confirm or reject
Xiaoguangs measurements?

Best regards
Ulrich


-----Urspr=C3=BCngliche Nachricht-----
Von: Haifeng Liu <haifeng@yahoo-inc.com>
Gesendet: Aug 10, 2010 7:46:52 AM
An: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Betreff: Re: RBD performance is not good

>Xiaoguang,
>
>This should be a normal result =E2=80=93 the client=E2=80=99s pagecach=
e buffered the write
>when you dd onto a ceph fs, while no buffering when dd to a rbd. What =
do you
>think?=20
>
>Thanks
>-haifeng
>
>
>On 8/10/10 11:23 AM, "Xiaoguang Liu"  wrote:
>
>> on my 2-ods-node cluster, dd can only reach 13MB/s on rbd device. th=
is
>> is much lower than what I expected.
>> I can get 30-60 MB/s on a ceph filesystem over the same cluster.
>>=20
>> any idea?
>>=20
>>=20
>>=20
>>=20
>> [root@ceph-1 ~]# dd if=3D/dev/zero of=3D/dev/rbd0  bs=3D1M count=3D5=
000
>> 5000+0 records in
>> 5000+0 records out
>> 5242880000 bytes (5.2 GB) copied, 391.508 s, 13.4 MB/s
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>
>N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=BF=
=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=BF=
=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=BD=
=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=
=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=
=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj=
:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=DD=A2j"=EF=BF=BD=EF=BF=BD
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
