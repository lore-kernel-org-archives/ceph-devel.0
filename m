From: John Spray <john.spray@redhat.com>
Subject: Re: Advice for implementation of LED behavior in Ceph ecosystem
Date: Wed, 01 Apr 2015 22:17:55 +0100
Message-ID: <551C6083.4070707@redhat.com>
References: <2C438B34CAC8264398F5C7AF7411910A6341F7EB@G4W3206.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38463 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbbDAVR5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Apr 2015 17:17:57 -0400
In-Reply-To: <2C438B34CAC8264398F5C7AF7411910A6341F7EB@G4W3206.americas.hpqcorp.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Handzik, Joe" <joseph.t.handzik@hp.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/04/2015 19:56, Handzik, Joe wrote:
> 1. Stick everything in Calamari via Salt calls similar to what Gregory is showing. I have concerns about this, I think I'd still need extra information from the OSDs themselves. I might need to implement the first half of option #2 anyway.
> 2. Scatter it across the codebases (would probably require changes in Ceph, Calamari, and Calamari-clients). Expose the storage target data via the OSDs, and move that information upward via the RESTful API. Then, expose another RESTful API behavior that allows a user to change the LED state. Implementing as much as possible in the Ceph codebase itself has an added benefit (as far as I see it, at least) if someone ever decides that the fault LED should be toggled on based on the state of the OSD or backing storage device. It should be easier for Ceph to hook into that kind of functionality if Calamari doesn't need to be involved.
>
> Dan mentioned something I thought about too...not EVERY OSD's backing storage is going to be able to use this (Kinetic drives, NVDIMMs, M.2, etc etc), I'd need to implement some way to filter devices and communicate via the Calamari GUI that the device doesn't have an LED to toggle or doesn't understand SCSI Enclosure Services (I'm targeting industry standard HBAs first, and I'll deal with RAID controllers like Smart Array later).
>
> I'm trying to get this out there early so anyone with particularly strong implementation opinions can give feedback. Any advice would be appreciated! I'm still new to the Ceph source base, and probably understand Calamari and Calamari-clients better than Ceph proper at the moment.

Similar to Mark's comment, I would lean towards option 2 -- it would be 
great to have a CLI-driven ability to flash the LEDs for an OSD, and 
work on integrating that with a GUI afterwards.

Currently the OSD metadata on drives is pretty limited, it'll just tell 
you the /var/lib/ceph/osd/ceph-X path for the data and journal -- the 
task of resolving that to a physical device is left as an exercise to 
the reader, so to speak.

I would suggest extending osd metadata to also report the block device, 
but only for the simple case where an OSD is a GPT partition on a raw 
/dev/sdX block device.  Resolving block device to underlying disks in 
configurations like LVM/MDRAID/multipath is complex in the general case 
(I've done it, I don't recommend it), and most ceph clusters don't use 
those layers.  You could add a fallback ability for users to specify 
their block device in ceph.conf, in case the simple GPT-assuming OSD 
probing code can't find it from the mount point.

Once you have found the block device and reported it in the OSD 
metadata, you can use that information to go poke its LEDs using 
enclosure services hooks as you suggest, and wrap that in an OSD 'tell' 
command (OSD::do_command).  In a similar vein to finding the block 
device, it would be a good thing to have a config option here so that 
admins can optionally specify a custom command for flashing a particular 
OSD's LED.  Admins might not bother setting that, but it would mean a 
system integrator could optionally configure ceph to work with whatever 
exotic custom stuff they have.

Hopefully that's some help, it sounds like you've already thought it 
through a fair bit anyway.

Cheers,
John
