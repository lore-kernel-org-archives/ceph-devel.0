From: Sage Weil <sage@newdream.net>
Subject: Re: rbd snap
Date: Fri, 23 Sep 2011 11:21:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109231120360.8231@cobra.newdream.net>
References: <4E736107.4050309@tuxadero.com> <Pine.LNX.4.64.1109160928170.11043@cobra.newdream.net>
 <4E73C064.7020104@tuxadero.com> <4E73CC58.9070503@dreamhost.com>
 <4E74C653.6080404@tuxadero.com> <4E7CCB3B.7080606@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47682 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab1IWSVr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2011 14:21:47 -0400
In-Reply-To: <4E7CCB3B.7080606@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 23 Sep 2011, Martin Mailand wrote:
> Hi,
> is it possible to access snapshots without to rollback the head of the rbd
> volumen?
> Because I want to do a snapshot of a vm running via librbd and qemu, and use
> the snapshot to make a offsite backup of the vm.

$ rbd export foo --snap=mysnap /path/to/foo.dump

You can also map the snapshot via qemu with a string like 
rbd:rbd/foo@mysnap.

sage


> 
> Best Regards,
>  Martin
> 
> 
> Martin Mailand schrieb:
> > Okay, with the btrfs patch and the right commandline snapshotting works like
> > a charm.
> > 
> > best regards,
> >  martin
> > 
> > Josh Durgin schrieb:
> > > On 09/16/2011 02:32 PM, Martin Mailand wrote:
> > > > root@c-brick-001:~# rbd rm --snap=2011091601 test
> > > > *** Caught signal (Segmentation fault) **
> > > > in thread 0x7f203d749740
> > > > ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
> > > > 1: rbd() [0x457062]
> > > > 2: (()+0xfc60) [0x7f203ccf6c60]
> > > > 3: (librbd::snap_set(librbd::ImageCtx*, char const*)+0x10)
> > > > [0x7f203d32ecd0]
> > > > 4: (main()+0x59f) [0x4518ff]
> > > > 5: (__libc_start_main()+0xff) [0x7f203b6cdeff]
> > > > 6: rbd() [0x44d569]
> > > > Segmentation fault
> > > 
> > > I added a bug to the tracker for this
> > > (http://tracker.newdream.net/issues/1545). It shouldn't crash the way you
> > > ran it, but if you're trying to remove a snapshot you need to use the
> > > 'snap rm' command, i.e.:
> > > $ rbd snap rm --snap=2011091601 test
> > > -- 
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > -- 
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
