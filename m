From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: iostat show constants write to osd disk with writeahead journal, normal behaviour ?
Date: Mon, 18 Jun 2012 17:08:29 +0200 (CEST)
Message-ID: <7a18e87d-dfda-4966-be23-e34caa6b3d63@mailpro>
References: <ab1faa94-df41-47a6-8237-780c5f4d9a4b@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:46645 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab2FRPIz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 11:08:55 -0400
In-Reply-To: <ab1faa94-df41-47a6-8237-780c5f4d9a4b@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

=46orget to say:

The blktrace of the osd was done with 15 osd on 3 nodes.
So the peak and valley could come from rbd block distribution.


I have done same test with 1 osd by node with 3 nodes,
I have around 60MB/S by disk (with same behaviour)

So this is not a bottleneck.

I'm going to do some blktrace and seekwatcher move with 1 osd by node.



----- Mail original -----=20

De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
=C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 18 Juin 2012 16:50:57=20
Objet: Re: iostat show constants write to osd disk with writeahead jour=
nal, normal behaviour ?=20

forget to send iostat -x 1 trace=20

(osd's are on sdb,sbc,sdd,sde,sdf)=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 55,00 0,00 31,00 0,00 1468,00 94,71 0,21 6,77 0,00 6,77 5,16 1=
6,00=20
sdb 0,00 0,00 0,00 74,00 0,00 20516,00 554,49 2,74 38,78 0,00 38,78 3,5=
1 26,00=20
sdc 0,00 0,00 0,00 57,00 0,00 15520,00 544,56 1,77 28,60 0,00 28,60 3,6=
8 21,00=20
sdd 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,52 32,50 0,00 32,50 4,38=
 7,00=20
sde 0,00 0,00 0,00 15,00 0,00 4104,00 547,20 0,48 32,00 0,00 32,00 4,00=
 6,00=20
sdf 0,00 0,00 0,00 46,00 0,00 12316,00 535,48 1,42 30,87 0,00 30,87 3,7=
0 17,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,55 0,00 7,09 1,16 0,00 90,21=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 37,00 0,00 20,00 0,00 236,00 23,60 0,12 6,00 0,00 6,00 5,00 10=
,00=20
sdb 0,00 0,00 0,00 41,00 0,00 10780,00 525,85 1,03 21,46 0,00 21,46 3,6=
6 15,00=20
sdc 0,00 0,00 0,00 78,00 0,00 21416,00 549,13 3,20 42,82 0,00 42,82 3,0=
8 24,00=20
sdd 0,00 18,00 0,00 121,00 0,00 24859,00 410,89 3,00 24,79 0,00 24,79 3=
,06 37,00=20
sde 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00=20
sdf 0,00 15,00 0,00 75,00 0,00 12521,00 333,89 2,12 28,27 0,00 28,27 3,=
47 26,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,51 0,00 6,52 1,38 0,00 89,59=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 30,00 0,00 19,00 0,00 204,00 21,47 0,10 5,26 0,00 5,26 5,26 10=
,00=20
sdb 0,00 23,00 0,00 105,00 0,00 18281,50 348,22 3,92 38,67 0,00 38,67 3=
,33 35,00=20
sdc 0,00 0,00 0,00 31,00 0,00 8212,00 529,81 0,89 28,71 0,00 28,71 3,87=
 12,00=20
sdd 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,35 30,00 0,00 30,00 3,7=
8 17,00=20
sde 0,00 17,00 0,00 42,00 0,00 4308,00 205,14 1,14 27,14 0,00 27,14 3,3=
3 14,00=20
sdf 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,33 29,56 0,00 29,56 3,7=
8 17,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,28 0,00 4,31 0,00 0,00 93,41=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00=20
sdb 0,00 0,00 0,00 29,00 0,00 8204,00 565,79 0,89 31,03 0,00 31,03 3,45=
 10,00=20
sdc 0,00 21,00 0,00 85,00 0,00 12627,50 297,12 2,66 31,29 0,00 31,29 2,=
94 25,00=20
sdd 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,45 28,12 0,00 28,12 4,38=
 7,00=20
sde 0,00 0,00 0,00 75,00 0,00 20520,00 547,20 2,32 30,93 0,00 30,93 3,4=
7 26,00=20
sdf 0,00 0,00 0,00 17,00 0,00 4112,00 483,76 0,39 22,94 0,00 22,94 2,94=
 5,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,92 0,00 8,97 1,54 0,00 87,56=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 51,00 0,00 32,00 0,00 1432,00 89,50 0,21 7,19 0,00 7,19 5,00 1=
6,00=20
sdb 0,00 0,00 0,00 60,00 0,00 16416,00 547,20 1,59 26,50 0,00 26,50 3,3=
3 20,00=20
sdc 0,00 0,00 0,00 48,00 0,00 12324,00 513,50 1,41 23,96 0,00 23,96 3,5=
4 17,00=20
sdd 0,00 0,00 0,00 31,00 0,00 8212,00 529,81 0,79 25,48 0,00 25,48 3,23=
 10,00=20
sde 0,00 0,00 0,00 66,00 0,00 17704,00 536,48 2,96 40,76 0,00 40,76 3,7=
9 25,00=20
sdf 0,00 0,00 0,00 46,00 0,00 12316,00 535,48 1,33 28,91 0,00 28,91 3,9=
1 18,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,29 0,00 5,22 1,66 0,00 90,83=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 51,00 0,00 30,00 0,00 1460,00 97,33 0,15 5,00 0,00 5,00 4,67 1=
4,00=20
sdb 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,31 29,11 0,00 29,11 3,7=
8 17,00=20
sdc 0,00 0,00 0,00 29,00 0,00 8204,00 565,79 0,62 30,34 0,00 30,34 3,45=
 10,00=20
sdd 0,00 0,00 0,00 33,00 0,00 8220,00 498,18 1,13 30,30 0,00 30,30 4,24=
 14,00=20
sde 0,00 0,00 0,00 40,00 0,00 11028,00 551,40 0,91 29,50 0,00 29,50 3,5=
0 14,00=20
sdf 0,00 0,00 0,00 64,00 0,00 16432,00 513,50 1,69 26,41 0,00 26,41 3,9=
1 25,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,93 0,00 6,05 1,93 0,00 90,09=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 34,00 0,00 19,00 0,00 220,00 23,16 0,11 5,79 0,00 5,79 5,79 11=
,00=20
sdb 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00=20
sdc 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,13 25,11 0,00 25,11 3,3=
3 15,00=20
sdd 0,00 25,00 0,00 110,00 0,00 20841,00 378,93 3,39 32,00 0,00 32,00 3=
,09 34,00=20
sde 0,00 0,00 0,00 106,00 0,00 28732,00 542,11 3,35 31,60 0,00 31,60 3,=
40 36,00=20
sdf 0,00 21,00 0,00 57,00 0,00 4431,00 155,47 2,18 38,25 0,00 38,25 3,1=
6 18,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,29 0,00 7,64 2,17 0,00 87,90=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 30,00 0,00 18,00 0,00 200,00 22,22 0,10 5,56 0,00 5,56 5,56 10=
,00=20
sdb 0,00 29,00 0,00 92,00 0,00 16730,50 363,71 2,95 32,07 0,00 32,07 3,=
59 33,00=20
sdc 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,36 22,50 0,00 22,50 3,12=
 5,00=20
sdd 0,00 0,00 0,00 51,00 0,00 12968,00 508,55 1,18 20,98 0,00 20,98 3,3=
3 17,00=20
sde 0,00 33,00 0,00 115,00 0,00 20908,50 363,63 4,25 36,96 0,00 36,96 3=
,39 39,00=20
sdf 0,00 0,00 0,00 30,00 0,00 8208,00 547,20 0,70 23,33 0,00 23,33 3,00=
 9,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,14 0,00 7,37 1,14 0,00 90,34=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 37,00 0,00 22,00 0,00 244,00 22,18 0,12 5,45 0,00 5,45 4,55 10=
,00=20
sdb 0,00 0,00 0,00 82,00 0,00 22444,00 547,41 2,53 27,80 0,00 27,80 3,4=
1 28,00=20
sdc 0,00 19,00 0,00 65,00 0,00 8475,00 260,77 2,14 32,92 0,00 32,92 3,0=
8 20,00=20
sdd 0,00 0,00 0,00 11,00 0,00 3456,00 628,36 0,23 30,91 0,00 30,91 2,73=
 3,00=20
sde 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,28 28,44 0,00 28,44 3,5=
6 16,00=20
sdf 0,00 0,00 0,00 60,00 0,00 16416,00 547,20 1,72 28,67 0,00 28,67 3,3=
3 20,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,18 0,00 6,40 1,54 0,00 89,88=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 49,00 0,00 31,00 0,00 1420,00 91,61 0,20 6,45 0,00 6,45 5,16 1=
6,00=20
sdb 0,00 0,00 0,00 39,00 0,00 10392,00 532,92 1,07 33,85 0,00 33,85 3,8=
5 15,00=20
sdc 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,37 30,44 0,00 30,44 4,0=
0 18,00=20
sdd 0,00 0,00 0,00 60,00 0,00 16416,00 547,20 1,76 29,33 0,00 29,33 3,6=
7 22,00=20
sde 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,39 24,38 0,00 24,38 3,75=
 6,00=20
sdf 0,00 0,00 0,00 83,00 0,00 22448,00 540,92 2,55 28,19 0,00 28,19 3,7=
3 31,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,66 0,00 4,95 1,65 0,00 90,74=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 57,00 0,00 32,00 0,00 1492,00 93,25 0,18 5,62 0,00 5,62 4,06 1=
3,00=20
sdb 0,00 0,00 0,00 73,00 0,00 19628,00 537,75 2,23 28,90 0,00 28,90 3,7=
0 27,00=20
sdc 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,49 30,62 0,00 30,62 4,38=
 7,00=20
sdd 0,00 0,00 0,00 30,00 0,00 8208,00 547,20 0,72 24,00 0,00 24,00 3,33=
 10,00=20
sde 0,00 0,00 0,00 46,00 0,00 12316,00 535,48 1,34 29,13 0,00 29,13 4,1=
3 19,00=20
sdf 0,00 0,00 0,00 53,00 0,00 14492,00 546,87 1,02 23,21 0,00 23,21 3,2=
1 17,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,02 0,00 4,45 1,27 0,00 93,26=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 38,00 0,00 21,00 0,00 244,00 23,24 0,12 5,71 0,00 5,71 4,76 10=
,00=20
sdb 0,00 0,00 0,00 79,00 0,00 21420,00 542,28 3,87 50,51 0,00 50,51 3,4=
2 27,00=20
sdc 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,49 30,62 0,00 30,62 3,75=
 6,00=20
sdd 0,00 23,00 0,00 51,00 0,00 4391,50 172,22 1,58 30,98 0,00 30,98 3,3=
3 17,00=20
sde 0,00 0,00 0,00 1,00 0,00 4,00 8,00 0,00 0,00 0,00 0,00 0,00 0,00=20
sdf 0,00 27,00 0,00 81,00 0,00 11756,00 290,27 2,52 30,00 0,00 30,00 3,=
33 27,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,78 0,00 4,71 1,27 0,00 92,23=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 32,00 0,00 19,00 0,00 212,00 22,32 0,10 5,26 0,00 5,26 4,74 9,=
00=20
sdb 0,00 42,00 0,00 97,00 0,00 4819,50 99,37 5,26 54,23 0,00 54,23 3,20=
 31,00=20
sdc 0,00 19,00 0,00 127,00 0,00 16998,50 267,69 4,95 38,98 0,00 38,98 2=
,76 35,00=20
sdd 0,00 17,00 0,00 83,00 0,00 12656,00 304,96 3,03 36,51 0,00 36,51 3,=
25 27,00=20
sde 0,00 28,00 0,00 99,00 0,00 12794,50 258,47 3,59 35,76 0,00 35,76 3,=
03 30,00=20
sdf 0,00 19,00 0,00 56,00 0,00 5343,50 190,84 2,15 40,00 0,00 40,00 3,0=
4 17,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,69 0,00 7,68 1,15 0,00 88,48=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 31,00 0,00 20,00 0,00 212,00 21,20 0,12 6,00 0,00 6,00 5,50 11=
,00=20
sdb 0,00 0,00 0,00 90,00 0,00 24624,00 547,20 3,31 36,78 0,00 36,78 3,7=
8 34,00=20
sdc 0,00 11,00 0,00 102,00 0,00 20699,50 405,87 2,72 26,67 0,00 26,67 3=
,33 34,00=20
sdd 0,00 0,00 0,00 23,00 0,00 6032,00 524,52 0,72 22,17 0,00 22,17 3,91=
 9,00=20
sde 0,00 0,00 0,00 46,00 0,00 12316,00 535,48 1,47 33,04 0,00 33,04 3,9=
1 18,00=20
sdf 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,49 33,11 0,00 33,11 3,5=
6 16,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,94 0,00 7,54 1,79 0,00 87,72=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 49,00 0,00 31,00 0,00 1420,00 91,61 0,18 5,81 0,00 5,81 4,84 1=
5,00=20
sdb 0,00 0,00 0,00 121,00 0,00 32836,00 542,74 4,80 39,67 0,00 39,67 3,=
55 43,00=20
sdc 0,00 0,00 0,00 33,00 0,00 8217,00 498,00 1,11 29,70 0,00 29,70 4,24=
 14,00=20
sdd 0,00 0,00 0,00 52,00 0,00 14488,00 557,23 1,44 31,73 0,00 31,73 3,8=
5 20,00=20
sde 0,00 0,00 0,00 17,00 0,00 4112,00 483,76 0,38 22,35 0,00 22,35 3,53=
 6,00=20
sdf 0,00 0,00 0,00 15,00 0,00 4104,00 547,20 0,49 32,67 0,00 32,67 4,00=
 6,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,81 0,00 5,63 1,28 0,00 90,28=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 54,00 0,00 30,00 0,00 1472,00 98,13 0,18 6,00 0,00 6,00 4,67 1=
4,00=20
sdb 0,00 0,00 0,00 31,00 0,00 8212,00 529,81 0,99 31,94 0,00 31,94 2,90=
 9,00=20
sdc 0,00 0,00 0,00 43,00 0,00 12304,00 572,28 1,01 26,51 0,00 26,51 3,2=
6 14,00=20
sdd 0,00 0,00 0,00 60,00 0,00 16416,00 547,20 1,84 30,67 0,00 30,67 3,6=
7 22,00=20
sde 0,00 0,00 0,00 60,00 0,00 16416,00 547,20 2,13 35,50 0,00 35,50 4,0=
0 24,00=20
sdf 0,00 0,00 0,00 61,00 0,00 16420,00 538,36 1,77 29,02 0,00 29,02 3,7=
7 23,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,18 0,00 5,51 1,41 0,00 90,90=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 35,00 0,00 21,00 0,00 232,00 22,10 0,12 5,71 0,00 5,71 4,29 9,=
00=20
sdb 0,00 0,00 0,00 9,00 0,00 1932,00 429,33 0,40 21,11 0,00 21,11 4,44 =
4,00=20
sdc 0,00 0,00 0,00 61,00 0,00 16420,00 538,36 1,78 29,18 0,00 29,18 3,4=
4 21,00=20
sdd 0,00 22,00 0,00 72,00 0,00 12542,50 348,40 2,15 29,86 0,00 29,86 3,=
61 26,00=20
sde 0,00 0,00 0,00 35,00 0,00 8860,00 506,29 0,94 23,71 0,00 23,71 4,00=
 14,00=20
sdf 0,00 20,00 0,00 92,00 0,00 16663,00 362,24 3,23 35,11 0,00 35,11 3,=
48 32,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,93 0,00 5,15 1,03 0,00 91,89=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 37,00 0,00 22,00 0,00 244,00 22,18 0,11 5,00 0,00 5,00 4,09 9,=
00=20
sdb 0,00 27,00 0,00 62,00 0,00 6624,50 213,69 1,93 34,52 0,00 34,52 2,7=
4 17,00=20
sdc 0,00 0,00 0,00 76,00 0,00 20524,00 540,11 2,62 34,47 0,00 34,47 3,5=
5 27,00=20
sdd 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,40 31,11 0,00 31,11 4,0=
0 18,00=20
sde 0,00 20,00 0,00 84,00 0,00 13861,00 330,02 2,24 26,31 0,00 26,31 3,=
21 27,00=20
sdf 0,00 0,00 0,00 30,00 0,00 8208,00 547,20 0,95 31,67 0,00 31,67 4,00=
 12,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,93 0,00 5,39 1,16 0,00 91,53=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 31,00 0,00 19,00 0,00 208,00 21,89 0,11 5,79 0,00 5,79 5,26 10=
,00=20
sdb 0,00 0,00 0,00 15,00 0,00 3852,00 513,60 0,30 18,00 0,00 18,00 3,33=
 5,00=20
sdc 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,19 26,44 0,00 26,44 3,5=
6 16,00=20
sdd 0,00 0,00 0,00 107,00 0,00 28736,00 537,12 2,85 26,64 0,00 26,64 3,=
64 39,00=20
sde 0,00 0,00 0,00 23,00 0,00 6284,00 546,43 0,55 30,00 0,00 30,00 3,91=
 9,00=20
sdf 0,00 0,00 0,00 46,00 0,00 12316,00 535,48 1,34 29,13 0,00 29,13 3,4=
8 16,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,78 0,00 6,49 1,78 0,00 89,95=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 49,00 0,00 30,00 0,00 1416,00 94,40 0,17 5,67 0,00 5,67 5,00 1=
5,00=20
sdb 0,00 0,00 0,00 1,00 0,00 256,00 512,00 0,00 30,00 0,00 30,00 0,00 0=
,00=20
sdc 0,00 22,00 0,00 100,00 0,00 16746,00 334,92 3,90 39,00 0,00 39,00 3=
,20 32,00=20
sdd 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,37 23,12 0,00 23,12 3,75=
 6,00=20
sde 0,00 0,00 0,00 106,00 0,00 28732,00 542,11 3,62 34,15 0,00 34,15 3,=
58 38,00=20
sdf 0,00 0,00 0,00 46,00 0,00 12316,00 535,48 1,24 26,96 0,00 26,96 3,7=
0 17,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,79 0,00 6,03 1,67 0,00 90,51=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 54,00 0,00 34,00 0,00 1496,00 88,00 0,20 5,88 0,00 5,88 4,71 1=
6,00=20
sdb 0,00 0,00 0,00 134,00 0,00 36680,00 547,46 4,01 29,63 0,00 29,63 3,=
58 48,00=20
sdc 0,00 0,00 0,00 31,00 0,00 8212,00 529,81 0,92 29,68 0,00 29,68 3,87=
 12,00=20
sdd 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,35 21,88 0,00 21,88 3,12=
 5,00=20
sde 0,00 0,00 0,00 17,00 0,00 4112,00 483,76 0,48 28,24 0,00 28,24 4,12=
 7,00=20
sdf 0,00 0,00 0,00 15,00 0,00 4104,00 547,20 0,50 33,33 0,00 33,33 4,00=
 6,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,30 0,00 6,79 1,41 0,00 89,50=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 35,00 0,00 19,00 0,00 224,00 23,58 0,10 5,26 0,00 5,26 5,26 10=
,00=20
sdb 0,00 0,00 0,00 46,00 0,00 12568,00 546,43 1,06 23,91 0,00 23,91 3,2=
6 15,00=20
sdc 0,00 0,00 0,00 90,00 0,00 24624,00 547,20 2,70 30,00 0,00 30,00 3,4=
4 31,00=20
sdd 0,00 25,00 0,00 103,00 0,00 16777,50 325,78 3,46 33,59 0,00 33,59 3=
,30 34,00=20
sde 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,51 31,88 0,00 31,88 3,75=
 6,00=20
sdf 0,00 21,00 0,00 63,00 0,00 8462,50 268,65 1,65 26,03 0,00 26,03 3,1=
7 20,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,80 0,00 8,62 1,54 0,00 88,03=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 33,00 0,00 19,00 0,00 216,00 22,74 0,09 4,74 0,00 4,74 4,74 9,=
00=20
sdb 0,00 24,00 0,00 67,00 0,00 8514,00 254,15 2,26 31,79 0,00 31,79 3,4=
3 23,00=20
sdc 0,00 0,00 0,00 61,00 0,00 16420,00 538,36 1,58 25,90 0,00 25,90 3,6=
1 22,00=20
sdd 0,00 0,00 0,00 60,00 0,00 16416,00 547,20 1,42 23,67 0,00 23,67 3,3=
3 20,00=20
sde 0,00 25,00 0,00 97,00 0,00 16731,50 344,98 3,27 33,71 0,00 33,71 3,=
20 31,00=20
sdf 0,00 0,00 0,00 59,00 0,00 16412,00 556,34 1,61 27,46 0,00 27,46 3,5=
6 21,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,40 0,00 5,97 1,02 0,00 91,61=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 32,00 0,00 19,00 0,00 212,00 22,32 0,10 5,26 0,00 5,26 5,26 10=
,00=20
sdb 0,00 0,00 0,00 29,00 0,00 8204,00 565,79 0,65 26,90 0,00 26,90 3,10=
 9,00=20
sdc 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00 0,00=20
sdd 0,00 0,00 0,00 90,00 0,00 24624,00 547,20 2,89 32,11 0,00 32,11 3,4=
4 31,00=20
sde 0,00 0,00 0,00 60,00 0,00 16416,00 547,20 1,76 29,33 0,00 29,33 3,5=
0 21,00=20
sdf 0,00 0,00 0,00 31,00 0,00 8212,00 529,81 1,06 34,19 0,00 34,19 4,19=
 13,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
3,32 0,00 6,90 1,66 0,00 88,12=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 52,00 0,00 33,00 0,00 1440,00 87,27 0,18 5,45 0,00 5,45 4,55 1=
5,00=20
sdb 0,00 0,00 0,00 31,00 0,00 8212,00 529,81 0,91 29,35 0,00 29,35 3,55=
 11,00=20
sdc 0,00 21,00 0,00 75,00 0,00 8549,00 227,97 3,18 42,40 0,00 42,40 2,9=
3 22,00=20
sdd 0,00 0,00 0,00 46,00 0,00 12316,00 535,48 1,45 31,52 0,00 31,52 3,7=
0 17,00=20
sde 0,00 0,00 0,00 31,00 0,00 8212,00 529,81 0,87 28,06 0,00 28,06 3,55=
 11,00=20
sdf 0,00 0,00 0,00 121,00 0,00 32836,00 542,74 5,44 44,96 0,00 44,96 3,=
47 42,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,19 0,00 5,93 2,06 0,00 89,82=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 63,00 0,00 46,00 0,00 1572,00 68,35 0,63 13,70 0,00 13,70 4,78=
 22,00=20
sdb 0,00 0,00 0,00 122,00 0,00 32840,00 538,36 3,68 30,16 0,00 30,16 3,=
61 44,00=20
sdc 0,00 0,00 0,00 47,00 0,00 12320,00 524,26 1,22 25,96 0,00 25,96 3,6=
2 17,00=20
sdd 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,49 30,62 0,00 30,62 4,38=
 7,00=20
sde 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,15 25,56 0,00 25,56 2,8=
9 13,00=20
sdf 0,00 0,00 0,00 15,00 0,00 4104,00 547,20 0,35 23,33 0,00 23,33 3,33=
 5,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,66 0,00 5,62 1,53 0,00 91,19=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 35,00 0,00 18,00 0,00 220,00 24,44 0,11 6,11 0,00 6,11 6,11 11=
,00=20
sdb 0,00 0,00 0,00 15,00 0,00 4104,00 547,20 0,42 28,00 0,00 28,00 4,00=
 6,00=20
sdc 0,00 0,00 0,00 90,00 0,00 24624,00 547,20 3,44 38,22 0,00 38,22 3,7=
8 34,00=20
sdd 0,00 27,00 0,00 86,00 0,00 12660,00 294,42 2,70 31,40 0,00 31,40 3,=
26 28,00=20
sde 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,29 28,67 0,00 28,67 4,0=
0 18,00=20
sdf 0,00 29,00 0,00 70,00 0,00 8575,00 245,00 2,40 34,29 0,00 34,29 3,0=
0 21,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,81 0,00 7,74 0,90 0,00 89,55=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 30,00 0,00 19,00 0,00 204,00 21,47 0,12 6,32 0,00 6,32 5,79 11=
,00=20
sdb 0,00 0,00 0,00 77,00 0,00 20556,00 533,92 3,05 39,61 0,00 39,61 3,5=
1 27,00=20
sdc 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,11 24,67 0,00 24,67 3,3=
3 15,00=20
sdd 0,00 0,00 0,00 19,00 0,00 4752,00 500,21 0,54 22,63 0,00 22,63 4,21=
 8,00=20
sde 0,00 20,00 0,00 111,00 0,00 20827,50 375,27 4,11 37,03 0,00 37,03 3=
,42 38,00=20
sdf 0,00 0,00 0,00 32,00 0,00 8216,00 513,50 0,94 29,38 0,00 29,38 4,06=
 13,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,77 0,00 5,67 1,13 0,00 91,42=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 39,00 0,00 24,00 0,00 260,00 21,67 0,13 5,42 0,00 5,42 5,00 12=
,00=20
sdb 0,00 30,00 0,00 53,00 0,00 4428,50 167,11 1,63 30,75 0,00 30,75 2,8=
3 15,00=20
sdc 0,00 0,00 0,00 47,00 0,00 12320,00 524,26 1,14 24,26 0,00 24,26 3,1=
9 15,00=20
sdd 0,00 0,00 0,00 43,00 0,00 11672,00 542,88 1,01 26,05 0,00 26,05 3,2=
6 14,00=20
sde 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,35 21,88 0,00 21,88 3,12=
 5,00=20
sdf 0,00 0,00 0,00 61,00 0,00 16420,00 538,36 1,78 29,18 0,00 29,18 3,9=
3 24,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,95 0,00 6,55 1,80 0,00 88,70=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 56,00 0,00 31,00 0,00 1448,00 93,42 0,19 6,13 0,00 6,13 4,84 1=
5,00=20
sdb 0,00 0,00 0,00 81,00 0,00 21808,00 538,47 2,35 27,65 0,00 27,65 3,7=
0 30,00=20
sdc 0,00 30,00 0,00 75,00 0,00 8598,00 229,28 2,40 32,00 0,00 32,00 3,0=
7 23,00=20
sdd 0,00 0,00 0,00 76,00 0,00 20524,00 540,11 2,29 30,13 0,00 30,13 3,6=
8 28,00=20
sde 0,00 0,00 0,00 30,00 0,00 8208,00 547,20 0,94 31,33 0,00 31,33 3,67=
 11,00=20
sdf 0,00 0,00 0,00 30,00 0,00 8208,00 547,20 0,95 31,67 0,00 31,67 4,00=
 12,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,65 0,00 7,50 1,65 0,00 89,20=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 51,00 0,00 28,00 0,00 1452,00 103,71 0,17 6,07 0,00 6,07 5,00 =
14,00=20
sdb 0,00 0,00 0,00 41,00 0,00 11032,00 538,15 0,96 26,10 0,00 26,10 3,4=
1 14,00=20
sdc 0,00 0,00 0,00 61,00 0,00 16420,00 538,36 2,30 37,70 0,00 37,70 3,4=
4 21,00=20
sdd 0,00 0,00 0,00 32,00 0,00 8216,00 513,50 1,21 37,81 0,00 37,81 3,75=
 12,00=20
sde 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,31 29,11 0,00 29,11 3,3=
3 15,00=20
sdf 0,00 0,00 0,00 52,00 0,00 13604,00 523,23 1,45 24,04 0,00 24,04 3,6=
5 19,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,66 0,00 5,50 1,02 0,00 91,82=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 31,00 0,00 18,00 0,00 200,00 22,22 0,10 5,56 0,00 5,56 4,44 8,=
00=20
sdb 0,00 0,00 0,00 23,00 0,00 6032,00 524,52 0,74 23,04 0,00 23,04 3,48=
 8,00=20
sdc 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,29 28,67 0,00 28,67 3,7=
8 17,00=20
sdd 0,00 24,00 0,00 47,00 0,00 4363,00 185,66 1,48 24,04 0,00 24,04 2,9=
8 14,00=20
sde 0,00 0,00 0,00 75,00 0,00 20520,00 547,20 2,59 34,53 0,00 34,53 3,6=
0 27,00=20
sdf 0,00 30,00 0,00 93,00 0,00 15476,50 332,83 3,19 36,45 0,00 36,45 3,=
23 30,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
3,16 0,00 5,82 0,63 0,00 90,38=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 15,00 0,00 13,00 0,00 116,00 17,85 0,05 3,85 0,00 3,85 3,85 5,=
00=20
sdb 0,00 0,00 0,00 67,00 0,00 18592,00 554,99 1,73 28,96 0,00 28,96 3,5=
8 24,00=20
sdc 0,00 0,00 0,00 1,00 0,00 4,00 8,00 0,01 10,00 0,00 10,00 10,00 1,00=
=20
sdd 0,00 0,00 0,00 53,00 0,00 12362,00 466,49 1,88 42,08 0,00 42,08 3,2=
1 17,00=20
sde 0,00 27,00 0,00 99,00 0,00 16748,00 338,34 2,95 29,80 0,00 29,80 3,=
33 33,00=20
sdf 0,00 0,00 0,00 61,00 0,00 16417,00 538,26 2,42 39,67 0,00 39,67 3,4=
4 21,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,55 0,00 5,41 1,03 0,00 92,01=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 25,00 0,00 16,00 0,00 172,00 21,50 0,09 5,62 0,00 5,62 5,00 8,=
00=20
sdb 0,00 29,00 0,00 106,00 0,00 19941,50 376,25 4,73 43,49 0,00 43,49 3=
,11 33,00=20
sdc 0,00 0,00 0,00 46,00 0,00 12316,00 535,48 1,95 42,39 0,00 42,39 3,4=
8 16,00=20
sdd 0,00 0,00 0,00 15,00 0,00 4104,00 547,20 0,36 24,00 0,00 24,00 3,33=
 5,00=20
sde 0,00 0,00 0,00 61,00 0,00 16420,00 538,36 1,60 26,23 0,00 26,23 3,6=
1 22,00=20
sdf 0,00 0,00 0,00 15,00 0,00 4104,00 547,20 0,55 36,67 0,00 36,67 3,33=
 5,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
1,92 0,00 5,76 1,54 0,00 90,78=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 48,00 0,00 30,00 0,00 1412,00 94,13 0,18 6,00 0,00 6,00 4,67 1=
4,00=20
sdb 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,38 25,00 0,00 25,00 3,75=
 6,00=20
sdc 0,00 18,00 0,00 117,00 0,00 20817,50 355,85 3,83 32,74 0,00 32,74 2=
,99 35,00=20
sdd 0,00 0,00 0,00 61,00 0,00 16420,00 538,36 1,62 26,56 0,00 26,56 3,2=
8 20,00=20
sde 0,00 0,00 0,00 45,00 0,00 12312,00 547,20 1,24 27,56 0,00 27,56 3,5=
6 16,00=20
sdf 0,00 0,00 0,00 31,00 0,00 8212,00 529,81 0,85 27,42 0,00 27,42 3,87=
 12,00=20

avg-cpu: %user %nice %system %iowait %steal %idle=20
2,93 0,00 7,76 2,04 0,00 87,28=20

Device: rrqm/s wrqm/s r/s w/s rkB/s wkB/s avgrq-sz avgqu-sz await r_awa=
it w_await svctm %util=20
sda 0,00 60,00 0,00 34,00 0,00 1512,00 88,94 0,21 6,18 0,00 6,18 5,00 1=
7,00=20
sdb 0,00 0,00 0,00 64,00 0,00 17316,00 541,12 1,91 31,56 0,00 31,56 3,5=
9 23,00=20
sdc 0,00 0,00 0,00 77,00 0,00 20528,00 533,19 2,18 28,31 0,00 28,31 3,5=
1 27,00=20
sdd 0,00 0,00 0,00 33,00 0,00 8220,00 498,18 0,93 28,18 0,00 28,18 3,94=
 13,00=20
sde 0,00 0,00 0,00 63,00 0,00 16428,00 521,52 1,76 27,94 0,00 27,94 3,6=
5 23,00=20
sdf 0,00 0,00 0,00 16,00 0,00 4108,00 513,50 0,55 34,38 0,00 34,38 3,75=
 6,00=20


----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 18 Juin 2012 16:22:25=20
Objet: Re: iostat show constants write to osd disk with writeahead jour=
nal, normal behaviour ?=20

On 6/18/12 9:04 AM, Alexandre DERUMIER wrote:=20
> Hi Mark,=20
>=20
>>> Sorry I got behind at looking at your output last week. I've create=
d a=20
>>> seekwatcher movie of your blktrace results here:=20
>>>=20
>>> http://nhm.ceph.com/movies/mailinglist-tests/alex-test-3.4.mpg=20
>=20
> how do you create seekwatcher movie from blktrace ? (I'd like to crea=
te them myself, seem good to debug)=20

You'll need to download seekwatcher from Chris Mason's website. Get the=
=20
newest unstable version. To make movies you'll need mencoder. (It also=20
needs numpy and matplotlib). There is a small bug in the code where "&>=
=20
/dev/null" should be changed to "> /dev/null 2>&1". If you have trouble=
=20
let me know and I can send you a fixed version of the script.=20

