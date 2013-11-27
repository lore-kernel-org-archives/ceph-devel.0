From: Gregory Farnum <greg@inktank.com>
Subject: Re: How to use the class Filer in Ceph
Date: Wed, 27 Nov 2013 11:10:24 -0800
Message-ID: <CAPYLRzh-KAwag9iE_4axNVuiT7x41w=Z8+Qi5_AGva_gdYqofg@mail.gmail.com>
References: <7061367AB47B6A4EAE551551A9A197330100F1DA@S3-EXCHMB04.shared-svc.local>
	<CAPYLRzgMp8o-zSNoThNM71Aub7rVdQzCPVwOYXoL8yL93EeV_A@mail.gmail.com>
	<7061367AB47B6A4EAE551551A9A197330100F36F@S3-EXCHMB04.shared-svc.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:52301 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757907Ab3K0TK0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 14:10:26 -0500
Received: by mail-we0-f169.google.com with SMTP id w61so1586471wes.14
        for <ceph-devel@vger.kernel.org>; Wed, 27 Nov 2013 11:10:25 -0800 (PST)
In-Reply-To: <7061367AB47B6A4EAE551551A9A197330100F36F@S3-EXCHMB04.shared-svc.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Luo Shaobo (DSI)" <luosb@dsi.a-star.edu.sg>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm just skimming here, but your modifications appear to have broken
it pretty badly; notice how the modified client is not sending an
osd_op message?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Sun, Nov 24, 2013 at 11:44 PM, Luo Shaobo (DSI)
<luosb@dsi.a-star.edu.sg> wrote:
> Dear Greg,
>
> Thank you, I have tried to trace the log, the snapid should similar. =
Accurately, I'm modifying the source code of client, I want to implemen=
t a new MDS for it. Here list the two versions of log. The first one is=
 original log. The second one is the client log after I modified.
>
> Thank you and Best Regards
>
> Thomas
>
> The original log.
> 2013-11-25 15:43:37.236728 7fdd7484f780  3 client.5703 _ll_get_inode =
1000000003a.head
> 2013-11-25 15:43:37.236733 7fdd7484f780 10 client.5703 _getattr mask =
Xs issued=3D1
> 2013-11-25 15:43:37.236737 7fdd7484f780  3 client.5703 _getxattr(1000=
000003a, "security.capability", 0) =3D -61
> 2013-11-25 15:43:37.236785 7fdd7484f780  3 client.5703 ll_write 0x27b=
5c80 1000000003a 0~10
> 2013-11-25 15:43:37.236790 7fdd7484f780 10 client.5703 cur file size =
is 0
> 2013-11-25 15:43:37.236797 7fdd7484f780 10 client.5703 wanted_max_siz=
e 0 -> 10
> 2013-11-25 15:43:37.236800 7fdd7484f780 10 client.5703 check_caps on =
1000000003a.head(ref=3D3 cap_refs=3D{} open=3D{2=3D1} mode=3D102750 siz=
e=3D0 mtime=3D2013-11-26 00:10:28.056292 caps=3DpAsxLsXsxFsxcrwb(0=3DpA=
sxLsXsxFsxcrwb) objectset[1000000003a ts 0/0 objects 0 dirty_or_tx 0] p=
arents=3D0x27a1ba0 0x7fdd60097fa0) wanted pAsxXsxFxwb used - is_delayed=
=3D0
> 2013-11-25 15:43:37.236833 7fdd7484f780 10 client.5703 cap_delay_requ=
eue on 1000000003a.head(ref=3D3 cap_refs=3D{} open=3D{2=3D1} mode=3D102=
750 size=3D0 mtime=3D2013-11-26 00:10:28.056292 caps=3DpAsxLsXsxFsxcrwb=
(0=3DpAsxLsXsxFsxcrwb) objectset[1000000003a ts 0/0 objects 0 dirty_or_=
tx 0] parents=3D0x27a1ba0 0x7fdd60097fa0)
> 2013-11-25 15:43:37.236858 7fdd7484f780 10 client.5703  cap mds.0 iss=
ued pAsxLsXsxFsxcrwb implemented pAsxLsXsxFsxcrwb revoking -
> 2013-11-25 15:43:37.236873 7fdd7484f780 10 client.5703 delaying cap r=
elease
> 2013-11-25 15:43:37.236876 7fdd7484f780 10 client.5703 get_caps 10000=
00003a.head(ref=3D3 cap_refs=3D{} open=3D{2=3D1} mode=3D102750 size=3D0=
 mtime=3D2013-11-26 00:10:28.056292 caps=3DpAsxLsXsxFsxcrwb(0=3DpAsxLsX=
sxFsxcrwb) objectset[1000000003a ts 0/0 objects 0 dirty_or_tx 0] parent=
s=3D0x27a1ba0 0x7fdd60097fa0) have pAsxLsXsxFsxcrwb need Fw want Fb but=
 not Fb revoking -
