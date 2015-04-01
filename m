From: Sage Weil <sage@newdream.net>
Subject: RE: Advice for implementation of LED behavior in Ceph ecosystem
Date: Wed, 1 Apr 2015 13:29:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504011325420.23387@cobra.newdream.net>
References: <2C438B34CAC8264398F5C7AF7411910A6341F7EB@G4W3206.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47633 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbbDAU37 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Apr 2015 16:29:59 -0400
In-Reply-To: <2C438B34CAC8264398F5C7AF7411910A6341F7EB@G4W3206.americas.hpqcorp.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Handzik, Joe" <joseph.t.handzik@hp.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Joe,

First, Hooray! that you're working on this!  :)

On Wed, 1 Apr 2015, Handzik, Joe wrote:
> Hey all,
> 
> Gregory Meno's pull request in Calamari 
> (https://github.com/ceph/calamari/pull/267) is motivating some 
> discussion about a feature (or set of features) that I'm about to start 
> working on.
> 
> My goal is to allow users to enable the identify and fault LEDs (fault 
> is negotiable) via the Calamari GUI. I've had some discussion with Dan 
> Mick and Gregory Meno about the concept, and they both see the value in 
> it. The decision that needs to be made is...where should this 
> functionality exist? There are a couple of obvious choices, after 
> Gregory's SMART patch:
> 
> 1. Stick everything in Calamari via Salt calls similar to what Gregory 
> is showing. I have concerns about this, I think I'd still need extra 
> information from the OSDs themselves. I might need to implement the 
> first half of option #2 anyway.

I'm skeptical that this can work without *some* Ceph changes..

> 2. Scatter it across the codebases (would probably require changes in 
> Ceph, Calamari, and Calamari-clients). Expose the storage target data 
> via the OSDs, and move that information upward via the RESTful API. 
> Then, expose another RESTful API behavior that allows a user to change 
> the LED state. Implementing as much as possible in the Ceph codebase 
> itself has an added benefit (as far as I see it, at least) if someone 
> ever decides that the fault LED should be toggled on based on the state 
> of the OSD or backing storage device. It should be easier for Ceph to 
> hook into that kind of functionality if Calamari doesn't need to be 
> involved.

This sounds more practical.

> Dan mentioned something I thought about too...not EVERY OSD's backing 
> storage is going to be able to use this (Kinetic drives, NVDIMMs, M.2, 
> etc etc), I'd need to implement some way to filter devices and 
> communicate via the Calamari GUI that the device doesn't have an LED to 
> toggle or doesn't understand SCSI Enclosure Services (I'm targeting 
> industry standard HBAs first, and I'll deal with RAID controllers like 
> Smart Array later).

I suspect the first step is to make sure that the OSDs are surfacing the 
metadata you need about the devices.  I would start with what is currently 
exposed via 'ceph osd metadata <id>'.  See

	https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L4508
and
	https://github.com/ceph/ceph/blob/master/src/os/FileStore.cc#L642

..but I'm guessing this quite enough information yet.

> I'm trying to get this out there early so anyone with particularly 
> strong implementation opinions can give feedback. Any advice would be 
> appreciated! I'm still new to the Ceph source base, and probably 
> understand Calamari and Calamari-clients better than Ceph proper at the 
> moment.

Exposing everything in a generic way should also cover this case.  
Backends that don't have meaningful enclosure metadata won't have it (or 
will report something different, like which DIMM slot the NVDIMM is in, or 
whatever.)

As for the process that actuallly flips the LED state, that probably makes 
more sense to do via Calamari?

sage

