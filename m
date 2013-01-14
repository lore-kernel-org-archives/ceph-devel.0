From: Wido den Hollander <wido@widodh.nl>
Subject: Re: CephFS issue
Date: Mon, 14 Jan 2013 10:07:21 +0100
Message-ID: <50F3CAC9.5040701@widodh.nl>
References: <CAEqYNSYaMvprh580HNosaQe7ahMmT-iB9irMsgA87tE2fwtCTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:55369 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab3ANJHP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 04:07:15 -0500
In-Reply-To: <CAEqYNSYaMvprh580HNosaQe7ahMmT-iB9irMsgA87tE2fwtCTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Alexis_G=DCNST_HORN?= <alexis.gunsthorn@outscale.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 01/14/2013 08:51 AM, Alexis G=DCNST HORN wrote:
> Hello,
>
> I've a 0.56.1 Ceph cluster up and running. RBD is working fine, but
> i've some troubles with CephFS.
>
> Here is my config :
>
> - only 2 OSD nodes, with 10 disks each + SSD for journal.
> - OSDs hosts are gigabit (public) + gigabit (private)
> - one client which is 10 gigabit
>
> The client mount a cephFS : /mnt/cephfs.
>

Could you share something about the client? Which distribution with=20
which kernel is it running?

And on which host is the MDS running?

> OK. working.
>
> Then, i ran this little script on the client :
>
>
> #!/bin/sh
> cd /mnt/cephfs
>
> function process {
>    for a in {0..9} {a..f}; do
> echo "Create disk $a ($1 G)";
> truncate -s $(($1*1024*1024*1024)) $a;
> echo "Format disk $a ($1 G)";
> mke2fs -jF $a;
>    done
> }
>

What's the idea behind this? You are creating images on which you are=20
formatting a ext filesystem?

> process 150
> process 340
> process 420
> process 840
> process 1680
>
>
> At the beginning, it works well. Then quickly, the Ceph cluster becom=
e
> instable. A lot of warning appears :
>
> 2013-01-14 07:20:47.276215 osd.8 [WRN] slow request 32.023561 seconds
> old, received at 2013-01-14 07:20:15.252598:
> osd_op(client.4119.1:72303 10000000019.00013cc0 [write 0~8192
> [1@-1],startsync 0~0] 0.1ddb4dfd RETRY snapc 1=3D[]) currently delaye=
d
>
>
> On the OSD itself, i have these messages :
>
> 2013-01-11 15:46:18.511465 7f9d8c4f5700  0 -- 172.17.243.40:6800/1601=
0
>>> 172.17.243.40:6818/16648 pipe(0x7f9d28001320 sd=3D31 :6800 pgs=3D10
> cs=3D1 l=3D0).fault with nothing to send, going to standby
> 2013-01-11 16:06:18.570870 7f9d8c6f7700  0 -- 172.17.243.40:6800/1601=
0
>>> 172.17.243.39:6805/13385 pipe(0x7f9d28000e10 sd=3D30 :6800 pgs=3D8 =
cs=3D1
> l=3D0).fault with nothing to send, going to standby
>
> then
>
> 2013-01-11 16:13:27.691045 7f9d6e1e1700  0 -- 172.17.243.40:6800/1601=
0
>>> 172.17.243.39:6807/13483 pipe(0x7f9d28003690 sd=3D60 :6800 pgs=3D0 =
cs=3D0
> l=3D0).accept connect_seq 2 vs existing 1 state standby
>
> then
>
> 2013-01-11 16:15:31.548441 7f9d78ff9700  0 --
> 172.17.243.140:6800/16010 submit_message osd_op_reply(15037
> 10000000009.00001c20 [write 8192~2097152] ondisk =3D 0) v4 remote,
> 172.17.243.180:0/232969487, failed lossy con, dropping message
> 0x7f9d70130d40
>
> At the end, the client mountpoint become unresponsive, and the only
> way is to force reboot.
>

You should keep in mind that CephFS is still in early stages. I hasn't=20
gotten the attention that RADOS and RBD got lately, but that should be=20
changing in 2013.

CephFS is still a moving target at this point. It's just not mature=20
enough compared to RBD.

Now, I'm not sure about what this could be, but if you provide the=20
information I asked for in the beginning of the e-mail a dev might be=20
able to give you a sane answer.


Wido
>
> Do you have any idea ?
> Thanks a lot,
>
> Alexis
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