> 2013-11-25 15:43:37.236923 7fdd7484f780 10 client.5703  snaprealm sna=
prealm(1 nref=3D2 c=3D0 seq=3D1 parent=3D0 my_snaps=3D[] cached_snapc=3D=
1=3D[])
> 2013-11-25 15:43:37.236930 7fdd7484f780  5 client.5703 get_cap_ref go=
t first FILE_BUFFER ref on 1000000003a.head(ref=3D4 cap_refs=3D{4096=3D=
1,8192=3D0} open=3D{2=3D1} mode=3D102750 size=3D0 mtime=3D2013-11-26 00=
:10:28.056292 caps=3DpAsxLsXsxFsxcrwb(0=3DpAsxLsXsxFsxcrwb) objectset[1=
000000003a ts 0/0 objects 0 dirty_or_tx 0] parents=3D0x27a1ba0 0x7fdd60=
097fa0)
> 2013-11-25 15:43:37.237052 7fdd7484f780 10 -- 192.168.35.82:0/2376 co=
nnect_rank to 192.168.35.84:6800/8058, creating pipe and registering
> 2013-11-25 15:43:37.237131 7fdd7484f780 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D-1 :0 s=3D1 pgs=3D0 cs=3D0=
 l=3D1 c=3D0x2843ab0).register_pipe
> 2013-11-25 15:43:37.237153 7fdd7484f780 10 -- 192.168.35.82:0/2376 ge=
t_connection osd.1 192.168.35.84:6800/8058 new 0x2843850
> 2013-11-25 15:43:37.237145 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D-1 :0 s=3D1 pgs=3D0 cs=3D0=
 l=3D1 c=3D0x2843ab0).writer: state =3D connecting policy.server=3D0
> 2013-11-25 15:43:37.237228 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D-1 :0 s=3D1 pgs=3D0 cs=3D0=
 l=3D1 c=3D0x2843ab0).connect 0
> 2013-11-25 15:43:37.237260 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :0 s=3D1 pgs=3D0 cs=3D0 =
l=3D1 c=3D0x2843ab0).connecting to 192.168.35.84:6800/8058
> 2013-11-25 15:43:37.237275 7fdd7484f780  1 -- 192.168.35.82:0/2376 --=
> 192.168.35.84:6800/8058 -- osd_op(client.5703.0:1 1000000003a.0000000=
0 [write 0~10 [1@-1]] 0.92a3958f snapc 1=3D[] e38) v4 -- ?+0 0x2844090 =
con 0x2843ab0
> 2013-11-25 15:43:37.237299 7fdd7484f780 20 -- 192.168.35.82:0/2376 su=
bmit_message osd_op(client.5703.0:1 1000000003a.00000000 [write 0~10 [1=
@-1]] 0.92a3958f snapc 1=3D[] e38) v4 remote, 192.168.35.84:6800/8058, =
have pipe.
> 2013-11-25 15:43:37.238043 7fdd7040f700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D1 pgs=3D0 cs=3D=
0 l=3D1 c=3D0x2843ab0).connect read peer addr 192.168.35.84:6800/8058 o=
n socket 0
> 2013-11-25 15:43:37.238072 7fdd7040f700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D1 pgs=3D0 cs=3D=
0 l=3D1 c=3D0x2843ab0).connect peer addr for me is 192.168.35.82:33572/=
0
> 2013-11-25 15:43:37.238101 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D1 pgs=3D0 cs=3D=
0 l=3D1 c=3D0x2843ab0).connect sent my addr 192.168.35.82:0/2376
> 2013-11-25 15:43:37.238164 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D1 pgs=3D0 cs=3D=
0 l=3D1 c=3D0x2843ab0).connect.authorizer_len=3D174 protocol=3D2
> 2013-11-25 15:43:37.238197 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D1 pgs=3D0 cs=3D=
0 l=3D1 c=3D0x2843ab0).connect sending gseq=3D3 cseq=3D0 proto=3D24
> 2013-11-25 15:43:37.238216 7fdd7040f700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D1 pgs=3D0 cs=3D=
0 l=3D1 c=3D0x2843ab0).connect wrote (self +) cseq, waiting for reply
> 2013-11-25 15:43:37.238840 7fdd7040f700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D1 pgs=3D0 cs=3D=
0 l=3D1 c=3D0x2843ab0).connect got reply tag 1 connect_seq 1 global_seq=
 1118592 proto 24 flags 1 features 34359738367
