From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [ceph-users] occasional failure to unmap rbd
Date: Mon, 23 Nov 2015 23:26:23 +0100
Message-ID: <CAOi1vP9h9CxHUOMWA6TJyuHb_TQti1Sow+g8aQg=v47EUJv4TA@mail.gmail.com>
References: <56057393.5040203@commerceguys.com>
	<CAOi1vP_mHfYjtT+-eKxbvxgpPtgYoc+388oKbzC1=L-mU-euAA@mail.gmail.com>
	<5605793C.8030403@commerceguys.com>
	<1C5AFAFE-8302-4D33-B9B7-5A097F86BA27@schermer.cz>
	<560587E0.2070905@commerceguys.com>
	<10495960.22183031.1443236081004.JavaMail.zimbra@redhat.com>
	<CAOi1vP-2xZ44yUVxO_5k5BykHJPGWzY9PusynChG9tAGGefcjg@mail.gmail.com>
	<160143584.22201489.1443263457606.JavaMail.zimbra@redhat.com>
	<CAJv+SGeTD5VxPdQ-3wrz0m0HFU7ZTZaKYMALavUQG4CRYTb4YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37643 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbbKWW0Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 17:26:24 -0500
Received: by wmww144 with SMTP id w144so2289998wmw.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 14:26:23 -0800 (PST)
In-Reply-To: <CAJv+SGeTD5VxPdQ-3wrz0m0HFU7ZTZaKYMALavUQG4CRYTb4YA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Markus Kienast <mark@trickkiste.at>
Cc: Shinobu Kinjo <skinjo@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 23, 2015 at 11:03 PM, Markus Kienast <mark@trickkiste.at> wrote:
> I am having the same issue here.

Which kernel are you running?  Could you attach your dmesg?

>
> root@paris3:/etc/neutron# rbd unmap /dev/rbd0
> rbd: failed to remove rbd device: (16) Device or resource busy
> rbd: remove failed: (16) Device or resource busy
>
> root@paris3:/etc/neutron# rbd info -p volumes
> volume-f3ab6892-f35e-4b98-8832-efbaaa2f4ca2
> 2015-11-23 22:42:06.842697 7f2d57e49700  0 -- :/2760503703 >>
> 10.90.90.4:6789/0 pipe(0x1773250 sd=3 :0 s=1 pgs=0 cs=0 l=1
> c=0x17734e0).fault
> rbd image 'volume-f3ab6892-f35e-4b98-8832-efbaaa2f4ca2':
> size 500 GB in 128000 objects
> order 22 (4096 kB objects)
> block_name_prefix: rbd_data.1b6d9e2aaa998b
> format: 2
> features: layering
> root@paris3:/etc/neutron# rados -p volumes listwatchers
> rbd_header.1b6d9e2aaa998b
> 2015-11-23 22:42:58.546723 7fec94fec700  0 -- :/2519796249 >>
> 10.90.90.4:6789/0 pipe(0x9cf260 sd=3 :0 s=1 pgs=0 cs=0 l=1 c=0x9cf4f0).fault

Did you root cause these faults?

> watcher=10.90.90.3:0/3293327848 client.8471177 cookie=1
>
> root@paris3:/etc/neutron# ps ax | grep rbd
>  7814 ?        S      0:00 [jbd2/rbd0-8]

Was there an ext filesystem involved?  How was it umounted - do you
have a "umount <mountpoint>" process stuck in D state?

> 11003 ?        S      0:00 [jbd2/rbd1-8]
> 14042 ?        S      0:00 [jbd2/rbd2p1-8]
> 24228 ?        S      0:00 [jbd2/rbd3-8]
>
> root@paris3:/etc/neutron# ceph --version
> ceph version 0.80.11 (8424145d49264624a3b0a204aedb127835161070)
>
> root@paris3:/etc/neutron# ls /sys/block/rbd0/holders/
> returns nothing
>
> root@paris3:/etc/neutron# fuser -amv /dev/rbd0
>                      USER        PID ACCESS COMMAND
> /dev/rbd0:

What's the output of "cat /sys/bus/rbd/devices/0/client_id"?

What's the output of "sudo cat /sys/kernel/debug/ceph/*/osdc"?

Thanks,

                Ilya
