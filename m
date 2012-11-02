From: Danny Al-Gaaf <danny@bisect.de>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more
 flexible
Date: Fri, 02 Nov 2012 10:58:20 +0100
Message-ID: <5093993C.6000902@bisect.de>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de> <alpine.DEB.2.00.1208100851260.8611@cobra.newdream.net> <502530C9.7030008@bisect.de> <alpine.DEB.2.00.1208100909190.8611@cobra.newdream.net> <alpine.DEB.2.00.1208161448060.26904@cobra.newdream.net> <CADvuQRGBEva_8OB--M2JxMBoCXQ3i5GJkaJ-QvP-SoVqv7xDzw@mail.gmail.com> <alpine.DEB.2.00.1208161635290.26904@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33074 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750927Ab2KBKQe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 06:16:34 -0400
In-Reply-To: <alpine.DEB.2.00.1208161635290.26904@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

Hi Sage,

sorry for the late reply, was absent some weeks and busy with other issues.

Am 17.08.2012 01:40, schrieb Sage Weil:
> On Thu, 16 Aug 2012, Tommi Virtanen wrote:
>> On Thu, Aug 16, 2012 at 3:32 PM, Sage Weil <sage@inktank.com> wrote:
>>> As for the new options, I suggest:
>>>
>>>  * osd fs type
>>>  * osd fs devs   (will work for mkcephfs, not for new stuff)
>>>  * osd fs path
>>>  * osd fs options
>>
>> What does osd_fs_path mean, and how is it different from the osd_data dir?
> 
> The idea was that you might wand the fs mounted somewhere other that 
> osd_data.  I'm not sure it's useful; we may as well drop that...
> 
>> I'm expecting to need both mkfs-time options (btrfs metadata block
>> size etc) and mount-time options (noatime etc).
>>
>> It would be nice if there was a way to set the options for all
>> fstypes, and then just toggle which one is used (by default). That
>> avoids bugs like trying to mkfs/mount btrfs with xfs-specific options,
>> and vice versa.
>>
>> I'm not sure how well our config system will handle dynamic variable
>> names -- ceph-authtool was fine with me just putting data in
>> osd_crush_location, and we don't need to access these variables from
>> C++, so it should be fine. If you really wanted to, you could probably
>> cram the them into a single variable, with ad hoc structured data in
>> the string value, but that's ugly.. Or just hardcode the list of
>> possible filesystems, and then it's not dynamic variable names
>> anymore.
> 
> Yeah, ceph-conf will happily take anything.  The C++ code has to do 
> slightly more work to get arbitrary config fields, but that's not an 
> issue.
> 
>> So I'm dreaming of something like:
>>
>> [osd]
>> # what mount options will be passed when an osd data disk is using
>> # one of these filesystems; these are passed to mount -o
>> osd mount options btrfs = herp,foo=bar
>> osd mount options xfs = noatime,derp
>>
>> # what mkfs options are used when creating new osd data disk
>> # filesystems
>> osd mkfs options btrfs = --hur
>> osd mkfs options xfs = --dur
>>
>> # what fstype to use by default when mkfs'ing; mounting will detect
>> # what's there (with blkid) and work with anything
>> osd mkfs type = btrfs

I will prepare a patch with these for the current mkcephfs and init-ceph
incl. aliases for the old keys and cmdline options where possible.

>> # this may go away with "mkcephfs 2.0", and it will have to get more
>> # complex if we provide something for journals too, etc, because you
>> # may want to pair specific data disks to specific journals (DH has
>> # this need).. haven't had time to think it through, which is why i'm
>> # leaning toward "and here's a hook where you run something on the
>> # host that calls ceph-disk-prepare etc on all the disks you want",
>> # and using uuids to match journals to data disks -- this work has
>> # not yet started)
>> osd fs devs = /dev/sdb /dev/sdc
> 
> This all looks good to me.  What do you think, Danny?

This part (osd fs devs) is for a new mkcepfs.2.0 if I understand you
correctly. Sounds okay for me atm. (Tommi: Are there any new information
on this? Did you already start to work on this?)

Danny

