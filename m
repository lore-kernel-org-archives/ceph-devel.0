From: Gregory Farnum <greg@inktank.com>
Subject: Re:
Date: Thu, 25 Oct 2012 05:15:06 -0700
Message-ID: <1A4C855A8DD647B0B2E8790CA2945D00@inktank.com>
References: <CAB6Jr7RbMaxQpxV0_pUTwSwf51wuavmJ_Dnzdk4OVMZiHcMZKQ@mail.gmail.com>
 <50868471.1070105@widodh.nl>
 <CAB6Jr7QbWZ7Xe+VZrPwC7rWcZ7_F6kLm=A+zq1NEAmcGvgky-A@mail.gmail.com>
 <162E8EA1E858481C9CD55412C597577E@inktank.com>
 <CAB6Jr7SbbAE=yEVgg+UupTmavKfvFvGj8j7C9M0Ya2FocNmw9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42769 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050Ab2JYMPK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 08:15:10 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1967463pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Oct 2012 05:15:09 -0700 (PDT)
In-Reply-To: <CAB6Jr7SbbAE=yEVgg+UupTmavKfvFvGj8j7C9M0Ya2FocNmw9w@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jie sun <0maidou0@gmail.com>
Cc: ceph-devel@vger.kernel.org

Sorry, I was unclear =E2=80=94 I meant I think[1] it was fixed in our l=
inux branch, for future kernel releases. The messages you're seeing are=
 just logging a perfectly normal event that's part of the Ceph protocol=
=2E =20
-Greg
[1]: I'd have to check to make sure. Sage, Alex, am I remembering that =
correctly?


On Wednesday, October 24, 2012 at 11:45 PM, jie sun wrote:

> What is the version of the master branch ? I use the stable version 0=
=2E48.2
> Thank you!
> -SunJie
> =20
> 2012/10/24 Gregory Farnum <greg@inktank.com>:
> > On Tuesday, October 23, 2012 at 10:48 PM, jie sun wrote:
> > > My vm kernel version is "Linux ubuntu12 3.2.0-23-generic".
> > > =20
> > > "ceph-s" shows
> > > " health HEALTH_OK
> > > monmap e1: 1 mons at {a=3D10.100.211.146:6789/0}, election epoch =
0, quorum 0 a
> > > osdmap e152: 10 osds: 9 up, 9 in
> > > pgmap v48479: 2112 pgs: 2112 active+clean; 23161 MB data, 46323 M=
B
> > > used, 2451 GB / 2514 GB avail
> > > mdsmap e31: 1/1/1 up {0=3Da=3Dup:active} "
> > > =20
> > > In my vm, I do operations like:
> > > I install 4 debs on my vm, such as libnss3, libnspr4, librados2,
> > > librbd1. And then execute "modprobe rbd" so that I can map a imag=
e to
> > > my vm.
> > > Then "rbd create foo --size 10240 -m $monIP(my ceph mon IP)",
> > > "rbd map foo -m $monIP" ------ Here a device /dev/rbd0 can be
> > > used as a local device
> > > "mkfs -t ext4 /dev/rbd0"
> > > "mount /dev/rbd0 /mnt(or some other directory)"
> > > After the operations above, I can use this device. But it oftern
> > > prompt some log like "libceph: osd9 10.100.211.68:6809 socket clo=
sed".
> > > I just want to mount a device to my vm, so I didn't install a cep=
h
> > > client. Is this proper to do so?
> > =20
> > =20
> > =20
> > You might consider using the native QEMU/libvirt instead; it offers=
 some more advanced options. But if you're happy with it, this certainl=
y works!
> > =20
> > The "socket closed" messages are just noise; it's nothing to be con=
cerned about (you'll notice they're happening every 15 minutes for each=
 OSD; probably you aren't doing any disk accesses). I think these warni=
ngs actually got removed from our master branch a few days ago.
> > -Greg
> =20



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
