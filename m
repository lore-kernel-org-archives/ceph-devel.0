From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 15:45:23 +0200
Message-ID: <4FC775F3.8080109@univ-nantes.fr>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com> <4FC5BF27.5060704@profihost.ag> <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com> <4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag> <4FC62BB0.1020003@inktank.com> <4FC66A1F.1080407@profihost.ag> <CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com> <4FC68CAA.9030708@profihost.ag> <CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com> <4FC7197D.5010406@profihost.ag> <CAC-hyiFjRFLVHYUKv8bGG0u8u2ZrHgP78U2Txt+3R7GGwtopZA@mail.gmail.com> <4FC77045.6050907@univ-nantes.fr> <4FC77407.1050401@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-lmb.cpub.univ-nantes.fr ([193.52.103.110]:34124 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757948Ab2EaNp3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 09:45:29 -0400
In-Reply-To: <4FC77407.1050401@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Stefan Majer <stefan.majer@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

On 31/05/2012 15:37, Stefan Priebe - Profihost AG wrote:
> Am 31.05.2012 15:21, schrieb Yann Dupont:
>> On 31/05/2012 09:30, Yehuda Sadeh wrote:
>>> On Thu, May 31, 2012 at 12:10 AM, Stefan Priebe - Profihost AG
>>> <s.priebe@profihost.ag> wrote:
>> But very strangely it's now rbd that isn't stable ?!
>>
>> root@label5:~# rados -p rbd bench 20 write -t 16
>> Maintaining 16 concurrent writes of 4194304 bytes for at least 20
>> seconds.
>> sec Cur ops started finished avg MB/s cur MB/s last lat avg lat
>> 0 0 0 0 0 0 - 0
>> 1 16 155 139 555.87 556 0.046232 0.109021
>> 2 16 250 234 467.923 380 0.046793 0.0985316
>> 3 16 250 234 311.955 0 - 0.0985316
>> 4 16 250 234 233.965 0 - 0.0985316
>> 5 16 250 234 187.173 0 - 0.0985316
>> 6 16 266 250 166.645 16 0.038083 0.175697
>> 7 16 266 250 142.839 0 - 0.175697
>> 8 16 441 425 212.475 350 0.05512 0.298391
>> 9 16 476 460 204.422 140 0.04372 0.280483
>> 10 16 531 515 205.976 220 0.125076 0.309449
>> 11 16 734 718 261.06 812 0.127582 0.244134
>> 12 16 795 779 259.637 244 0.065158 0.234156
>> 13 16 818 802 246.742 92 0.054514 0.241704
>> 14 16 830 814 232.546 48 0.044386 0.239006
>> 15 16 837 821 218.909 28 3.41523 0.267521
>> 16 16 1043 1027 256.721 824 0.04898 0.248212
>> 17 16 1147 1131 266.088 416 0.048591 0.232725
>> 18 16 1147 1131 251.305 0 - 0.232725
>> 19 16 1202 1186 249.657 110 0.081777 0.25501
>> min lat: 0.033773 max lat: 5.92059 avg lat: 0.245711
>> sec Cur ops started finished avg MB/s cur MB/s last lat avg lat
>> 20 16 1296 1280 255.97 376 0.053797 0.245711
>> 21 9 1297 1288 245.305 32 0.708133 0.248248
>> 22 9 1297 1288 234.155 0 - 0.248248
>> 23 9 1297 1288 223.975 0 - 0.248248
>> 24 9 1297 1288 214.643 0 - 0.248248
>> 25 9 1297 1288 206.057 0 - 0.248248
>> 26 9 1297 1288 198.131 0 - 0.248248
>> Total time run: 26.829870
>> Total writes made: 1297
>> Write size: 4194304
>> Bandwidth (MB/sec): 193.367
>>
>> Average Latency: 0.295922
>> Max latency: 7.36701
>> Min latency: 0.033773
>>
>>
>> Strange. I'm wondering if this has something to do with cache (that =
is,
>> operation I could have done before on nodes, as all my nodes are jus=
t
>> freshly rebooted).
>
> Please test setting these values on all OSDs and Clients:
> sysctl -w net.ipv4.tcp_rmem=3D"4096        87380   514873"
> sysctl -w net.ipv4.tcp_wmem=3D"4096        16384   514873"
>
> Stefan

same. stable for pool data (845 MB/s average), jumping with rbd (229=20
average, with a max latency of 6).

I'm with latest linus git kernel
(commit af56e0aa35f3ae2a4c1a6d1000702df1dd78cb76) , and I based on the=20
fact that the patch was reversed on it.

I can try with plain 3.4.0 with 'culprit patch' manually reversed.

what puzzles me is that this morning, with 3.4.0 it was rbd that was=20
stable, and now I have the exact contrary.

I'll begin to reboot with old 3.4.0 kernel to see if things are=20
reproductible.

Cheers,
--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
