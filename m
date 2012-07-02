From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Mon, 02 Jul 2012 07:02:49 +0200 (CEST)
Message-ID: <59beaaec-5f12-4fb2-9c03-69f41849e89e@mailpro>
References: <4FF0C0C2.2010407@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:59700 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab2GBFDM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 01:03:12 -0400
In-Reply-To: <4FF0C0C2.2010407@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Hi,
my 2cent,
maybe with lower range (like 100MB) of random io,
you have more chance to aggregate them in 4MB block ?

I'll do some tests today with my 15K drives

----- Mail original -----=20

De: "Stefan Priebe" <s.priebe@profihost.ag>=20
=C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
Cc: "Sage Weil" <sage@inktank.com>, ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Dimanche 1 Juillet 2012 23:27:30=20
Objet: Re: speedup ceph / scaling / find the bottleneck=20

Am 01.07.2012 23:13, schrieb Mark Nelson:=20
> On 7/1/12 4:01 PM, Stefan Priebe wrote:=20
>> Hello list,=20
>> Hello sage,=20
>>=20
>> i've made some further tests.=20
>>=20
>> Sequential 4k writes over 200GB: 300% CPU usage of kvm process 34712=
 iops=20
>>=20
>> Random 4k writes over 200GB: 170% CPU usage of kvm process 5500 iops=
=20
>>=20
>> When i make random 4k writes over 100MB: 450% CPU usage of kvm proce=
ss=20
>> and !! 25059 iops !!=20
>>=20
> When you say 100MB vs 200GB, do you mean the total amount of data tha=
t=20
> is written for the test?=20

Yes/No, it is the max amount of data written but for random I/O it is=20
also the range like random block device position between 0 and X where=20
to write the 4K block.=20

> Also, are these starting out on a fresh=20
> filesystem?=20
Yes, 5 Min old in this case ;-)=20

Stefan=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
