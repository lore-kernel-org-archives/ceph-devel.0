From: Markus Kienast <elias1884@gmail.com>
Subject: Re: [ceph-users] occasional failure to unmap rbd
Date: Mon, 23 Nov 2015 23:06:38 +0100
Message-ID: <CAJv+SGctTDHVd6205USv1kPdxXZXJJLjQkzLSL4q4EvKCyOBwQ@mail.gmail.com>
References: <56057393.5040203@commerceguys.com>
	<CAOi1vP_mHfYjtT+-eKxbvxgpPtgYoc+388oKbzC1=L-mU-euAA@mail.gmail.com>
	<5605793C.8030403@commerceguys.com>
	<1C5AFAFE-8302-4D33-B9B7-5A097F86BA27@schermer.cz>
	<560587E0.2070905@commerceguys.com>
	<10495960.22183031.1443236081004.JavaMail.zimbra@redhat.com>
	<CAOi1vP-2xZ44yUVxO_5k5BykHJPGWzY9PusynChG9tAGGefcjg@mail.gmail.com>
	<160143584.22201489.1443263457606.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35030 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbbKWWGk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 17:06:40 -0500
Received: by lfdl133 with SMTP id l133so40294307lfd.2
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 14:06:38 -0800 (PST)
In-Reply-To: <160143584.22201489.1443263457606.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I am having the same issue here.

root@paris3:/etc/neutron# rbd unmap /dev/rbd0
rbd: failed to remove rbd device: (16) Device or resource busy
rbd: remove failed: (16) Device or resource busy

root@paris3:/etc/neutron# rbd info -p volumes
volume-f3ab6892-f35e-4b98-8832-efbaaa2f4ca2
2015-11-23 22:42:06.842697 7f2d57e49700  0 -- :/2760503703 >>
10.90.90.4:6789/0 pipe(0x1773250 sd=3 :0 s=1 pgs=0 cs=0 l=1
c=0x17734e0).fault
rbd image 'volume-f3ab6892-f35e-4b98-8832-efbaaa2f4ca2':
size 500 GB in 128000 objects
order 22 (4096 kB objects)
block_name_prefix: rbd_data.1b6d9e2aaa998b
format: 2
features: layering
root@paris3:/etc/neutron# rados -p volumes listwatchers
rbd_header.1b6d9e2aaa998b
2015-11-23 22:42:58.546723 7fec94fec700  0 -- :/2519796249 >>
10.90.90.4:6789/0 pipe(0x9cf260 sd=3 :0 s=1 pgs=0 cs=0 l=1
c=0x9cf4f0).fault
watcher=10.90.90.3:0/3293327848 client.8471177 cookie=1

root@paris3:/etc/neutron# ps ax | grep rbd
 7814 ?        S      0:00 [jbd2/rbd0-8]
11003 ?        S      0:00 [jbd2/rbd1-8]
14042 ?        S      0:00 [jbd2/rbd2p1-8]
24228 ?        S      0:00 [jbd2/rbd3-8]

root@paris3:/etc/neutron# ceph --version
ceph version 0.80.11 (8424145d49264624a3b0a204aedb127835161070)

root@paris3:/etc/neutron# ls /sys/block/rbd0/holders/
returns nothing

root@paris3:/etc/neutron# fuser -amv /dev/rbd0
                     USER        PID ACCESS COMMAND
/dev/rbd0:

root@paris3:/etc/neutron# lsof /dev/rbd0
returns nothing

Please advise,
Markus

On Sat, Sep 26, 2015 at 12:30 PM, Shinobu Kinjo <skinjo@redhat.com> wrote:
>
> Thanks!
> I completely overlooked that -;
>
>  Shinobu
>
> ----- Original Message -----
> From: "Ilya Dryomov" <idryomov@gmail.com>
> To: "Shinobu Kinjo" <skinjo@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Saturday, September 26, 2015 5:52:50 PM
> Subject: Re: [CEPH-DEVEL] [ceph-users] occasional failure to unmap rbd
>
> On Sat, Sep 26, 2015 at 5:54 AM, Shinobu Kinjo <skinjo@redhat.com> wrote:
> > I think it's more helpful to put returned value in:
> >
> > # ./src/krbd.cc
> > 530       cerr << "rbd: sysfs write failed" << std::endl;
> >
> > like:
> >
> > 530       cerr << "rbd: sysfs write failed (" << r << ")" << std::endl;
> >
> > So that we exactly know what **write** complains about.
> > Because **write** has some return values in case of error.
> >
> > What do you think?
>
> It's already doing that:
>
> rbd: sysfs write failed
> rbd: unmap failed: (16) Device or resource busy
>
> sysfs_write_rbd_remove() return value is propagated up and reported.
> The code is written in such a way that return values are preserved and
> never overwritten (hopefully!).
>
> Thanks,
>
>                 Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
