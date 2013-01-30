From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: cephx execute permissions for RBD operations
Date: Wed, 30 Jan 2013 13:20:03 -0800
Message-ID: <51098E83.5000402@inktank.com>
References: <5109486D.7040505@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35919 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496Ab3A3VUR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 16:20:17 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so1308298pad.3
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 13:20:16 -0800 (PST)
In-Reply-To: <5109486D.7040505@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/30/2013 08:21 AM, Wido den Hollander wrote:
> Hi,
>
> Yesterday I ran into a weird situation where my libvirt RBD pool
> just wouldn't work.
>
> Turned out the credentials I was using only had rw permissions for OSDs
> instead of rwx or *.
>
> This caused rbd_open to fail, looking at librbd itself I understand why
> execute permissions are required to do so (locks, watches).

It's actually not the watches, but the general metadata stored in the
header object (snapshots, locks, and for format 2 images everything
else).

> What is however the best way to detect if you don't have the required
> permissions?

rbd_open() should return -EPERM. From the cli, doing 'rbd info' will do
this and tell you. The one case where you need more permissions
(allow class-read object_prefix rbd_children) is when unprotecting a
snapshot, which will fail with -EPERM when it is attempted. That only
matters for format 2 images though.

> This piece of code:
> http://libvirt.org/git/?p=libvirt.git;a=blob;f=src/storage/storage_backend_rbd.c;h=8a0e517502c482f23f01bc63e95f1dc210d711cd;hb=master#l215
>
>
> I simply check if the open fails, but just "failed to open the RBD
> image" wasn't really that clear.
>
> I'd like to give a more useful error instead of that, but what error
> codes can I expect?

-EPERM for this case, others could be -EIO, -ENOSPC (since a watch is a
write), -ENOENT, -ENOSYS (trying to open an image that librbd or the
osds don't support), and possibly others I'm forgetting.

Josh

