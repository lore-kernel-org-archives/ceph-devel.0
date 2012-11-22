From: ruslan usifov <ruslan.usifov@gmail.com>
Subject: Fwd: does still not recommended place rbd device on nodes, where osd
 daemon located?
Date: Thu, 22 Nov 2012 20:32:23 +0400
Message-ID: <CAHULbCmz-xmQrcfE6gzCO7Y61qkcz0fHosU-TXqUL1ALf0JhkQ@mail.gmail.com>
References: <CAHULbCmY6j3GbRFs_fyO1VP5_-BG5Cg1H_Kvfg1nN3jMMpyvHA@mail.gmail.com>
	<alpine.DEB.2.00.1211200849080.7369@cobra.newdream.net>
	<CAHULbC=Hk0ADhKB-GT-LCrHnzdGOyPTEJTxOp4=+bHVBdVQuCw@mail.gmail.com>
	<CAPYLRzg9DiKTY24w4DSY2t4ATk=VxNC0GHSM32_s9U7SAqi+yA@mail.gmail.com>
	<CAHULbCmMvBWq7xpZ1faTieROUpHSBBnNKcr6x3VC5sDkLodjrQ@mail.gmail.com>
	<50AD399A.2010203@inktank.com>
	<CAHULbC=crXP5=L3hXvmY9zFgF1KnR06-1opwbVvyiFHLykh5tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58809 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab2KVTU7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:20:59 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so6045325pbc.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 11:20:59 -0800 (PST)
In-Reply-To: <CAHULbC=crXP5=L3hXvmY9zFgF1KnR06-1opwbVvyiFHLykh5tg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello

Thank for your attention, and  sorry for my bad english!

In my draft architecture, i want use same hardware for osd and rbd
devices. In other words, i have 5 nodes this 5TB software raid on each
Disk space. I want build on this nodes, ceph cluster. All 5 nodes will
be run OSD and, on the same 5 node i will start 3 mons for QUORUM.
Also on the same 5 nodes i will start cluster stack (pacemaker +
corocync) with follow configuration

node ceph-precie-64-01
node ceph-precie-64-02
node ceph-precie-64-03
node ceph-precie-64-04
node ceph-precie-64-05
primitive samba_fs ocf:heartbeat:Filesystem \
        params device="-U cb4d3dda-92e9-4bd8-9fbc-
2940c096e8ec" directory="/mnt" fstype="ext4"
primitive samba_rbd ocf:ceph:rbd \
        params name="samba"
group samba samba_rbd samba_fs
property $id="cib-bootstrap-options" \
        dc-version="1.1.6-9971ebba4494012a93c03b40a2c58ec0eb60f50c" \
        cluster-infrastructure="openais" \
        expected-quorum-votes="3" \
        stonith-enabled="false" \
        no-quorum-policy="stop" \
        last-lrm-refresh="1352806660"


So rbd block device can be fault tolerant. In my case, use separate
machine for rbd not appropriated :-( (use multiple machines only for
rbd fault tollerant is too much cost )

2012/11/22 Dan Mick <dan.mick@inktank.com>:
> Still not certain I'm understanding *just* what you mean, but I'll point out
> that you can set up a cluster with rbd images, mount them from a separate
> non-virtualized host with kernel rbd, and expand those images and take
> advantage of the newly-available space on the separate host, just as though
> you were expanding a RAID device.  Maybe that fits your use case, Ruslan?
>
>
> On 11/21/2012 12:05 PM, ruslan usifov wrote:
>>
>> Yes i mean exactly this. it's a great pity :-( Maybe present some ceph
>> equivalent that solve my problem?
>>
>> 2012/11/21 Gregory Farnum <greg@inktank.com>:
>>>
>>> On Wed, Nov 21, 2012 at 4:33 AM, ruslan usifov <ruslan.usifov@gmail.com>
>>> wrote:
>>>>
>>>> So, not possible use ceph as scalable block device without
>>>> visualization?
>>>
>>>
>>> I'm not sure I understand, but if you're trying to take a bunch of
>>> compute nodes and glue their disks together, no, that's not a
>>> supported use case at this time. There are a number of deadlock issues
>>> caused by this sort of loopback; it's the same reason you shouldn't
>>> mount NFS on the server host.
>>> We may in the future manage to release an rbd-fuse client that you can
>>> use to do this with a little less pain, but it's not ready at this
>>> point.
>>> -Greg
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
