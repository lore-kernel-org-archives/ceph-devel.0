From: Markus Kienast <elias1884@gmail.com>
Subject: Re: [ceph-users] occasional failure to unmap rbd
Date: Tue, 24 Nov 2015 00:12:32 +0100
Message-ID: <CAJv+SGdGBvwt5Mgk-qmh74azHub8B-xOY_ecJckcMRhrLyFT3Q@mail.gmail.com>
References: <56057393.5040203@commerceguys.com>
	<CAOi1vP_mHfYjtT+-eKxbvxgpPtgYoc+388oKbzC1=L-mU-euAA@mail.gmail.com>
	<5605793C.8030403@commerceguys.com>
	<1C5AFAFE-8302-4D33-B9B7-5A097F86BA27@schermer.cz>
	<560587E0.2070905@commerceguys.com>
	<10495960.22183031.1443236081004.JavaMail.zimbra@redhat.com>
	<CAOi1vP-2xZ44yUVxO_5k5BykHJPGWzY9PusynChG9tAGGefcjg@mail.gmail.com>
	<160143584.22201489.1443263457606.JavaMail.zimbra@redhat.com>
	<CAJv+SGeTD5VxPdQ-3wrz0m0HFU7ZTZaKYMALavUQG4CRYTb4YA@mail.gmail.com>
	<CAOi1vP9h9CxHUOMWA6TJyuHb_TQti1Sow+g8aQg=v47EUJv4TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36661 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbbKWXMe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 18:12:34 -0500
Received: by lfs39 with SMTP id 39so123020444lfs.3
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 15:12:32 -0800 (PST)
In-Reply-To: <CAOi1vP9h9CxHUOMWA6TJyuHb_TQti1Sow+g8aQg=v47EUJv4TA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Kernel Version
elias@paris3:~$ uname -a
Linux paris3.sfe.tv 3.16.0-28-generic #38-Ubuntu SMP Sat Dec 13
16:13:28 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Output of dmesg and /var/log/dmesg attached.
But does not show much except for one mon being down.
The mon is down for hardware reasons.



On Mon, Nov 23, 2015 at 11:26 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Mon, Nov 23, 2015 at 11:03 PM, Markus Kienast <mark@trickkiste.at> wrote:
> > I am having the same issue here.
>
> Which kernel are you running?  Could you attach your dmesg?
>
> >
> > root@paris3:/etc/neutron# rbd unmap /dev/rbd0
> > rbd: failed to remove rbd device: (16) Device or resource busy
> > rbd: remove failed: (16) Device or resource busy
> >
> > root@paris3:/etc/neutron# rbd info -p volumes
> > volume-f3ab6892-f35e-4b98-8832-efbaaa2f4ca2
> > 2015-11-23 22:42:06.842697 7f2d57e49700  0 -- :/2760503703 >>
> > 10.90.90.4:6789/0 pipe(0x1773250 sd=3 :0 s=1 pgs=0 cs=0 l=1
> > c=0x17734e0).fault
> > rbd image 'volume-f3ab6892-f35e-4b98-8832-efbaaa2f4ca2':
> > size 500 GB in 128000 objects
> > order 22 (4096 kB objects)
> > block_name_prefix: rbd_data.1b6d9e2aaa998b
> > format: 2
> > features: layering
> > root@paris3:/etc/neutron# rados -p volumes listwatchers
> > rbd_header.1b6d9e2aaa998b
> > 2015-11-23 22:42:58.546723 7fec94fec700  0 -- :/2519796249 >>
> > 10.90.90.4:6789/0 pipe(0x9cf260 sd=3 :0 s=1 pgs=0 cs=0 l=1 c=0x9cf4f0).fault
>
> Did you root cause these faults?

Hardware failure caused these faults.

>
> > watcher=10.90.90.3:0/3293327848 client.8471177 cookie=1
> >
> > root@paris3:/etc/neutron# ps ax | grep rbd
> >  7814 ?        S      0:00 [jbd2/rbd0-8]
>
> Was there an ext filesystem involved?  How was it umounted - do you
> have a "umount <mountpoint>" process stuck in D state?

Yes, all these RBDs are formatted with ext4. I am regularly using them
with openstack and have never had any problems.
I did "unmount <mountpoint>" and the unmount process did actually
finish just fine.
Where can I look up, if it is stuck in "D" state?

>
> > 11003 ?        S      0:00 [jbd2/rbd1-8]
> > 14042 ?        S      0:00 [jbd2/rbd2p1-8]
> > 24228 ?        S      0:00 [jbd2/rbd3-8]
> >
> > root@paris3:/etc/neutron# ceph --version
> > ceph version 0.80.11 (8424145d49264624a3b0a204aedb127835161070)
> >
> > root@paris3:/etc/neutron# ls /sys/block/rbd0/holders/
> > returns nothing
> >
> > root@paris3:/etc/neutron# fuser -amv /dev/rbd0
> >                      USER        PID ACCESS COMMAND
> > /dev/rbd0:
>
> What's the output of "cat /sys/bus/rbd/devices/0/client_id"?

root@paris3:~# cat /sys/bus/rbd/devices/0/client_id
client8471177

>
> What's the output of "sudo cat /sys/kernel/debug/ceph/*/osdc"?

root@paris3:~# ls -l /sys/kernel/debug/ceph/
total 0
drwxr-xr-x 2 root root 0 Feb  4  2015
32ba3117-e320-49fc-aabd-f100d5a7e94b.client7663711
drwxr-xr-x 2 root root 0 Nov 23 11:41
32ba3117-e320-49fc-aabd-f100d5a7e94b.client8471177

root@paris3:~# cat
/sys/kernel/debug/ceph/32ba3117-e320-49fc-aabd-f100d5a7e94b.client8471177/osdc
has no output

root@paris3:~# cat
/sys/kernel/debug/ceph/32ba3117-e320-49fc-aabd-f100d5a7e94b.client7663711/osdc
hangs with no output

BTW, I have mapped these RBDs as user cinder not as admin.

But using -n produces the same error:
root@paris3:~# rbd -n client.cinder  unmap /dev/rbd0
rbd: failed to remove rbd device: (16) Device or resource busy
rbd: remove failed: (16) Device or resource busy

I appreciate your help!
Markus

>
> Thanks,
>
>                 Ilya