> 2013-11-25 15:43:37.238859 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D1 pgs=3D0 cs=3D=
0 l=3D1 c=3D0x2843ab0).reply.authorizer_len=3D36
> 2013-11-25 15:43:37.238903 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).connect success 1, lossy =3D 1, features=
 34359738367
> 2013-11-25 15:43:37.238936 7fdd7040f700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).connect starting reader
> 2013-11-25 15:43:37.238947 7fdd6a7fc700 10 client.5703 ms_handle_conn=
ect on 192.168.35.84:6800/8058
> 2013-11-25 15:43:37.239019 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).writer: state =3D open policy.server=3D0
> 2013-11-25 15:43:37.239038 7fdd7040f700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).writer encoding 1 features 34359738367 0=
x2844090 osd_op(client.5703.0:1 1000000003a.00000000 [write 0~10 [1@-1]=
] 0.92a3958f snapc 1=3D[] e38) v4
> 2013-11-25 15:43:37.239105 7fdd7040f700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).writer signed seq # 1): sig =3D 24422482=
693570454
> 2013-11-25 15:43:37.239125 7fdd7040f700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).writer sending 1 0x2844090
> 2013-11-25 15:43:37.239150 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).writer: state =3D open policy.server=3D0
> 2013-11-25 15:43:37.239164 7fdd7040f700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).writer sleeping
> 2013-11-25 15:43:37.239139 7fdd7030e700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).reader reading tag...
> 2013-11-25 15:43:37.253029 7fdd7030e700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).reader got ACK
> 2013-11-25 15:43:37.253052 7fdd7030e700 15 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).reader got ack seq 1
> 2013-11-25 15:43:37.253063 7fdd7030e700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).reader reading tag...
> 2013-11-25 15:43:37.253074 7fdd7030e700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).reader got MSG
> 2013-11-25 15:43:37.253086 7fdd7030e700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).reader got envelope type=3D43 src osd.1 =
front=3D119 data=3D0 off 0
> 2013-11-25 15:43:37.253106 7fdd7030e700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).reader wants 119 from dispatch throttler=
 0/104857600
