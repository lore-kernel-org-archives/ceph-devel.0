From: Peter Maloney <peter.maloney@brockmann-consult.de>
Subject: Re: live migration
Date: Mon, 22 May 2017 13:54:02 +0200
Message-ID: <686db815-e82a-631a-6b66-c4932bdd0561@brockmann-consult.de>
References: <CAMwhyqWvRUGD_9DoAPtWHSqendOjYcHWrK0+toeugFkhedZ_SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:51680 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757783AbdEVLyG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 May 2017 07:54:06 -0400
In-Reply-To: <CAMwhyqWvRUGD_9DoAPtWHSqendOjYcHWrK0+toeugFkhedZ_SQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5pSA5YiY?= <liupan1111@gmail.com>, ceph-devel@vger.kernel.org

On 05/22/17 13:36, 攀刘 wrote:
> Hi All,
>
> I am working on live migration for some images(migrate images from one
> pool of one cluster, to a new pool in "another" cluster).
>
> Do you have any experience or suggestion on how to do it?
Proxmox VE can use the qemu feature "move_disk" to do this. If you are
also using qemu-kvm, you could also do that from the qemu monitor. It
lets you move a disk to another storage place (eg. from NFS to ceph
librbd and back which I tested) without restarting the VM.

>
> Thanks
> Pan
> --

