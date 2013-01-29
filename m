From: femi anjorin <femi.anjorin@gmail.com>
Subject: Re: Ceph Production Environment Setup?
Date: Tue, 29 Jan 2013 17:44:40 +0100
Message-ID: <CAPhYxPw_B7xma8H76DyvXWLg1fE_-qgnMmNdrO4aM-MeVhUtYA@mail.gmail.com>
References: <CAPhYxPxYfsWfY96OvSfzG9mNMphAY8z5U-zYDp3Vw2nZ1yWNjg@mail.gmail.com>
	<CAD3n6hHo2Pt3ipxjCoSoxmtgpxLJv-48EjBo-wqXa5h9TTaH+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:60059 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab3A2Qol (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 11:44:41 -0500
Received: by mail-qa0-f43.google.com with SMTP id p6so1518950qad.16
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 08:44:40 -0800 (PST)
In-Reply-To: <CAD3n6hHo2Pt3ipxjCoSoxmtgpxLJv-48EjBo-wqXa5h9TTaH+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin B Nielsen <martin@unity3d.com>
Cc: ceph-devel@vger.kernel.org

Thanks.  I have upgraded all the systems to quad core processor
machine with 32 GB RAM although i still have 16 hard drives on each of
the storage nodes.

16 hard drives means i should have 16 OSD daemon but i dont know what
the OSD configuration should look like in ceph.conf.

I mounted the disk under the OSD data directory according to
http://ceph.com/docs/master/rados/deployment/mkcephfs/
the mount looks like this:
/dev/sda1 on /var/lib/ceph/osd/ceph-0
/dev/sdb1 on /var/lib/ceph/osd/ceph-1
/dev/sdc1 on /var/lib/ceph/osd/ceph-2
/dev/sdd1 on /var/lib/ceph/osd/ceph-3
/dev/sde1 on /var/lib/ceph/osd/ceph-4
/dev/sdf1 on /var/lib/ceph/osd/ceph-5
/dev/sdg1 on /var/lib/ceph/osd/ceph-6
/dev/sdh1 on /var/lib/ceph/osd/ceph-7
/dev/sdi1 on /var/lib/ceph/osd/ceph-8
/dev/sdj1 on /var/lib/ceph/osd/ceph-9
/dev/sdk1 on /var/lib/ceph/osd/ceph-10
/dev/sdl1 on /var/lib/ceph/osd/ceph-11
/dev/sdm1 on /var/lib/ceph/osd/ceph-12
/dev/sdn1 on /var/lib/ceph/osd/ceph-13
/dev/sdo1 on /var/lib/ceph/osd/ceph-14
/dev/sdp1 on /var/lib/ceph/osd/ceph-15

BUT I dont know how the OSD configuration should look like?  I see the
following in this ceph reference :
http://ceph.com/docs/master/rados/deployment/mkcephfs/

"For each [osd.n] section of your configuration file, specify the
storage device. For example:
[osd.1]
        devs = /dev/sda
[osd.2]
        devs = /dev/sdb "

I guess this is a configuration for one hard drive. What should the
OSD config be with 16 drives in one host?



Regards,
Femi.


On Tue, Jan 29, 2013 at 1:39 PM, Martin B Nielsen <martin@unity3d.com> wrote:
> There is also the hardware recommendation page in the ceph docs (
> http://ceph.com/docs/master/install/hardware-recommendations/ )
>
> Basically they recommend something like ~ 1GHz CPU (or 1 core/osd),
> 500M-1GB RAM pr OSD daemon. Also most run with 1 OSD daemon pr. disk
> (so if you put 16x disk pr. node you'll vastly overpower your atom
> cpu)
>
> Overall, while the cluster chugs along happily the hw specs are
> relatively modest; as soon as it starts to recover you'll see high
> cpu/mem usage.
>
> Cheers,
> Martin
>
>
> On Tue, Jan 29, 2013 at 3:56 AM, femi anjorin <femi.anjorin@gmail.com> wrote:
>>
>> Please can anyone  an advise  on how exactly a CEPH production
>> environment should look like? and what the configuration files should
>> be. My hardwares include the following:
>>
>> Server A, B, C configuration
>> CPU - Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz
>> RAM - 16GB
>> Hard drive -  500GB
>> SSD - 120GB
>>
>> Server D,E,F,G,H,J configuration
>> CPU - Intel(R) Atom(TM) CPU D525   @ 1.80GHz
>> RAM - 4 GB
>> Boot drive -  320gb
>> SSD - 120 GB
>> Storage drives - 16 X 2 TB
>>
>> I am thinking of these configurations but i am not sure.
>> Server A - MDS and MON
>> Server B - MON
>> Server C - MON
>> Server D, E,F,G,H,J - OSD
>>
>> Regards.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
