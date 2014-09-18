From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: puzzled with the design pattern of ceph journal, really ruining
 performance
Date: Wed, 17 Sep 2014 20:23:28 -0500
Message-ID: <541A3410.6040504@redhat.com>
References: <5419A232.8080508@redhat.com> <ec560ceb-14b3-4706-aeaf-5622290561db@mailpro> <6F3FA899187F0043BA1827A69DA2F7CC020BD19A@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:44038 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbaIRBX0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 21:23:26 -0400
Received: by mail-ig0-f182.google.com with SMTP id hn15so411119igb.9
        for <ceph-devel@vger.kernel.org>; Wed, 17 Sep 2014 18:23:25 -0700 (PDT)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC020BD19A@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Alexandre DERUMIER <aderumier@odiso.com>, Mark Nelson <mark.nelson@inktank.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, ?? <zay11022@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/17/2014 08:05 PM, Chen, Xiaoxi wrote:
>> When benching the crucial m550, I only see time to time (maybe each =
30s,don't remember exactly), ios slowing doing to 200 for 1 or 2 second=
s then going up to normal speed around 4000iops
>
> Wow, that indicate m550 is busying with garbage collection , maybe ju=
st try to overprovision a bit (say if you have a 400G ssd , but only pa=
rtition ~300G), overprovision SSD generally both help performance and d=
urability. Actually if you look at the difference spec between Intel S3=
500 and S3700, the root cause is different over provision ratio :)

Hrm, I thought the S3700 uses MLC-HET cells while the S3500 uses regula=
r=20
MLC?

