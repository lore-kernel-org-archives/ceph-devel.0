From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more flexible
Date: Thu, 16 Aug 2012 15:52:47 -0700
Message-ID: <CADvuQRGBEva_8OB--M2JxMBoCXQ3i5GJkaJ-QvP-SoVqv7xDzw@mail.gmail.com>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de>
 <alpine.DEB.2.00.1208100851260.8611@cobra.newdream.net> <502530C9.7030008@bisect.de>
 <alpine.DEB.2.00.1208100909190.8611@cobra.newdream.net> <alpine.DEB.2.00.1208161448060.26904@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37136 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab2HPWxJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 18:53:09 -0400
Received: by lbbgj3 with SMTP id gj3so1793637lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 15:53:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208161448060.26904@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Danny Kukawka <danny.kukawka@bisect.de>, ceph-devel@vger.kernel.org

On Thu, Aug 16, 2012 at 3:32 PM, Sage Weil <sage@inktank.com> wrote:
> As for the new options, I suggest:
>
>  * osd fs type
>  * osd fs devs   (will work for mkcephfs, not for new stuff)
>  * osd fs path
>  * osd fs options

What does osd_fs_path mean, and how is it different from the osd_data dir?

I'm expecting to need both mkfs-time options (btrfs metadata block
size etc) and mount-time options (noatime etc).

It would be nice if there was a way to set the options for all
fstypes, and then just toggle which one is used (by default). That
avoids bugs like trying to mkfs/mount btrfs with xfs-specific options,
and vice versa.

I'm not sure how well our config system will handle dynamic variable
names -- ceph-authtool was fine with me just putting data in
osd_crush_location, and we don't need to access these variables from
C++, so it should be fine. If you really wanted to, you could probably
cram the them into a single variable, with ad hoc structured data in
the string value, but that's ugly.. Or just hardcode the list of
possible filesystems, and then it's not dynamic variable names
anymore.

So I'm dreaming of something like:

[osd]
# what mount options will be passed when an osd data disk is using
# one of these filesystems; these are passed to mount -o
osd mount options btrfs = herp,foo=bar
osd mount options xfs = noatime,derp

# what mkfs options are used when creating new osd data disk
# filesystems
osd mkfs options btrfs = --hur
osd mkfs options xfs = --dur

# what fstype to use by default when mkfs'ing; mounting will detect
# what's there (with blkid) and work with anything
osd mkfs type = btrfs

# this may go away with "mkcephfs 2.0", and it will have to get more
# complex if we provide something for journals too, etc, because you
# may want to pair specific data disks to specific journals (DH has
# this need).. haven't had time to think it through, which is why i'm
# leaning toward "and here's a hook where you run something on the
# host that calls ceph-disk-prepare etc on all the disks you want",
# and using uuids to match journals to data disks -- this work has
# not yet started)
osd fs devs = /dev/sdb /dev/sdc
