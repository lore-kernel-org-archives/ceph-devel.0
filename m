From: "Handzik, Joe" <joseph.t.handzik@hp.com>
Subject: RE: Advice for implementation of LED behavior in Ceph ecosystem
Date: Wed, 1 Apr 2015 18:56:13 +0000
Message-ID: <2C438B34CAC8264398F5C7AF7411910A6341F7EB@G4W3206.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:48674 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbbDAS53 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Apr 2015 14:57:29 -0400
Received: from g9t5008.houston.hp.com (g9t5008.houston.hp.com [15.240.92.66])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hp.com (Postfix) with ESMTPS id 0132718B4
	for <ceph-devel@vger.kernel.org>; Wed,  1 Apr 2015 18:56:59 +0000 (UTC)
Received: from G9W0364.americas.hpqcorp.net (g9w0364.houston.hp.com [16.216.193.45])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g9t5008.houston.hp.com (Postfix) with ESMTPS id 8943013C
	for <ceph-devel@vger.kernel.org>; Wed,  1 Apr 2015 18:56:58 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hey all,

Gregory Meno's pull request in Calamari (https://github.com/ceph/calamari/pull/267) is motivating some discussion about a feature (or set of features) that I'm about to start working on.

My goal is to allow users to enable the identify and fault LEDs (fault is negotiable) via the Calamari GUI. I've had some discussion with Dan Mick and Gregory Meno about the concept, and they both see the value in it. The decision that needs to be made is...where should this functionality exist? There are a couple of obvious choices, after Gregory's SMART patch:

1. Stick everything in Calamari via Salt calls similar to what Gregory is showing. I have concerns about this, I think I'd still need extra information from the OSDs themselves. I might need to implement the first half of option #2 anyway.
2. Scatter it across the codebases (would probably require changes in Ceph, Calamari, and Calamari-clients). Expose the storage target data via the OSDs, and move that information upward via the RESTful API. Then, expose another RESTful API behavior that allows a user to change the LED state. Implementing as much as possible in the Ceph codebase itself has an added benefit (as far as I see it, at least) if someone ever decides that the fault LED should be toggled on based on the state of the OSD or backing storage device. It should be easier for Ceph to hook into that kind of functionality if Calamari doesn't need to be involved.

Dan mentioned something I thought about too...not EVERY OSD's backing storage is going to be able to use this (Kinetic drives, NVDIMMs, M.2, etc etc), I'd need to implement some way to filter devices and communicate via the Calamari GUI that the device doesn't have an LED to toggle or doesn't understand SCSI Enclosure Services (I'm targeting industry standard HBAs first, and I'll deal with RAID controllers like Smart Array later). 

I'm trying to get this out there early so anyone with particularly strong implementation opinions can give feedback. Any advice would be appreciated! I'm still new to the Ceph source base, and probably understand Calamari and Calamari-clients better than Ceph proper at the moment.

Thanks,

Joe
