From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: rbd + btrfs freezes
Date: Thu, 1 Feb 2018 08:41:07 -0500
Message-ID: <CA+aFP1AqiNSmA=v+PaRLEA3DxdoGjyYDeVQ7pgqWg+guCc0Sag@mail.gmail.com>
References: <CAE63xUPO8SrDCGBrmRsJi-KE--PbKRxP1yPcuz0LfQCfcK9DLQ@mail.gmail.com>
 <CAOi1vP_9SK9ae+S+O9GaQvF6wAhGf6Z5XnCdAkzi+Sz7+d6Ztg@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35506 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeBANlJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Feb 2018 08:41:09 -0500
Received: by mail-yw0-f179.google.com with SMTP id u21so10412904ywc.2
        for <ceph-devel@vger.kernel.org>; Thu, 01 Feb 2018 05:41:09 -0800 (PST)
In-Reply-To: <CAOi1vP_9SK9ae+S+O9GaQvF6wAhGf6Z5XnCdAkzi+Sz7+d6Ztg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ugis <ugis22@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>

... also, presuming your OSDs are at the Luminous release, please
verify that you performed step 6 in the upgrade guide [1]. You can
also just use "mon 'profile rbd' osd 'profile rbd'" [2] to ensure you
have the correct permissions (again, assuming you have Luminous OSDs).

[1] http://docs.ceph.com/docs/master/release-notes/#upgrade-from-jewel-or-kraken
[2] http://docs.ceph.com/docs/master/rados/operations/user-management/#authorization-capabilities

On Thu, Feb 1, 2018 at 8:25 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Thu, Feb 1, 2018 at 12:26 PM, Ugis <ugis22@gmail.com> wrote:
>> Hi,
>> when btrfs on rbd is mounted it randomly freezes on reading and
>> definitely freezes on writes with messages in dmesg as below.
>>
>>
>> Ceph cluster side all osds 12.2.2
>> #rbd feature disable pool/rbdX object-map fast-diff deep-flatten
>> (other way kernel refuses to perform rbd map)
>>
>> #rbd info pool/rbdX
>> rbd image 'rbdX':
>>         size 102400 MB in 25600 objects
>>         order 22 (4096 kB objects)
>>         block_name_prefix: rbd_data.ce75cb2ae8944a
>>         format: 2
>>         features: layering, exclusive-lock
>>         flags:
>>         create_timestamp: Wed Jan 31 22:27:05 2018
>>
>>
>> client side:
>> #mkfs.btrfs -L some /dev/rbd0
>> this detected rbd0 as SSD disk(which it is not) and performed trim
>
> rbd advertises itself as non-rotational because it's a network block
> device and the usual rotational optimizations don't help much.
>
> All non-rotational devices are treated as SSDs by btrfs.
>
>> copied ~30GB data into new btrfs filesystem
>> reboot was done
>>
>> afterwards freezing of io in btrfs mount happened with the following in dmesg:
>> # dmesg -T | tail -n 20
>> [Thu Feb  1 13:01:00 2018] rbd: rbd0: client30307895 seems dead, breaking lock
>> [Thu Feb  1 13:01:00 2018] rbd: rbd0: blacklist of client30307895 failed: -13
>> [Thu Feb  1 13:01:00 2018] rbd: rbd0: failed to acquire lock: -13
>> [Thu Feb  1 13:01:00 2018] rbd: rbd0: no lock owners detected
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: client30307895 seems dead, breaking lock
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: blacklist of client30307895 failed: -13
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: failed to acquire lock: -13
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: no lock owners detected
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: client30307895 seems dead, breaking lock
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: blacklist of client30307895 failed: -13
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: failed to acquire lock: -13
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: no lock owners detected
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: client30307895 seems dead, breaking lock
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: blacklist of client30307895 failed: -13
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: failed to acquire lock: -13
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: no lock owners detected
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: client30307895 seems dead, breaking lock
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: blacklist of client30307895 failed: -13
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: failed to acquire lock: -13
>> [Thu Feb  1 13:01:01 2018] rbd: rbd0: no lock owners detected
>
> That's -EACCES.  How are you mapping your images?  Are you mapping the
> same image more than once?  Custom ceph user or ceph caps settings?
>
>>
>> # uname -a
>> Linux name 4.15.0-041500-generic #201801282230 SMP Sun Jan 28 22:31:30
>> UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
>>
>> # modinfo rbd
>> filename:       /lib/modules/4.15.0-041500-generic/kernel/drivers/block/rbd.ko
>> license:        GPL
>> description:    RADOS Block Device (RBD) driver
>> author:         Jeff Garzik <jeff@garzik.org>
>> author:         Yehuda Sadeh <yehuda@hq.newdream.net>
>> author:         Sage Weil <sage@newdream.net>
>> author:         Alex Elder <elder@inktank.com>
>> srcversion:     CF9C498AB3890D4BD4377D5
>> depends:        libceph
>> intree:         Y
>> name:           rbd
>> vermagic:       4.15.0-041500-generic SMP mod_unload
>> parm:           single_major:Use a single major number for all rbd
>> devices (default: true) (bool)
>>
>> Here is the full output for new btrfs formatting on rbd as I did not
>> save first one:
>> -------------------
>> # mkfs.btrfs -L some /dev/rbd2
>> btrfs-progs v4.4
>> See http://btrfs.wiki.kernel.org for more information.
>>
>> Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if
>> you want to force metadata duplication.
>> Performing full device TRIM (5.00GiB) ...
>
> Although mkfs-time trim isn't the issue here, you can skip it with
> mkfs.btrfs -K.
>
> Thanks,
>
>                 Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