>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Alexandre DERUMIER
> Sent: Thursday, September 18, 2014 5:13 AM
> To: Mark Nelson
> Cc: Somnath Roy; ??; ceph-devel@vger.kernel.org; Chen, Xiaoxi
> Subject: Re: puzzled with the design pattern of ceph journal, really =
ruining performance
>
>>> FWIW, the journal will coalesce writes quickly when there are many
>>> concurrent 4k client writes.  Once you hit around 8 4k IOs per OSD,
>>> the journal will start coalescing.  For say 100-150 IOPs (what a
>>> spinning disk can handle), expect around 9ish 100KB journal writes
>>> (with padding and header/footer for each client IO).  What we've se=
en
>>> is that some drives that aren't that great at 4K O_DSYNC writes are
>>> still reasonably good with 8+ concurrent larger O_DSYNC writes.
>
> Yes, indeed, it's not that bad. (hopefully ;)
>
> When benching the crucial m550, I only see time to time (maybe each 3=
0s,don't remember exactly), ios slowing doing to 200 for 1 or 2 seconds=
 then going up to normal speed around 4000iops.
>
> with intel s3500, I have constant write at 5000iops.
>
>
> BTW, does rbd client cache also help for coalescing write (client sid=
e), then help also the journal ?
>
>
>
>
>
> ----- Mail original -----
>
> De: "Mark Nelson" <mark.nelson@inktank.com>
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>, "Xiaoxi Chen" <xi=
aoxi.chen@intel.com>
> Cc: "Somnath Roy" <Somnath.Roy@sandisk.com>, "??" <zay11022@gmail.com=
>, ceph-devel@vger.kernel.org
> Envoy=C3=A9: Mercredi 17 Septembre 2014 17:01:06
> Objet: Re: puzzled with the design pattern of ceph journal, really ru=
ining performance
>
> On 09/17/2014 09:20 AM, Alexandre DERUMIER wrote:
>>>> 2. Have you got any data to prove the O_DSYNC or fdatasync kill th=
e
>>>> performance of journal? In our previous test, the journal SSD (use=
 a
>>>> partition of a SSD as a journal for a particular OSD, and 4 OSD
>>>> share a >>same SSD) could reach its peak performance (300-400MB/s)
>>
>> Hi,
>>
>> I have done some bench here:
>>
>> http://www.mail-archive.com/ceph-users@lists.ceph.com/msg12950.html
>>
>> Some ssd models have really bad performance with O_DSYNC (crucial m5=
50 - 312 iops on 4k block).
>> Benching 1 osd,I can see big latencies for some seconds when O_DSYNC
>> occur
>
> FWIW, the journal will coalesce writes quickly when there are many co=
ncurrent 4k client writes. Once you hit around 8 4k IOs per OSD, the jo=
urnal will start coalescing. For say 100-150 IOPs (what a spinning disk=
 can handle), expect around 9ish 100KB journal writes (with padding and=
 header/footer for each client IO). What we've seen is that some drives=
 that aren't that great at 4K O_DSYNC writes are still reasonably good =
with 8+ concurrent larger O_DSYNC writes.
>
>>
>>
>>
>> crucial m550
>> ------------
>> #fio --filename=3D/dev/sdb --direct=3D1 --rw=3Dwrite --bs=3D4k --num=
jobs=3D2
>> --group_reporting --invalidate=3D0 --name=3Dab --sync=3D1 bw=3D1249.=
9KB/s,
>> iops=3D312
>>
>> intel s3500
>> -----------
>> fio --filename=3D/dev/sdb --direct=3D1 --rw=3Dwrite --bs=3D4k --numj=
obs=3D2
>> --group_reporting --invalidate=3D0 --name=3Dab --sync=3D1 #bw=3D4179=
4KB/s,
>> iops=3D10448
>>
>> ----- Mail original -----
>>
>> De: "Xiaoxi Chen" <xiaoxi.chen@intel.com>
>> =C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com>, "??" <zay11022@gmai=
l.com>,
>> ceph-devel@vger.kernel.org
>> Envoy=C3=A9: Mercredi 17 Septembre 2014 09:59:37
>> Objet: RE: puzzled with the design pattern of ceph journal, really
>> ruining performance
>>
>> Hi Nicheal,
>>
>> 1. The main purpose of journal is provide transaction semantics (pre=
vent partially update). Peer is not enough for this need because ceph w=
rites all replica at the same time, so when crush, you have no idea abo=
ut which replica has right data. For example, say if we have 2 replica,=
 user update a 4M object and the primary OSD crush when the first 2M wa=
s written , secondary OSD may also failed when the first 3MB was writte=
n. So both versions in primary/secondary are neither the new value, nor=
 the old value, and have no way to recover. So share the same idea as d=
atabase, we need to have a journal to support transaction and prevent t=
his happen. For some backend support transaction, BTRFS as an instance,=
 we don't need a journal, we can write the journal and data disk at the=
 same time, the journal here is just try to help performance, since it =
only do sequential write and we suspect it should be faster than backen=
d OSD.
>>
>> 2. Have you got any data to prove the O_DSYNC or fdatasync kill the
>> performance of journal? In our previous test, the journal SSD (use a
>> partition of a SSD as a journal for a particular OSD, and 4 OSD shar=
e
>> a same SSD) could reach its peak performance (300-400MB/s)
>>
>> Xiaoxi
>>
>>
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
>> Sent: Wednesday, September 17, 2014 3:30 PM
>> To: =E5=A7=9A=E5=AE=81; ceph-devel@vger.kernel.org
>> Subject: RE: puzzled with the design pattern of ceph journal, really
>> ruining performance
>>
>> Hi Nicheal,
>> Not only recovery , IMHO the main purpose of ceph journal is to supp=
ort transaction semantics since XFS doesn't have that. I guess it can't=
 be achieved with pg_log/pg_info.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger=
=2Ekernel.org] On Behalf Of ??
>> Sent: Tuesday, September 16, 2014 11:29 PM
>> To: ceph-devel@vger.kernel.org
>> Subject: puzzled with the design pattern of ceph journal, really
>> ruining performance
>>
>> Hi, guys
>>
>> I analyze the architecture of the ceph souce code.
>>
>> I know that, in order to keep journal atomic and consistent, the jou=
rnal write mode should be set with O_DSYNC or called fdatasync() system=
 call after every write operation. However, this kind of operation is r=
eally killing the performance as well as achieving high committing late=
ncy, even if SSD is used as journal disk. If the SSD has capacitor to k=
eep the data safe when the system crashes, we can set the mount option =
nobarrier or SSD itself will ignore the FLUSH REQUEST. So the performan=
ce would be better.
>>
>> So can it be instead by other strategies?
>> As far as I am concerned, I think the most important part is pg_log =
and pg_info. It will guides the crashed osd recovery its objects from t=
he peers. Therefore, if we can keep pg_log at a consistent point, we ca=
n recovery data without journal. So can we just use an "undo"
>> strategy on pg_log and neglect ceph journal? It will save lots of ba=
ndwidth, and also based on the consistent pg_log epoch, we can always r=
ecovery data from its peering osd, right? But this will lead to recover=
y more objects if the osd crash.
>>
>> Nicheal
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
