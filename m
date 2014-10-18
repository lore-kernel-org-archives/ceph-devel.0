From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: The Async messenger benchmark with latest master
Date: Sat, 18 Oct 2014 11:07:34 +0200 (CEST)
Message-ID: <9b0ee700-20be-4f26-a9e2-9d3026637d5c@mailpro>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282298FF@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:57487 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbaJRJHn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Oct 2014 05:07:43 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282298FF@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel@vger.kernel.org

Hi Somnath,

Results seem promising indeed :)

Can you share your ceph.conf ?


----- Mail original -----=20

De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Vendredi 17 Octobre 2014 22:37:55=20
Objet: The Async messenger benchmark with latest master=20

Hi Sage/Haomai,=20

I did some 4K Random Read benchmarking with latest master having Async =
messenger changes and result looks promising.=20

My configuration:=20
---------------------=20

1 node, 8 SSDs, 8OSDs, 3 pools , each has 3 images. ~2000 Pg cluster wi=
de=20
Cpu : Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz, dual socket, HT enable=
d, 40 cores.=20
Used krbd as client.=20


1 clinet node with 3 rbd images on 3 different pools:=20
-------------------------------------------------------------------=20
Master :=20
---------=20

~203k IOPS, ~90% latencies within 4msec, total read : ~5.2TB=20

lat (usec) : 4=3D0.01%, 10=3D0.01%, 50=3D0.01%, 100=3D0.01%, 250=3D0.03=
%=20
lat (usec) : 500=3D0.86%, 750=3D3.72%, 1000=3D7.19%=20
lat (msec) : 2=3D39.17%, 4=3D41.45%, 10=3D7.26%, 20=3D0.24%, 50=3D0.06%=
=20
lat (msec) : 100=3D0.03%, 250=3D0.01%, 500=3D0.01%=20

cpu: ~1-2 % idle=20

Giant:=20
------=20

~196k IOPS, ~89-90% latencies within 4msec, total read : ~5.3TB=20

lat (usec) : 250=3D0.01%, 500=3D0.51%, 750=3D2.71%, 1000=3D6.03%=20
lat (msec) : 2=3D34.32%, 4=3D45.74%, 10=3D10.46%, 20=3D0.21%, 50=3D0.02=
%=20
lat (msec) : 100=3D0.01%, 250=3D0.01%=20

cpu: ~2% idle=20

2 clients with 3 rbd images each on 3 different pools:=20
-------------------------------------------------------------------=20

Master :=20
---------=20

~207K iops, ~70% latencies within 4msec, Total read: ~5.99 TB=20

lat (usec) : 250=3D0.03%, 500=3D0.63%, 750=3D2.67%, 1000=3D5.21%=20
lat (msec) : 2=3D25.12%, 4=3D36.19%, 10=3D24.80%, 20=3D3.16%, 50=3D1.34=
%=20
lat (msec) : 100=3D0.66%, 250=3D0.18%, 500=3D0.01%=20

cpu: ~0-1 % idle=20

Giant:=20
--------=20
~199K iops, ~64% latencies within 4msec, Total read: ~5.94 TB=20

lat (usec) : 250=3D0.01%, 500=3D0.25%, 750=3D1.47%, 1000=3D3.45%=20
lat (msec) : 2=3D21.22%, 4=3D36.69%, 10=3D30.63%, 20=3D4.28%, 50=3D1.70=
%=20
lat (msec) : 100=3D0.28%, 250=3D0.02%, 500=3D0.01%=20

cpu: ~1% idle=20


So, in summary the master with Async messenger has improved both in iop=
s and latency.=20

Thanks & Regards=20
Somnath=20

________________________________=20

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
