From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: puzzled with the design pattern of ceph journal, really ruining
 performance
Date: Wed, 17 Sep 2014 10:01:06 -0500
Message-ID: <5419A232.8080508@redhat.com>
References: <872acc52-387a-4ca1-bd43-a3825a2746cc@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:44611 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370AbaIQPBE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 11:01:04 -0400
Received: by mail-ie0-f179.google.com with SMTP id rl12so1904783iec.38
        for <ceph-devel@vger.kernel.org>; Wed, 17 Sep 2014 08:01:03 -0700 (PDT)
In-Reply-To: <872acc52-387a-4ca1-bd43-a3825a2746cc@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, Xiaoxi Chen <xiaoxi.chen@intel.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, ?? <zay11022@gmail.com>, ceph-devel@vger.kernel.org

On 09/17/2014 09:20 AM, Alexandre DERUMIER wrote:
>>> 2. Have you got any data to prove the O_DSYNC or fdatasync  kill th=
e performance of journal?   In our previous test, the journal SSD (use =
a partition of a SSD as a journal for a particular OSD, and 4 OSD share=
 a >>same SSD) could reach its peak performance (300-400MB/s)
>
> Hi,
>
> I have done some bench here:
>
> http://www.mail-archive.com/ceph-users@lists.ceph.com/msg12950.html
>
> Some ssd models have really bad performance with O_DSYNC (crucial m55=
0 - 312 iops on 4k block).
> Benching 1 osd,I can see big latencies for some seconds when O_DSYNC =
occur

=46WIW, the journal will coalesce writes quickly when there are many=20
concurrent 4k client writes.  Once you hit around 8 4k IOs per OSD, the=
=20
journal will start coalescing.  For say 100-150 IOPs (what a spinning=20
disk can handle), expect around 9ish 100KB journal writes (with padding=
=20
and header/footer for each client IO).  What we've seen is that some=20
drives that aren't that great at 4K O_DSYNC writes are still reasonably=
=20
good with 8+ concurrent larger O_DSYNC writes.

>
>
>
> crucial m550
> ------------
> #fio --filename=3D/dev/sdb --direct=3D1 --rw=3Dwrite --bs=3D4k --numj=
obs=3D2
> --group_reporting --invalidate=3D0 --name=3Dab --sync=3D1
> bw=3D1249.9KB/s, iops=3D312
>
> intel s3500
> -----------
> fio --filename=3D/dev/sdb --direct=3D1 --rw=3Dwrite --bs=3D4k --numjo=
bs=3D2
> --group_reporting --invalidate=3D0 --name=3Dab --sync=3D1
> #bw=3D41794KB/s, iops=3D10448
>
> ----- Mail original -----
>
> De: "Xiaoxi Chen" <xiaoxi.chen@intel.com>
> =C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com>, "??" <zay11022@gmail=
=2Ecom>, ceph-devel@vger.kernel.org
> Envoy=C3=A9: Mercredi 17 Septembre 2014 09:59:37
> Objet: RE: puzzled with the design pattern of ceph journal, really ru=
ining performance
>
> Hi Nicheal,
>
> 1. The main purpose of journal is provide transaction semantics (prev=
ent partially update). Peer is not enough for this need because ceph wr=
ites all replica at the same time, so when crush, you have no idea abou=
t which replica has right data. For example, say if we have 2 replica, =
user update a 4M object and the primary OSD crush when the first 2M was=
 written , secondary OSD may also failed when the first 3MB was written=
=2E So both versions in primary/secondary are neither the new value, no=
r the old value, and have no way to recover. So share the same idea as =
database, we need to have a journal to support transaction and prevent =
this happen. For some backend support transaction, BTRFS as an instance=
, we don't need a journal, we can write the journal and data disk at th=
e same time, the journal here is just try to help performance, since it=
 only do sequential write and we suspect it should be faster than backe=
nd OSD.
>
> 2. Have you got any data to prove the O_DSYNC or fdatasync kill the p=
erformance of journal? In our previous test, the journal SSD (use a par=
tition of a SSD as a journal for a particular OSD, and 4 OSD share a sa=
me SSD) could reach its peak performance (300-400MB/s)
>
> Xiaoxi
>
>
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Somnath Roy
> Sent: Wednesday, September 17, 2014 3:30 PM
> To: =E5=A7=9A=E5=AE=81; ceph-devel@vger.kernel.org
> Subject: RE: puzzled with the design pattern of ceph journal, really =
ruining performance
>
> Hi Nicheal,
> Not only recovery , IMHO the main purpose of ceph journal is to suppo=
rt transaction semantics since XFS doesn't have that. I guess it can't =
be achieved with pg_log/pg_info.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of ??
> Sent: Tuesday, September 16, 2014 11:29 PM
> To: ceph-devel@vger.kernel.org
> Subject: puzzled with the design pattern of ceph journal, really ruin=
ing performance
>
> Hi, guys
>
> I analyze the architecture of the ceph souce code.
>
> I know that, in order to keep journal atomic and consistent, the jour=
nal write mode should be set with O_DSYNC or called fdatasync() system =
call after every write operation. However, this kind of operation is re=
ally killing the performance as well as achieving high committing laten=
cy, even if SSD is used as journal disk. If the SSD has capacitor to ke=
ep the data safe when the system crashes, we can set the mount option n=
obarrier or SSD itself will ignore the FLUSH REQUEST. So the performanc=
e would be better.
>
> So can it be instead by other strategies?
> As far as I am concerned, I think the most important part is pg_log a=
nd pg_info. It will guides the crashed osd recovery its objects from th=
e peers. Therefore, if we can keep pg_log at a consistent point, we can=
 recovery data without journal. So can we just use an "undo"
> strategy on pg_log and neglect ceph journal? It will save lots of ban=
dwidth, and also based on the consistent pg_log epoch, we can always re=
covery data from its peering osd, right? But this will lead to recovery=
 more objects if the osd crash.
>
> Nicheal
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
