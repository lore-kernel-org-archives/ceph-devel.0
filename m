From: Sage Weil <sage@inktank.com>
Subject: Re:
Date: Thu, 25 Oct 2012 08:38:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210250838070.25762@cobra.newdream.net>
References: <CAB6Jr7RbMaxQpxV0_pUTwSwf51wuavmJ_Dnzdk4OVMZiHcMZKQ@mail.gmail.com> <50868471.1070105@widodh.nl> <CAB6Jr7QbWZ7Xe+VZrPwC7rWcZ7_F6kLm=A+zq1NEAmcGvgky-A@mail.gmail.com> <162E8EA1E858481C9CD55412C597577E@inktank.com>
 <CAB6Jr7SbbAE=yEVgg+UupTmavKfvFvGj8j7C9M0Ya2FocNmw9w@mail.gmail.com> <1A4C855A8DD647B0B2E8790CA2945D00@inktank.com> <50894E81.30403@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59232 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759746Ab2JYPiw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 11:38:52 -0400
In-Reply-To: <50894E81.30403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, jie sun <0maidou0@gmail.com>, ceph-devel@vger.kernel.org

On Thu, 25 Oct 2012, Alex Elder wrote:
> On 10/25/2012 07:15 AM, Gregory Farnum wrote:
> > Sorry, I was unclear ? I meant I think[1] it was fixed in our linux
> > branch, for future kernel releases. The messages you're seeing are
> > just logging a perfectly normal event that's part of the Ceph
> > protocol. -Greg [1]: I'd have to check to make sure. Sage, Alex, am I
> > remembering that correctly?
> 
> I see those too.  I think the socket (the other end?) closes after
> a period of inactivity, but it does re-open and reconnect again
> whenever necessary so that should really be fine.
> 
> The messages have not gone away yet, I personally think they should.
> They originate from here, in net/ceph/messenger.c:
> 
>   static void ceph_fault(struct ceph_connection *con)
>           __releases(con->mutex)
>   {
>           pr_err("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
>                  ceph_pr_addr(&con->peer_addr.in_addr), con->error_msg)
> 
> Perhaps this should become pr_info() or something.  Sage?

Yeah, I think pr_info() is probably the right choice.  Do you know if that 
hits the console by default, or just dmesg/kern.log?

sage


> 
> 					-Alex
> 
> > On Wednesday, October 24, 2012 at 11:45 PM, jie sun wrote:
> > 
> >> What is the version of the master branch ? I use the stable version
> >> 0.48.2 Thank you! -SunJie
> >> 
> >> 2012/10/24 Gregory Farnum <greg@inktank.com>:
> >>> On Tuesday, October 23, 2012 at 10:48 PM, jie sun wrote:
> >>>> My vm kernel version is "Linux ubuntu12 3.2.0-23-generic".
> >>>> 
> >>>> "ceph-s" shows " health HEALTH_OK monmap e1: 1 mons at
> >>>> {a=10.100.211.146:6789/0}, election epoch 0, quorum 0 a osdmap
> >>>> e152: 10 osds: 9 up, 9 in pgmap v48479: 2112 pgs: 2112
> >>>> active+clean; 23161 MB data, 46323 MB used, 2451 GB / 2514 GB
> >>>> avail mdsmap e31: 1/1/1 up {0=a=up:active} "
> >>>> 
> >>>> In my vm, I do operations like: I install 4 debs on my vm, such
> >>>> as libnss3, libnspr4, librados2, librbd1. And then execute
> >>>> "modprobe rbd" so that I can map a image to my vm. Then "rbd
> >>>> create foo --size 10240 -m $monIP(my ceph mon IP)", "rbd map
> >>>> foo -m $monIP" ------ Here a device /dev/rbd0 can be used as a
> >>>> local device "mkfs -t ext4 /dev/rbd0" "mount /dev/rbd0 /mnt(or
> >>>> some other directory)" After the operations above, I can use
> >>>> this device. But it oftern prompt some log like "libceph: osd9
> >>>> 10.100.211.68:6809 socket closed". I just want to mount a
> >>>> device to my vm, so I didn't install a ceph client. Is this
> >>>> proper to do so?
> >>> 
> >>> 
> >>> 
> >>> You might consider using the native QEMU/libvirt instead; it
> >>> offers some more advanced options. But if you're happy with it,
> >>> this certainly works!
> >>> 
> >>> The "socket closed" messages are just noise; it's nothing to be
> >>> concerned about (you'll notice they're happening every 15 minutes
> >>> for each OSD; probably you aren't doing any disk accesses). I
> >>> think these warnings actually got removed from our master branch
> >>> a few days ago. -Greg
> >> 
> > 
> > 
> > 
> > -- To unsubscribe from this list: send the line "unsubscribe
> > ceph-devel" in the body of a message to majordomo@vger.kernel.org 
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