> 2013-11-25 15:43:37.253122 7fdd7030e700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).reader got front 119
> 2013-11-25 15:43:37.253137 7fdd7030e700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).aborted =3D 0
> 2013-11-25 15:43:37.253146 7fdd7030e700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).reader got 119 + 0 + 0 byte message
> 2013-11-25 15:43:37.253220 7fdd7030e700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).reader got message 1 0x7fdd3c0017d0 osd_=
op_reply(1 1000000003a.00000000 [write 0~10] v38'1 uv1 ondisk =3D 0) v4
> 2013-11-25 15:43:37.253243 7fdd7030e700 20 -- 192.168.35.82:0/2376 qu=
eue 0x7fdd3c0017d0 prio 127
> 2013-11-25 15:43:37.253257 7fdd7030e700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).reader reading tag...
> 2013-11-25 15:43:37.253264 7fdd6a7fc700  1 -- 192.168.35.82:0/2376 <=3D=
=3D osd.1 192.168.35.84:6800/8058 1 =3D=3D=3D=3D osd_op_reply(1 1000000=
003a.00000000 [write 0~10] v38'1 uv1 ondisk =3D 0) v4 =3D=3D=3D=3D 119+=
0+0 (2991878044 0 0) 0x7fdd3c0017d0 con 0x2843ab0
> 2013-11-25 15:43:37.253283 7fdd6a7fc700  1 client.5703 ms_dispatch ms=
g 43
> 2013-11-25 15:43:37.253319 7fdd6a7fc700 10 client.5703 check_caps on =
1000000003a.head(ref=3D5 cap_refs=3D{4096=3D1,8192=3D0} open=3D{2=3D1} =
mode=3D102750 size=3D0 mtime=3D2013-11-26 00:10:28.056292 caps=3DpAsxLs=
XsxFsxcrwb(0=3DpAsxLsXsxFsxcrwb) objectset[1000000003a ts 0/0 objects 0=
 dirty_or_tx 0] parents=3D0x27a1ba0 0x7fdd60097fa0) wanted pAsxXsxFxwb =
used Fw is_delayed=3D0
> 2013-11-25 15:43:37.253360 7fdd6a7fc700 10 client.5703 cap_delay_requ=
eue on 1000000003a.head(ref=3D5 cap_refs=3D{4096=3D1,8192=3D0} open=3D{=
2=3D1} mode=3D102750 size=3D0 mtime=3D2013-11-26 00:10:28.056292 caps=3D=
pAsxLsXsxFsxcrwb(0=3DpAsxLsXsxFsxcrwb) objectset[1000000003a ts 0/0 obj=
ects 0 dirty_or_tx 0] parents=3D0x27a1ba0 0x7fdd60097fa0)
> 2013-11-25 15:43:37.253395 7fdd6a7fc700 10 client.5703  cap mds.0 iss=
ued pAsxLsXsxFsxcrwb implemented pAsxLsXsxFsxcrwb revoking -
> 2013-11-25 15:43:37.253409 7fdd6a7fc700 10 client.5703 delaying cap r=
elease
> 2013-11-25 15:43:37.253411 7fdd6a7fc700  5 client.5703 put_cap_ref dr=
opped last FILE_BUFFER ref on 1000000003a.head(ref=3D5 cap_refs=3D{4096=
=3D1,8192=3D0} open=3D{2=3D1} mode=3D102750 size=3D0 mtime=3D2013-11-26=
 00:10:28.056292 caps=3DpAsxLsXsxFsxcrwb(0=3DpAsxLsXsxFsxcrwb) objectse=
t[1000000003a ts 0/0 objects 0 dirty_or_tx 0] parents=3D0x27a1ba0 0x7fd=
d60097fa0)
> 2013-11-25 15:43:37.253436 7fdd6a7fc700 10 client.5703 put_inode on 1=
000000003a.head(ref=3D5 cap_refs=3D{4096=3D1,8192=3D0} open=3D{2=3D1} m=
ode=3D102750 size=3D0 mtime=3D2013-11-26 00:10:28.056292 caps=3DpAsxLsX=
sxFsxcrwb(0=3DpAsxLsXsxFsxcrwb) objectset[1000000003a ts 0/0 objects 0 =
dirty_or_tx 0] parents=3D0x27a1ba0 0x7fdd60097fa0)
> 2013-11-25 15:43:37.253459 7fdd6a7fc700 15 client.5703 sync_write_com=
mit unsafe_sync_write =3D 0
> 2013-11-25 15:43:37.253477 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).writer: state =3D open policy.server=3D0
> 2013-11-25 15:43:37.253489 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).write_ack 1
> 2013-11-25 15:43:37.253502 7fdd7040f700 10 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).writer: state =3D open policy.server=3D0
> 2013-11-25 15:43:37.253462 7fdd6a7fc700 10 client.5703 put_inode on 1=
000000003a.head(ref=3D4 cap_refs=3D{4096=3D1,8192=3D0} open=3D{2=3D1} m=
ode=3D102750 size=3D0 mtime=3D2013-11-26 00:10:28.056292 caps=3DpAsxLsX=
sxFsxcrwb(0=3DpAsxLsXsxFsxcrwb) objectset[1000000003a ts 0/0 objects 0 =
dirty_or_tx 0] parents=3D0x27a1ba0 0x7fdd60097fa0)
> 2013-11-25 15:43:37.253511 7fdd7040f700 20 -- 192.168.35.82:0/2376 >>=
 192.168.35.84:6800/8058 pipe(0x2843850 sd=3D0 :33572 s=3D2 pgs=3D11185=
92 cs=3D1 l=3D1 c=3D0x2843ab0).writer sleeping
> 2013-11-25 15:43:37.253521 7fdd6a7fc700 10 -- 192.168.35.82:0/2376 di=
spatch_throttle_release 119 to dispatch throttler 119/104857600
> 2013-11-25 15:43:37.253531 7fdd6a7fc700 20 -- 192.168.35.82:0/2376 do=
ne calling dispatch on 0x7fdd3c0017d0
> 2013-11-25 15:43:37.253535 7fdd7484f780 10 client.5703 mark_caps_dirt=
y 1000000003a.head(ref=3D3 cap_refs=3D{4096=3D1,8192=3D0} open=3D{2=3D1=
} mode=3D102750 size=3D10 mtime=3D2013-11-26 00:10:28.056292 caps=3DpAs=
xLsXsxFsxcrwb(0=3DpAsxLsXsxFsxcrwb) objectset[1000000003a ts 0/0 object=
s 0 dirty_or_tx 0] parents=3D0x27a1ba0 0x7fdd60097fa0) - -> Fw
> 2013-11-25 15:43:37.253572 7fdd7484f780  7 client.5703 wrote to 10, e=
xtending file size
> 2013-11-25 15:43:37.253576 7fdd7484f780 10 client.5703 mark_caps_dirt=
y 1000000003a.head(ref=3D4 cap_refs=3D{4096=3D1,8192=3D0} open=3D{2=3D1=
} mode=3D102750 size=3D10 mtime=3D2013-11-25 15:43:37.253576 caps=3DpAs=
xLsXsxFsxcrwb(0=3DpAsxLsXsxFsxcrwb) dirty_caps=3DFw objectset[100000000=
3a ts 0/0 objects 0 dirty_or_tx 0] parents=3D0x27a1ba0 0x7fdd60097fa0) =
=46w -> Fw
> 2013-11-25 15:43:37.253608 7fdd7484f780  3 client.5703 ll_write 0x27b=
5c80 0~10 =3D 10
> 2013-11-25 15:43:37.253712 7fdd7484f780  3 client.5703 ll_release 0x2=
7b5c80 1000000003a
> 2013-11-25 15:43:37.253726 7fdd7484f780  5 client.5703 _release_fh 0x=
27b5c80 mode 2 on 1000000003a.head(ref=3D4 cap_refs=3D{4096=3D0,8192=3D=
0} open=3D{2=3D1} mode=3D102750 size=3D10 mtime=3D2013-11-25 15:43:37.2=
53576 caps=3DpAsxLsXsxFsxcrwb(0=3DpAsxLsXsxFsxcrwb) dirty_caps=3DFw obj=
ectset[1000000003a ts 0/0 objects 0 dirty_or_tx 0] parents=3D0x27a1ba0 =
0x7fdd60097fa0)
> 2013-11-25 15:43:37.253781 7fdd7484f780 10 client.5703 _flush 1000000=
003a.head(ref=3D4 cap_refs=3D{4096=3D0,8192=3D0} open=3D{2=3D0} mode=3D=
102750 size=3D10 mtime=3D2013-11-25 15:43:37.253576 caps=3DpAsxLsXsxFsx=
crwb(0=3DpAsxLsXsxFsxcrwb) dirty_caps=3DFw objectset[1000000003a ts 0/0=
 objects 0 dirty_or_tx 0] parents=3D0x27a1ba0 0x7fdd60097fa0)
