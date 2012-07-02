From: Gregory Farnum <greg@inktank.com>
Subject: Re: Rados faster than KVM block device?
Date: Mon, 2 Jul 2012 11:33:39 -0700
Message-ID: <CAPYLRzjd+zVZWCKfff1vA1Z4mCEHa-hCA5Ki85gE2g+8J_N3ew@mail.gmail.com>
References: <4FEC57BE.9060703@profihost.ag>
	<4FEC8252.90208@inktank.com>
	<4FECC9D5.9050202@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33600 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755752Ab2GBSdl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 14:33:41 -0400
Received: by lbbgm6 with SMTP id gm6so8005867lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 11:33:39 -0700 (PDT)
In-Reply-To: <4FECC9D5.9050202@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 28, 2012 at 2:17 PM, Stefan Priebe <s.priebe@profihost.ag> =
wrote:
> Am 28.06.2012 18:12, schrieb Josh Durgin:
>
>> On 06/28/2012 06:10 AM, Stefan Priebe - Profihost AG wrote:
>>>
>>> Hello list,
>>>
>>> my cluster is now pretty stable i'm just wondering about the sequen=
tial
>>> write values.
>>>
>>> With rados bench command and 16 threads i get totally different val=
ues
>>> than with KVM and rbd block device.
>>>
>>> rados -p kvmpool bench 60 write -t 16:
>>> pool size 2: Bandwidth (MB/sec): =A0 =A0 1137.294
>>> pool size 3: Bandwidth (MB/sec): =A0 =A0 846.983
>>>
>>> Inside KVM with fio:
>>>
>>> fio --filename=3D$DISK --direct=3D1 --rw=3Dwrite --bs=3D4M --size=3D=
200G
>>> --numjobs=3D16 --runtime=3D60 --group_reporting --name=3Dfile1:
>>
>>
>> There are a number of differences between running that in a vm on rb=
d
>> and rados bench.
>>
>> Keep in mind it's running on a filesystem, so requests go through th=
e
>> guest fs and block layer before getting into librbd.
>
> No it doesn't i'm testing directly the block device.
>
>
>> If you don't use direct I/O, and you enable rbd writeback caching,
>> librbd will be able to merge many of the smaller requests and
>> you should see much better throughput.
>
> I'm already using rbd writeback and it works good for random 4k write=
s, But
> it doesn't make sense for sequential 4M writes.

I haven't been able to come up with a good explanation for this, but
if you're interested in exploring it further, you can gather logging
data that includes the messages KVM is sending out to the OSDs (and do
the same for rados bench). Any differences we see there would be
instructive.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
