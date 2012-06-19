From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Heavy speed difference between rbd and custom pool
Date: Tue, 19 Jun 2012 06:41:35 +0200 (CEST)
Message-ID: <bfd5bdd7-1959-445f-8016-7b98ae5eb6e9@mailpro>
References: <4FDFAA75.5070309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50746 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab2FSEl6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 00:41:58 -0400
In-Reply-To: <4FDFAA75.5070309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

Hi Stephann
recommandations are 30-50 PGS by osd if I remember.

----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Stefan Priebe" <s.priebe@profihost.ag>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mardi 19 Juin 2012 00:23:49=20
Objet: Re: Heavy speed difference between rbd and custom pool=20

On 06/18/2012 04:39 PM, Stefan Priebe wrote:=20
> Hello list,=20
>=20
> i'm getting these rbd bench values for pool rbd. They're high and con=
stant.=20
> ----------------------------- RBD pool=20
> # rados -p rbd bench 30 write -t 16=20
> Maintaining 16 concurrent writes of 4194304 bytes for at least 30 sec=
onds.=20
> sec Cur ops started finished avg MB/s cur MB/s last lat avg lat=20
> 0 0 0 0 0 0 - 0=20
> 1 16 274 258 1031.77 1032 0.043758 0.0602236=20
> 2 16 549 533 1065.82 1100 0.072168 0.0590944=20
> 3 16 825 809 1078.5 1104 0.040162 0.058682=20
> 4 16 1103 1087 1086.84 1112 0.052508 0.0584277=20
> 5 16 1385 1369 1095.04 1128 0.060233 0.0581288=20
> 6 16 1654 1638 1091.85 1076 0.050697 0.0583385=20
> 7 16 1939 1923 1098.71 1140 0.063716 0.057964=20
> 8 16 2219 2203 1101.35 1120 0.055435 0.0579105=20
> 9 16 2497 2481 1102.52 1112 0.060413 0.0578282=20
> 10 16 2773 2757 1102.66 1104 0.051134 0.0578561=20
> 11 16 3049 3033 1102.77 1104 0.057742 0.0578803=20
> 12 16 3326 3310 1103.19 1108 0.053769 0.0578627=20
> 13 16 3604 3588 1103.86 1112 0.064574 0.0578453=20
> 14 16 3883 3867 1104.72 1116 0.056524 0.0578018=20
> 15 16 4162 4146 1105.46 1116 0.054581 0.0577626=20
> 16 16 4440 4424 1105.86 1112 0.079015 0.057758=20
> 17 16 4725 4709 1107.86 1140 0.043511 0.0576647=20
> 18 16 5007 4991 1108.97 1128 0.053005 0.0576147=20
> 19 16 5292 5276 1110.6 1140 0.069004 0.057538=20
> 2012-06-18 23:36:19.124472min lat: 0.028568 max lat: 0.201941 avg lat=
:=20
> 0.0574953=20
> sec Cur ops started finished avg MB/s cur MB/s last lat avg lat=20
> 20 16 5574 5558 1111.46 1128 0.048482 0.0574953=20
> 21 16 5861 5845 1113.18 1148 0.051923 0.0574146=20
> 22 16 6147 6131 1114.58 1144 0.04461 0.0573461=20
> 23 16 6438 6422 1116.72 1164 0.050383 0.0572406=20
> 24 16 6724 6708 1117.85 1144 0.067827 0.0571864=20
> 25 16 7008 6992 1118.57 1136 0.049128 0.057147=20
> 26 16 7296 7280 1119.85 1152 0.050331 0.0570879=20
> 27 16 7573 7557 1119.4 1108 0.052711 0.0571132=20
> 28 16 7858 7842 1120.13 1140 0.056369 0.0570764=20
> 29 16 8143 8127 1120.81 1140 0.046558 0.0570438=20
> 30 16 8431 8415 1121.85 1152 0.049958 0.0569942=20
> Total time run: 30.045481=20
> Total writes made: 8431=20
> Write size: 4194304=20
> Bandwidth (MB/sec): 1122.432=20
>=20
> Stddev Bandwidth: 26.0451=20
> Max bandwidth (MB/sec): 1164=20
> Min bandwidth (MB/sec): 1032=20
> Average Latency: 0.0570069=20
> Stddev Latency: 0.0128039=20
> Max latency: 0.235536=20
> Min latency: 0.028568=20
> -----------------------------=20
>=20
> I created then a custom pool called kvmpool.=20
>=20
> ~# ceph osd pool create kvmpool=20
> pool 'kvmpool' created=20
>=20
> But with this one i get slow and jumping values:=20
> -------------------------------- kvmpool=20
> ~# rados -p kvmpool bench 30 write -t 16=20
> Maintaining 16 concurrent writes of 4194304 bytes for at least 30 sec=
onds.=20
> sec Cur ops started finished avg MB/s cur MB/s last lat avg lat=20
> 0 0 0 0 0 0 - 0=20
> 1 16 231 215 859.863 860 0.204867 0.069195=20
> 2 16 393 377 753.899 648 0.049444 0.0811933=20
> 3 16 535 519 691.908 568 0.232365 0.0899074=20
> 4 16 634 618 617.913 396 0.032758 0.0963399=20
> 5 16 806 790 631.913 688 0.075811 0.099529=20
> 6 16 948 932 621.249 568 0.156988 0.10179=20
> 7 16 1086 1070 611.348 552 0.036177 0.102064=20
> 8 16 1206 1190 594.922 480 0.028491 0.105235=20
> 9 16 1336 1320 586.589 520 0.041009 0.108735=20
> 10 16 1512 1496 598.32 704 0.258165 0.105086=20
> 11 16 1666 1650 599.921 616 0.040967 0.106146=20
> 12 15 1825 1810 603.255 640 0.198851 0.105463=20
> 13 16 1925 1909 587.309 396 0.042577 0.108449=20
> 14 16 2135 2119 605.352 840 0.035767 0.105219=20
> 15 16 2272 2256 601.523 548 0.246136 0.105357=20
> 16 16 2426 2410 602.424 616 0.19881 0.105692=20
> 17 16 2529 2513 591.22 412 0.031322 0.105463=20
> 18 16 2696 2680 595.48 668 0.028081 0.106749=20
> 19 16 2878 2862 602.449 728 0.044929 0.105856=20
> 2012-06-18 23:38:45.566094min lat: 0.023295 max lat: 0.763797 avg lat=
:=20
> 0.105597=20
> sec Cur ops started finished avg MB/s cur MB/s last lat avg lat=20
> 20 16 3041 3025 604.921 652 0.036028 0.105597=20
> 21 16 3182 3166 602.964 564 0.035072 0.104915=20
> 22 16 3349 3333 605.916 668 0.030493 0.105304=20
> 23 16 3512 3496 607.917 652 0.030523 0.10479=20
> 24 16 3668 3652 608.584 624 0.232933 0.10475=20
> 25 16 3821 3805 608.717 612 0.029881 0.104513=20
> 26 16 3963 3947 607.148 568 0.050244 0.10531=20
> 27 16 4112 4096 606.733 596 0.259069 0.105008=20
> 28 16 4261 4245 606.347 596 0.211877 0.105215=20
> 29 16 4437 4421 609.712 704 0.02802 0.104613=20
> 30 16 4566 4550 606.586 516 0.047076 0.105111=20
> Total time run: 30.062141=20
> Total writes made: 4566=20
> Write size: 4194304=20
> Bandwidth (MB/sec): 607.542=20
>=20
> Stddev Bandwidth: 109.112=20
> Max bandwidth (MB/sec): 860=20
> Min bandwidth (MB/sec): 396=20
> Average Latency: 0.10532=20
> Stddev Latency: 0.108369=20
> Max latency: 0.763797=20
> Min latency: 0.023295=20
> --------------------------------=20
>=20
> Why do these pools differ? Where is the difference?=20
>=20
> Stefan=20

Are the number of placement groups the same for each pool?=20

try running "ceph osd dump -o - | grep <pool>" and looking for the=20
pg_num value.=20

Mark=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