>=20
>=20
>>> The results match up well with your iostat output. Peaks and valley=
s in=20
>>> the writes every couple of seconds. Low numbers of seeks, so probab=
ly=20
>>> not limited by the filestore (a quick "osd tell X bench" might conf=
irm=20
>>> that).=20
>=20
> yet, i'm pretty sure that the limitation if not hardware. (each osd a=
re 15k drive, handling around 10MB/S during the test, so I think it sho=
uld be ok ^_^ )=20
> how do you use "osd tell X bench" ?=20

Yeah, I just wanted to make sure that the constant writes weren't=20
because the filestore was falling behind. You may want to take a look=20
at some of the information that is provided by the admin socket for the=
=20
OSD while the test is running. dump_ops_in_flight, perf schema, and per=
f=20
dump are all useful.=20

Try:=20

ceph --admin-daemon <socket> help=20

The osd admin sockets should be available in /var/run/ceph.=20

>=20
>>> I'm wondering if you increase "filestore max sync interval" to some=
thing=20
>>> bigger (default is 5s) if you'd see somewhat different behavior. Ma=
ybe=20
>>> try something like 30s and see what happens?=20
>=20
> I have done test with 30s, that doesn't change nothing.=20
> I have try with filestore min sync interval =3D 29 + filestore max sy=
nc interval =3D 30=20
>=20