> 2013-11-25 15:43:37.253812 7fdd7484f780 10 client.5703  nothing to fl=
ush
>
>
> My Log.
>
>
> client.5705 ll_getxattr 10000000034.head security.capability size 0
> 2013-11-25 15:46:15.468656 7fb1b37a4780  3 client.5705 _ll_get_inode =
10000000034.head
> 2013-11-25 15:46:15.468660 7fb1b37a4780 10 client.5705 _getattr mask =
Xs issued=3D0
> 2013-11-25 15:46:15.468672 7fb1b37a4780 10 client.5705 _getattr resul=
t=3D0
> 2013-11-25 15:46:15.468675 7fb1b37a4780  3 client.5705 _getxattr(1000=
0000034, "security.capability", 0) =3D -61
> 2013-11-25 15:46:15.468721 7fb1b37a4780  3 client.5705 ll_write 0x31f=
3730 10000000034 0~10
> 2013-11-25 15:46:15.468728 7fb1b37a4780 10 client.5705 cur file size =
is 0
> 2013-11-25 15:46:15.468735 7fb1b37a4780 10 client.5705  snaprealm sna=
prealm(10000000034 nref=3D0 c=3D0 seq=3D0 parent=3D0 my_snaps=3D[] cach=
ed_snapc=3D0=3D[])
> 2013-11-25 15:46:15.468846 7fb1b37a4780  1 -- 192.168.35.82:0/2491 --=
> 192.168.36.206:6789/0 -- mon_subscribe({mdsmap=3D0+,monmap=3D2+,osdma=
p=3D39}) v2 -- ?+0 0x3254f10 con 0x31e1e20
> 2013-11-25 15:46:15.468865 7fb1b37a4780 20 -- 192.168.35.82:0/2491 su=
bmit_message mon_subscribe({mdsmap=3D0+,monmap=3D2+,osdmap=3D39}) v2 re=
mote, 192.168.36.206:6789/0, have pipe.
> 2013-11-25 15:46:15.468894 7fb1b37a4780  1 -- 192.168.35.82:0/2491 --=
> 192.168.36.206:6789/0 -- mon_get_version(what=3Dosdmap handle=3D1) v1=
 -- ?+0 0x3255520 con 0x31e1e20
> 2013-11-25 15:46:15.468896 7fb1b379c700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer: state =3D open policy.server=3D0
> 2013-11-25 15:46:15.468949 7fb1b379c700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer encoding 6 features 34359738367 0x3254f10=
 mon_subscribe({mdsmap=3D0+,monmap=3D2+,osdmap=3D39}) v2
