From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [RBD][OpenStack]The way to solve problem when boot VM and root
 disk size is specified
Date: Tue, 12 Nov 2013 18:58:16 -0800
Message-ID: <5282EAC8.90902@inktank.com>
References: <E7DD39A7-418B-4C08-98A2-8CB27AD18711@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52771 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544Ab3KMC70 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Nov 2013 21:59:26 -0500
Received: by mail-pa0-f49.google.com with SMTP id lf10so2746287pab.8
        for <ceph-devel@vger.kernel.org>; Tue, 12 Nov 2013 18:59:25 -0800 (PST)
In-Reply-To: <E7DD39A7-418B-4C08-98A2-8CB27AD18711@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>, ceph-devel@vger.kernel.org

On 11/11/2013 11:10 PM, Haomai Wang wrote:
> Hi all,
>
> Now OpenStack Nova master branch still exists a bug when you boot a VM which root disk size is specified. The storage backend of Nova also is rbd. For example, you boot a VM and specify 10G as root disk size. But the image is only 1G. Then VM will be spawned and the root disk size will expands to 10G. The filesystem still is 1G.
>
> Now I have a way to solve it. When we boot a VM and resize root disk size, we use "fuse-rbd" command to resize filesystem.
>
> fuse-rbd -p pool -c /etc/ceph/ceph.conf /tmp-ceph-rbd
> cd /tmp-ceph-rbd
> resize2fs volume-xxxxxxxxxxx
>
> It seemed to work but I want to know whether exists problems when many volumes in a pool. I'm not sure that too many volumes cause performance problem.

fuse-rbd has a 128 image limit at the moment. It's more of a prototype
than something I'd recommend relying on.

Interacting with an untrusted filesystem on a compute host is also a
bit worrying from a security perspective. If you really need to resize
the fs and can't use cloud-init, using libguestfs would be best. This
isolates the operations into a vm, so the host kernel isn't interacting
with untrusted filesystems.

Josh