Nuts. Do you still see the little peaks/valleys every couple seconds?=20

>=20
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Mark Nelson"<mark.nelson@inktank.com>=20
> =C3=80: "Alexandre DERUMIER"<aderumier@odiso.com>=20
> Cc: ceph-devel@vger.kernel.org=20
> Envoy=C3=A9: Lundi 18 Juin 2012 15:29:58=20
> Objet: Re: iostat show constants write to osd disk with writeahead jo=
urnal, normal behaviour ?=20
>=20
> On 6/18/12 7:34 AM, Alexandre DERUMIER wrote:=20
>> Hi,=20
>>=20
>> I'm doing test with rados bench, and I see constant writes to osd di=
sks.=20
>> Is it the normal behaviour ? with write-ahead should write occur eac=
h 20-30 seconde ?=20
>>=20
>>=20
>> Cluster is=20
>> 3 nodes (ubuntu precise - glibc 2.14 - ceph 0.47.2) with each node 1=
 journal on tmpfs 8GB - 1 osd (xfs) on sas disk - 1 gigabit link=20
>>=20
>>=20
>> 8GB journal can handle easily 20s of write (1 gigabit link)=20
>>=20
>> [osd]=20
>> osd data =3D /srv/osd.$id=20
>> osd journal =3D /tmpfs/osd.$id.journal=20
>> osd journal size =3D 8000=20
>> journal dio =3D false=20
>> filestore journal parallel =3D false=20
>> filestore journal writeahead =3D true=20
>> filestore fiemap =3D false=20
>>=20
>>=20
>>=20
>>=20
>> I have done tests with differents kernel (3.0,3.2,3.4) , differents =
filesystem (xfs,btrfs,ext4), forced journal mode to writeahead.=20
>> Bench were done write rados bench and fio.=20
>>=20
>> I always have constant write since the first second of bench start.=20
>>=20
>> Any idea ?=20
>=20
> Hi Alex,=20
>=20
> Sorry I got behind at looking at your output last week. I've created =
a=20
> seekwatcher movie of your blktrace results here:=20
>=20
> http://nhm.ceph.com/movies/mailinglist-tests/alex-test-3.4.mpg=20
>=20
> The results match up well with your iostat output. Peaks and valleys =
in=20
> the writes every couple of seconds. Low numbers of seeks, so probably=
=20
> not limited by the filestore (a quick "osd tell X bench" might confir=
m=20
> that).=20
>=20
> I'm wondering if you increase "filestore max sync interval" to someth=
ing=20
> bigger (default is 5s) if you'd see somewhat different behavior. Mayb=
e=20
> try something like 30s and see what happens?=20
>=20
> Mark=20
>=20
>=20
>=20
>=20




--=20

--=20




Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20

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