> 2013-11-25 15:46:15.468992 7fb1b379c700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer no session security
> 2013-11-25 15:46:15.469007 7fb1b379c700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer sending 6 0x3254f10
> 2013-11-25 15:46:15.469019 7fb1b37a4780 20 -- 192.168.35.82:0/2491 su=
bmit_message mon_get_version(what=3Dosdmap handle=3D1) v1 remote, 192.1=
68.36.206:6789/0, have pipe.
> 2013-11-25 15:46:15.469044 7fb1b379c700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer: state =3D open policy.server=3D0
> 2013-11-25 15:46:15.469056 7fb1b379c700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer encoding 7 features 34359738367 0x3255520=
 mon_get_version(what=3Dosdmap handle=3D1) v1
> 2013-11-25 15:46:15.469084 7fb1b379c700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer no session security
> 2013-11-25 15:46:15.469094 7fb1b379c700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer sending 7 0x3255520
> 2013-11-25 15:46:15.469114 7fb1b379c700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer: state =3D open policy.server=3D0
> 2013-11-25 15:46:15.469124 7fb1b379c700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer sleeping
> 2013-11-25 15:46:15.469953 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got ACK
> 2013-11-25 15:46:15.469978 7fb1b0669700 15 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got ack seq 6
> 2013-11-25 15:46:15.469989 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader reading tag...
> 2013-11-25 15:46:15.470000 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got MSG
> 2013-11-25 15:46:15.470012 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got envelope type=3D21 src mon.0 front=3D=
591 data=3D0 off 0
> 2013-11-25 15:46:15.470031 7fb1b0669700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader wants 591 from dispatch throttler 0/10485=
7600
> 2013-11-25 15:46:15.470050 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got front 591
> 2013-11-25 15:46:15.470062 7fb1b0669700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).aborted =3D 0
> 2013-11-25 15:46:15.470071 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got 591 + 0 + 0 byte message
> 2013-11-25 15:46:15.470088 7fb1b0669700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).No session security set
> 2013-11-25 15:46:15.470104 7fb1b0669700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got message 9 0x7fb1980023d0 mdsmap(e 82)=
 v1
> 2013-11-25 15:46:15.470115 7fb1b0669700 20 -- 192.168.35.82:0/2491 qu=
eue 0x7fb1980023d0 prio 196
> 2013-11-25 15:46:15.470131 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader reading tag...
> 2013-11-25 15:46:15.470144 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got MSG
> 2013-11-25 15:46:15.470141 7fb1a17fa700  1 -- 192.168.35.82:0/2491 <=3D=
=3D mon.0 192.168.36.206:6789/0 9 =3D=3D=3D=3D mdsmap(e 82) v1 =3D=3D=3D=
=3D 591+0+0 (2957863745 0 0) 0x7fb1980023d0 con 0x31e1e20
> 2013-11-25 15:46:15.470163 7fb1a17fa700 10 client.5705 CEPH_MSG_MDS_M=
AP
> 2013-11-25 15:46:15.470156 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got envelope type=3D16 src mon.0 front=3D=
20 data=3D0 off 0
> 2013-11-25 15:46:15.470166 7fb1a17fa700 10 -- 192.168.35.82:0/2491 di=
spatch_throttle_release 591 to dispatch throttler 591/104857600
> 2013-11-25 15:46:15.470167 7fb1b0669700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader wants 20 from dispatch throttler 591/1048=
57600
> 2013-11-25 15:46:15.470174 7fb1a17fa700 20 -- 192.168.35.82:0/2491 do=
ne calling dispatch on 0x7fb1980023d0
> 2013-11-25 15:46:15.470182 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got front 20
> 2013-11-25 15:46:15.470205 7fb1b0669700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).aborted =3D 0
> 2013-11-25 15:46:15.470214 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got 20 + 0 + 0 byte message
> 2013-11-25 15:46:15.470231 7fb1b0669700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).No session security set
> 2013-11-25 15:46:15.470240 7fb1b0669700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got message 10 0x7fb198003340 mon_subscri=
be_ack(300s) v1
> 2013-11-25 15:46:15.470250 7fb1b0669700 20 -- 192.168.35.82:0/2491 qu=
eue 0x7fb198003340 prio 196
> 2013-11-25 15:46:15.470259 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader reading tag...
> 2013-11-25 15:46:15.470265 7fb1a17fa700  1 -- 192.168.35.82:0/2491 <=3D=
=3D mon.0 192.168.36.206:6789/0 10 =3D=3D=3D=3D mon_subscribe_ack(300s)=
 v1 =3D=3D=3D=3D 20+0+0 (174772310 0 0) 0x7fb198003340 con 0x31e1e20
