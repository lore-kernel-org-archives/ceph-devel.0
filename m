From: =?UTF-8?B?5pSA5YiY?= <liupan1111@gmail.com>
Subject: Re: live migration
Date: Tue, 23 May 2017 09:58:55 +0800
Message-ID: <CAMwhyqXvuGsXAp6EuuKVhOaLNuncfqnxu_4nL9x2VQ4nOP9u5w@mail.gmail.com>
References: <CAMwhyqWvRUGD_9DoAPtWHSqendOjYcHWrK0+toeugFkhedZ_SQ@mail.gmail.com>
 <686db815-e82a-631a-6b66-c4932bdd0561@brockmann-consult.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36435 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965186AbdEWB64 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 May 2017 21:58:56 -0400
Received: by mail-vk0-f51.google.com with SMTP id p85so50401994vkd.3
        for <ceph-devel@vger.kernel.org>; Mon, 22 May 2017 18:58:56 -0700 (PDT)
In-Reply-To: <686db815-e82a-631a-6b66-c4932bdd0561@brockmann-consult.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Maloney <peter.maloney@brockmann-consult.de>
Cc: ceph-devel@vger.kernel.org

Hi Peter and All,

Thanks for reply.

But I am not using qemu-kvm, the use model is: there are many docker
containers built on top of nbds. Each nbd is mapped to an image by
using rbd-nbd map.

2017-05-22 19:54 GMT+08:00 Peter Maloney <peter.maloney@brockmann-consult.d=
e>:
> On 05/22/17 13:36, =E6=94=80=E5=88=98 wrote:
>> Hi All,
>>
>> I am working on live migration for some images(migrate images from one
>> pool of one cluster, to a new pool in "another" cluster).
>>
>> Do you have any experience or suggestion on how to do it?
> Proxmox VE can use the qemu feature "move_disk" to do this. If you are
> also using qemu-kvm, you could also do that from the qemu monitor. It
> lets you move a disk to another storage place (eg. from NFS to ceph
> librbd and back which I tested) without restarting the VM.
>
>>
>> Thanks
>> Pan
>> --
>
