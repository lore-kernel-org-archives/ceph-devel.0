From: Bill Hastings <bllhastings@gmail.com>
Subject: Re: Understanding Ceph
Date: Sun, 18 Dec 2011 08:43:27 -0800
Message-ID: <CAJMJAuMn94e3w=zh7ovn=+Poj6LzHbE45R8X7+jNiHrAVaer3A@mail.gmail.com>
References: <CAJMJAuPK8c4YBx3HUXOwOVfJAQuN2m2BHPNfyhr4hmpa0f1+Mw@mail.gmail.com>
	<CAO47_-_Ur4SzuuCA0m5n1++gFSXtapw=xTy1vE5Os-n1uGhdXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33670 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab1LRQn2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Dec 2011 11:43:28 -0500
Received: by vbbfc26 with SMTP id fc26so3520201vbb.19
        for <ceph-devel@vger.kernel.org>; Sun, 18 Dec 2011 08:43:27 -0800 (PST)
In-Reply-To: <CAO47_-_Ur4SzuuCA0m5n1++gFSXtapw=xTy1vE5Os-n1uGhdXg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

Thanks for the response. What if a write of 16 bytes was successful at
nodes A and B and failed at C, perhaps C had a momentarily unreachable
via the network? How is the Ceph client prevented from performing the
next read at C? Also what if the writes to OSD's were successful but
the metadata update fails? How is this managed if at all? How are
writes that straddle chunk boundaries handled from a transactional
perspective? I am just in the process of investigation so please
forgive me if the questions are very naive.


On Sun, Dec 18, 2011 at 4:17 AM, Christian Brunner <chb@muc.de> wrote:
> Hi Bill,
>
> 2011/12/18 Bill Hastings <bllhastings@gmail.com>:
>
>> I am trying to get my feet wet with Ceph and RADOS. My aim is to use
>> it as a block device for KVM instances. My understanding is that
>> virtual disks get striped at 1 MB boundaries by default. Does that
>> mean that there are going to be 1MB files on disks?
>
> Yes, the virtual disk is striped over multiple objects. By default
> they have a size of 4MB (not 1MB). Ceph is storing objects, but in the
> end they will be written as files on the different object stores.
>
>> Let's say I want
>> to update a particular vdisk with 16 bytes of data at offset 4096.
>> This would mean I want to update the first 1MB chunk.
>
> Yes, but you don't need to write the whole chunk again. You can update
> the 16 bytes withour rewriting everything. (In fact rbd is using
> sparse objects by default - "thin provisioning").
>
>
>> Let us assume I
>> have 3 way replication and the replicas are A, B and C. The write may
>> succeed at A and B and fail at C. Is there any state kept in the
>> metadata indicating at which replicas the write succeeded?
>
> Objects are grouped into placement groups (PGs).The ceph monitor is
> tracking the state of the PGs. With this information, the clients will
> be directed to the working replicas. When an object store is failing,
> it will start rebuilding the missing objects on other object stores.
>
> Regards,
> Christian
