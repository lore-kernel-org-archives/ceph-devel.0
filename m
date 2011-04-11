From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Fw: re-exporting nfs
Date: Mon, 11 Apr 2011 10:29:34 -0700
Message-ID: <7F19EF1A73CE4484873F71CBB2CFB16F@gmail.com>
References: <19ABB379BFC8469C8A53FD5B3E4BD875@PC201010310710>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52702 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab1DKR3i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 13:29:38 -0400
Received: by iyb14 with SMTP id 14so5814248iyb.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2011 10:29:38 -0700 (PDT)
In-Reply-To: <19ABB379BFC8469C8A53FD5B3E4BD875@PC201010310710>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuki <chengmao2010@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Saturday, April 9, 2011 at 11:45 PM, Yuki wrote:
Hi=EF=BC=8C
> I know ceph can re-export nfs protocol,but there are something confus=
e me during the test. Here is the command I used.
> "dd if=3D/dev/zeof of=3D/mnt/ceph/test.bat bs=3D4M count=3D1000"
> The results are as follows:
> ceph:62 MB/s
> nfs:26MB/s
> There are 3 OSDs,1 MON and 1 MDS in the ceph cluster. And I do this t=
est using the in-kernel client.
> I was confused by two things during the test on nfs.
> 1. The "dd" command will call mknod to create a file,but mknod will c=
reates a FIFO, character special file, or block special file with the s=
pecified name.(It will call lookup_open to create a file during the tes=
t on ceph,)

I'm not quite sure what you're asking here? We don't have anything to d=
o with maintaing dd so if you're asking about that program I really can=
't help you. ;)

> 2.There are sometimes no network traffic during the test on nfs.(I us=
e the command "sar" to monitor the local LAN network traffic )

I'm not personally very familiar with the nfs exporting, but my guess i=
s that maybe some of the writes are being buffered up on the export mac=
hine and then streamed out from there when it gets a commit from the NF=
S client.
In general it wouldn't surprise me if NFS re-export is a little slower =
than native Ceph since NFS routes everything through a single machine w=
hile Ceph talks directly to a lot of the servers. You might experiment =
with a few of the other dd settings (to adjust data sync, etc) and see =
how that changes your results.
-Greg




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
