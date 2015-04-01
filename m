From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Advice for implementation of LED behavior in Ceph ecosystem
Date: Wed, 01 Apr 2015 15:27:08 -0500
Message-ID: <551C549C.4050701@redhat.com>
References: <2C438B34CAC8264398F5C7AF7411910A6341F7EB@G4W3206.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60624 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022AbbDAU1M (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Apr 2015 16:27:12 -0400
In-Reply-To: <2C438B34CAC8264398F5C7AF7411910A6341F7EB@G4W3206.americas.hpqcorp.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Handzik, Joe" <joseph.t.handzik@hp.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 04/01/2015 01:56 PM, Handzik, Joe wrote:
>
> Hey all,
>
> Gregory Meno's pull request in Calamari (https://github.com/ceph/calamari/pull/267) is motivating some discussion about a feature (or set of features) that I'm about to start working on.
>
> My goal is to allow users to enable the identify and fault LEDs (fault is negotiable) via the Calamari GUI. I've had some discussion with Dan Mick and Gregory Meno about the concept, and they both see the value in it. The decision that needs to be made is...where should this functionality exist? There are a couple of obvious choices, after Gregory's SMART patch:
>
> 1. Stick everything in Calamari via Salt calls similar to what Gregory is showing. I have concerns about this, I think I'd still need extra information from the OSDs themselves. I might need to implement the first half of option #2 anyway.
> 2. Scatter it across the codebases (would probably require changes in Ceph, Calamari, and Calamari-clients). Expose the storage target data via the OSDs, and move that information upward via the RESTful API. Then, expose another RESTful API behavior that allows a user to change the LED state. Implementing as much as possible in the Ceph codebase itself has an added benefit (as far as I see it, at least) if someone ever decides that the fault LED should be toggled on based on the state of the OSD or backing storage device. It should be easier for Ceph to hook into that kind of functionality if Calamari doesn't need to be involved.
>
> Dan mentioned something I thought about too...not EVERY OSD's backing storage is going to be able to use this (Kinetic drives, NVDIMMs, M.2, etc etc), I'd need to implement some way to filter devices and communicate via the Calamari GUI that the device doesn't have an LED to toggle or doesn't understand SCSI Enclosure Services (I'm targeting industry standard HBAs first, and I'll deal with RAID controllers like Smart Array later).
>
> I'm trying to get this out there early so anyone with particularly strong implementation opinions can give feedback. Any advice would be appreciated! I'm still new to the Ceph source base, and probably understand Calamari and Calamari-clients better than Ceph proper at the moment.

I'd personally vastly prefer #2.  Back when I worked for an HPC center, 
we constantly were frustrated by being tied into GUIs by storage 
vendors.  It's not that they were necessarily bad in any way and we 
often did use them.  We just wanted the ability to watch for or script 
these things ourselves independently of the GUI.  Unless it's a huge 
burden, having most of this exist in ceph itself (potentially via some 
kind of flexible mechanism that can be used for other tools like megacli 
as well) would be a huge win imho.  Having a calamari interface that can 
control that would of course be very nice.

Mark

>
> Thanks,
>
> Joe
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
