From: jie sun <0maidou0@gmail.com>
Subject: Re:
Date: Fri, 26 Oct 2012 11:08:44 +0800
Message-ID: <CAB6Jr7R+NXdtAwWHeWMvhyG-r8Qy2qeEyW482vctzVna-NHgqA@mail.gmail.com>
References: <CAB6Jr7RbMaxQpxV0_pUTwSwf51wuavmJ_Dnzdk4OVMZiHcMZKQ@mail.gmail.com>
	<50868471.1070105@widodh.nl>
	<CAB6Jr7QbWZ7Xe+VZrPwC7rWcZ7_F6kLm=A+zq1NEAmcGvgky-A@mail.gmail.com>
	<162E8EA1E858481C9CD55412C597577E@inktank.com>
	<CAB6Jr7SbbAE=yEVgg+UupTmavKfvFvGj8j7C9M0Ya2FocNmw9w@mail.gmail.com>
	<1A4C855A8DD647B0B2E8790CA2945D00@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43760 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755736Ab2JZDIo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 23:08:44 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3202879iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Oct 2012 20:08:44 -0700 (PDT)
In-Reply-To: <1A4C855A8DD647B0B2E8790CA2945D00@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I understood.Thank you.
-SunJie

2012/10/25 Gregory Farnum <greg@inktank.com>:
> Sorry, I was unclear =97 I meant I think[1] it was fixed in our linux=
 branch, for future kernel releases. The messages you're seeing are jus=
t logging a perfectly normal event that's part of the Ceph protocol.
> -Greg
> [1]: I'd have to check to make sure. Sage, Alex, am I remembering tha=
t correctly?
>
>
> On Wednesday, October 24, 2012 at 11:45 PM, jie sun wrote:
>
>> What is the version of the master branch ? I use the stable version =
0.48.2
>> Thank you!
>> -SunJie
>>
>> 2012/10/24 Gregory Farnum <greg@inktank.com>:
>> > On Tuesday, October 23, 2012 at 10:48 PM, jie sun wrote:
>> > > My vm kernel version is "Linux ubuntu12 3.2.0-23-generic".
>> > >
>> > > "ceph-s" shows
>> > > " health HEALTH_OK
>> > > monmap e1: 1 mons at {a=3D10.100.211.146:6789/0}, election epoch=
 0, quorum 0 a
>> > > osdmap e152: 10 osds: 9 up, 9 in
>> > > pgmap v48479: 2112 pgs: 2112 active+clean; 23161 MB data, 46323 =
MB
>> > > used, 2451 GB / 2514 GB avail
>> > > mdsmap e31: 1/1/1 up {0=3Da=3Dup:active} "
>> > >
>> > > In my vm, I do operations like:
>> > > I install 4 debs on my vm, such as libnss3, libnspr4, librados2,
>> > > librbd1. And then execute "modprobe rbd" so that I can map a ima=
ge to
>> > > my vm.
>> > > Then "rbd create foo --size 10240 -m $monIP(my ceph mon IP)",
>> > > "rbd map foo -m $monIP" ------ Here a device /dev/rbd0 can be
>> > > used as a local device
>> > > "mkfs -t ext4 /dev/rbd0"
>> > > "mount /dev/rbd0 /mnt(or some other directory)"
>> > > After the operations above, I can use this device. But it oftern
>> > > prompt some log like "libceph: osd9 10.100.211.68:6809 socket cl=
osed".
>> > > I just want to mount a device to my vm, so I didn't install a ce=
ph
>> > > client. Is this proper to do so?
>> >
>> >
>> >
>> > You might consider using the native QEMU/libvirt instead; it offer=
s some more advanced options. But if you're happy with it, this certain=
ly works!
>> >
>> > The "socket closed" messages are just noise; it's nothing to be co=
ncerned about (you'll notice they're happening every 15 minutes for eac=
h OSD; probably you aren't doing any disk accesses). I think these warn=
ings actually got removed from our master branch a few days ago.
>> > -Greg
>>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