> 2013-11-25 15:46:15.470275 7fb1b379c700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer: state =3D open policy.server=3D0
> 2013-11-25 15:46:15.470287 7fb1b379c700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).write_ack 10
> 2013-11-25 15:46:15.470291 7fb1a17fa700 10 -- 192.168.35.82:0/2491 di=
spatch_throttle_release 20 to dispatch throttler 20/104857600
> 2013-11-25 15:46:15.470298 7fb1a17fa700 20 -- 192.168.35.82:0/2491 do=
ne calling dispatch on 0x7fb198003340
> 2013-11-25 15:46:15.470299 7fb1b379c700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer: state =3D open policy.server=3D0
> 2013-11-25 15:46:15.470309 7fb1b379c700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer sleeping
> 2013-11-25 15:46:15.539041 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got ACK
> 2013-11-25 15:46:15.539063 7fb1b0669700 15 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got ack seq 7
> 2013-11-25 15:46:15.539073 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader reading tag...
> 2013-11-25 15:46:15.539083 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got MSG
> 2013-11-25 15:46:15.539094 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got envelope type=3D20 src mon.0 front=3D=
24 data=3D0 off 0
> 2013-11-25 15:46:15.539109 7fb1b0669700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader wants 24 from dispatch throttler 0/104857=
600
> 2013-11-25 15:46:15.539124 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got front 24
> 2013-11-25 15:46:15.539136 7fb1b0669700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).aborted =3D 0
> 2013-11-25 15:46:15.539144 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got 24 + 0 + 0 byte message
> 2013-11-25 15:46:15.539155 7fb1b0669700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).No session security set
> 2013-11-25 15:46:15.539167 7fb1b0669700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader got message 11 0x7fb1980044d0 mon_check_m=
ap_ack(handle=3D1 version=3D38) v2
> 2013-11-25 15:46:15.539177 7fb1b0669700 20 -- 192.168.35.82:0/2491 qu=
eue 0x7fb1980044d0 prio 196
> 2013-11-25 15:46:15.539187 7fb1b0669700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).reader reading tag...
> 2013-11-25 15:46:15.539192 7fb1a17fa700  1 -- 192.168.35.82:0/2491 <=3D=
=3D mon.0 192.168.36.206:6789/0 11 =3D=3D=3D=3D mon_check_map_ack(handl=
e=3D1 version=3D38) v2 =3D=3D=3D=3D 24+0+0 (4174327601 0 0) 0x7fb198004=
4d0 con 0x31e1e20
> 2013-11-25 15:46:15.539201 7fb1b379c700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer: state =3D open policy.server=3D0
> 2013-11-25 15:46:15.539213 7fb1b379c700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).write_ack 11
> 2013-11-25 15:46:15.539223 7fb1b379c700 10 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer: state =3D open policy.server=3D0
> 2013-11-25 15:46:15.539220 7fb1a17fa700 10 -- 192.168.35.82:0/2491 di=
spatch_throttle_release 24 to dispatch throttler 24/104857600
> 2013-11-25 15:46:15.539238 7fb1a17fa700 20 -- 192.168.35.82:0/2491 do=
ne calling dispatch on 0x7fb1980044d0
> 2013-11-25 15:46:15.539234 7fb1b379c700 20 -- 192.168.35.82:0/2491 >>=
 192.168.36.206:6789/0 pipe(0x31e1bc0 sd=3D5 :45579 s=3D2 pgs=3D12 cs=3D=
1 l=3D1 c=3D0x31e1e20).writer sleeping
> 2013-11-25 15:46:15.539280 7fb1a8ff9700 15 client.5705 sync_write_com=
mit unsafe_sync_write =3D 0
> 2013-11-25 15:46:15.539333 7fb1a8ff9700 10 client.5705 put_inode on 1=
0000000034.head(ref=3D4 cap_refs=3D{} open=3D{2=3D1} mode=3D102450 size=
=3D0 mtime=3D2013-11-25 15:46:15.468439 caps=3D- objectset[10000000034 =
ts 1/18446744073709551615 objects 0 dirty_or_tx 0] parents=3D0x31d4ba0 =
0x3253480)
> 2013-11-25 15:46:15.539383 7fb1a8ff9700 10 client.5705 put_inode left=
 3
