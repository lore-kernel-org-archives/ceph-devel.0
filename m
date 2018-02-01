From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: rbd + btrfs freezes
Date: Thu, 1 Feb 2018 14:25:45 +0100
Message-ID: <CAOi1vP_9SK9ae+S+O9GaQvF6wAhGf6Z5XnCdAkzi+Sz7+d6Ztg@mail.gmail.com>
References: <CAE63xUPO8SrDCGBrmRsJi-KE--PbKRxP1yPcuz0LfQCfcK9DLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33810 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbeBANZq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Feb 2018 08:25:46 -0500
Received: by mail-io0-f177.google.com with SMTP id c17so19149966iod.1
        for <ceph-devel@vger.kernel.org>; Thu, 01 Feb 2018 05:25:46 -0800 (PST)
In-Reply-To: <CAE63xUPO8SrDCGBrmRsJi-KE--PbKRxP1yPcuz0LfQCfcK9DLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ugis <ugis22@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Feb 1, 2018 at 12:26 PM, Ugis <ugis22@gmail.com> wrote:
> Hi,
> when btrfs on rbd is mounted it randomly freezes on reading and
> definitely freezes on writes with messages in dmesg as below.
>
>
> Ceph cluster side all osds 12.2.2
> #rbd feature disable pool/rbdX object-map fast-diff deep-flatten
> (other way kernel refuses to perform rbd map)
>
> #rbd info pool/rbdX
> rbd image 'rbdX':
>         size 102400 MB in 25600 objects
>         order 22 (4096 kB objects)
>         block_name_prefix: rbd_data.ce75cb2ae8944a
>         format: 2
>         features: layering, exclusive-lock
>         flags:
>         create_timestamp: Wed Jan 31 22:27:05 2018
>
>
> client side:
> #mkfs.btrfs -L some /dev/rbd0
> this detected rbd0 as SSD disk(which it is not) and performed trim

rbd advertises itself as non-rotational because it's a network block
device and the usual rotational optimizations don't help much.

All non-rotational devices are treated as SSDs by btrfs.

> copied ~30GB data into new btrfs filesystem
> reboot was done
>
> afterwards freezing of io in btrfs mount happened with the following in dmesg:
> # dmesg -T | tail -n 20
> [Thu Feb  1 13:01:00 2018] rbd: rbd0: client30307895 seems dead, breaking lock
> [Thu Feb  1 13:01:00 2018] rbd: rbd0: blacklist of client30307895 failed: -13
> [Thu Feb  1 13:01:00 2018] rbd: rbd0: failed to acquire lock: -13
> [Thu Feb  1 13:01:00 2018] rbd: rbd0: no lock owners detected
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: client30307895 seems dead, breaking lock
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: blacklist of client30307895 failed: -13
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: failed to acquire lock: -13
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: no lock owners detected
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: client30307895 seems dead, breaking lock
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: blacklist of client30307895 failed: -13
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: failed to acquire lock: -13
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: no lock owners detected
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: client30307895 seems dead, breaking lock
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: blacklist of client30307895 failed: -13
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: failed to acquire lock: -13
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: no lock owners detected
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: client30307895 seems dead, breaking lock
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: blacklist of client30307895 failed: -13
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: failed to acquire lock: -13
> [Thu Feb  1 13:01:01 2018] rbd: rbd0: no lock owners detected

That's -EACCES.  How are you mapping your images?  Are you mapping the
same image more than once?  Custom ceph user or ceph caps settings?

>
> # uname -a
> Linux name 4.15.0-041500-generic #201801282230 SMP Sun Jan 28 22:31:30
> UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
>
> # modinfo rbd
> filename:       /lib/modules/4.15.0-041500-generic/kernel/drivers/block/rbd.ko
> license:        GPL
> description:    RADOS Block Device (RBD) driver
> author:         Jeff Garzik <jeff@garzik.org>
> author:         Yehuda Sadeh <yehuda@hq.newdream.net>
> author:         Sage Weil <sage@newdream.net>
> author:         Alex Elder <elder@inktank.com>
> srcversion:     CF9C498AB3890D4BD4377D5
> depends:        libceph
> intree:         Y
> name:           rbd
> vermagic:       4.15.0-041500-generic SMP mod_unload
> parm:           single_major:Use a single major number for all rbd
> devices (default: true) (bool)
>
> Here is the full output for new btrfs formatting on rbd as I did not
> save first one:
> -------------------
> # mkfs.btrfs -L some /dev/rbd2
> btrfs-progs v4.4
> See http://btrfs.wiki.kernel.org for more information.
>
> Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if
> you want to force metadata duplication.
> Performing full device TRIM (5.00GiB) ...

Although mkfs-time trim isn't the issue here, you can skip it with
mkfs.btrfs -K.

Thanks,

                Ilya