> 2013-11-25 15:46:15.539412 7fb1b37a4780  7 client.5705 wrote to 10, e=
xtending file size
> 2013-11-25 15:46:15.539423 7fb1b37a4780  3 client.5705 ll_write 0x31f=
3730 0~10 =3D 10
> 2013-11-25 15:46:15.539525 7fb1b37a4780  3 client.5705 ll_release 0x3=
1f3730 10000000034
> 2013-11-25 15:46:15.539530 7fb1b37a4780  5 client.5705 _release_fh 0x=
31f3730 mode 2 on 10000000034.head(ref=3D3 cap_refs=3D{} open=3D{2=3D1}=
 mode=3D102450 size=3D10 mtime=3D2013-11-25 15:46:15.539420 caps=3D- ob=
jectset[10000000034 ts 1/18446744073709551615 objects 0 dirty_or_tx 0] =
parents=3D0x31d4ba0 0x3253480)
> 2013-11-25 15:46:15.539550 7fb1b37a4780 10 client.5705 _flush 1000000=
0034.head(ref=3D3 cap_refs=3D{} open=3D{2=3D0} mode=3D102450 size=3D10 =
mtime=3D2013-11-25 15:46:15.539420 caps=3D- objectset[10000000034 ts 1/=
18446744073709551615 objects 0 dirty_or_tx 0] parents=3D0x31d4ba0 0x325=
3480)
> 2013-11-25 15:46:15.539563 7fb1b37a4780 10 client.5705  nothing to fl=
ush
>
>
> -----Original Message-----
> From: Gregory Farnum [mailto:greg@inktank.com]
> Sent: Monday, 25 November, 2013 2:22 PM
> To: Luo Shaobo (DSI)
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: How to use the class Filer in Ceph
>
> I haven't looked at the Filer code (or anything around it) in a while=
, but if I were to guess, "in->snapid" is set to something which doesn'=
t exist.
>
> Are you actually using the Filer in some new code that includes inode=
s, or modifying the Client classes? Looking at how they initialize thin=
gs should help you through this.
> Also, you could turn on messenger debugging to see exactly what your =
program is sending to the OSDs and check if that looks right (and, if n=
ecessary, turn on OSD debugging and see what's making it decide ENOENT)=
=2E
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>
> On Thu, Nov 21, 2013 at 9:30 PM, Luo Shaobo (DSI) <luosb@dsi.a-star.e=
du.sg> wrote:
>> Dear All,
>>
>>    Currently, I=E2=80=99m using the class Filer to operate the OSD d=
irectly. And below list the codes.
>> The write_trunc routing return success, but I can=E2=80=99t read bac=
k the object, and I got r =3D -2,  -ENOENT.
>> Would anyone help me to answer the question that how to use those fu=
nctions?  Thanks!
>>
>> The input parameters are:
>> in->ino =3D 0x10000000035;
>> In->layout.fl_stripe_unit =3D stripe_unit =3D 4194304;
>> In->layout.fl_stripe_count =3D stripe_count =3D 1; layout.fl_object_=
size =3D
>> In->object_size =3D 4194304; layout.fl_pg_pool =3D 0;
>> in->snaprealm =3D new SnapRealm(in->ino);
>> in->snaprealm->build_snap_context();
>>
>> The writing code looks like this.
>>     Mutex flock("MClient::_write flock");
>>     Cond cond;
>>     bool done =3D false;
>>     Context *onfinish =3D new C_SafeCond(&flock, &cond, &done);
>>     Context *onsafe =3D new C_Client_SyncCommit(this, in);
>>
>>     unsafe_sync_write++;
>>     get_cap_ref(in, CEPH_CAP_FILE_BUFFER);  // released by onsafe
>> callback
>>
>>     r =3D filer->write_trunc(in->ino, &in->layout, in->snaprealm->ge=
t_snap_context(),
>>                                                    offset, size, bl,=
 ceph_clock_now(cct), 0,
>>                                                    in->truncate_size=
, in->truncate_seq,
>>                                                    onfinish, onsafe)=
;
>>     if (r < 0)
>>       goto done;
>>
>>     client_lock.Unlock();
>>     flock.Lock();
>>     while (!done)
>>       cond.Wait(flock);
>>=E3=80=80 flock.Unlock();
>>
>> The reading code looks like this.
>>
>> Mutex flock("MClient::_read_sync flock"); bool done =3D false;
>>     Context *onfinish =3D new C_SafeCond(&flock, &cond, &done, &r);
>>     bufferlist tbl;
>>
>>     int wanted =3D left;
>>     filer->read_trunc(in->ino, &in->layout, in->snapid,
>>                                       pos, left, &tbl, 0,
>>                                       in->truncate_size, in->truncat=
e_seq,
>>                                       onfinish);
>>     client_lock.Unlock();
>>     flock.Lock();
>>     while (!done)
>>       cond.Wait(flock);
>>=E3=80=80 flock.Unlock();
>>
>> Thomas
>
> ________________________________
> This email and any attachments are confidential and may be privileged=
=2E If you are not the intended recipient, please delete it and notify =
us immediately. Please do not copy or use it for any purpose, or disclo=
se its contents to any other person. This email does not constitute a c=
ontract offer, a contract amendment, or an acceptance of a contract off=
er. Thank you.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
