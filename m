From: "Handzik, Joe" <joseph.t.handzik@hp.com>
Subject: RE: Preferred location for utility execution
Date: Mon, 29 Jun 2015 18:44:36 +0000
Message-ID: <2C438B34CAC8264398F5C7AF7411910A6D961A4B@G4W3206.americas.hpqcorp.net>
References: <2C438B34CAC8264398F5C7AF7411910A6D9605F5@G4W3206.americas.hpqcorp.net>
 <558DD0FC.8080608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:46261 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbbF2SpM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 14:45:12 -0400
In-Reply-To: <558DD0FC.8080608@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: "gmeno@redhat.com" <gmeno@redhat.com>

Thanks for the reply, John. I knew where you stood. :)

I tend to agree with you for much of this, I should be able to pull a fair amount of drive metadata out of /sys, and now that I've added the device node to bootstrap off of, that sort of data collection should be easy to initiate alongside the rest of the metadata collection here: https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L4566

Something I'm not sure of is, say, Gregory's commit to Calamari. Does your opinion extend to functionality like that? Should SMART be collected within Ceph, rather than via a salt script initiated by Calamari?

Joe

-----Original Message-----
From: John Spray [mailto:john.spray@redhat.com] 
Sent: Friday, June 26, 2015 5:24 PM
To: Handzik, Joe; ceph-devel
Cc: gmeno@redhat.com
Subject: Re: Preferred location for utility execution



On 26/06/2015 21:14, Handzik, Joe wrote:
> Hey ceph-devel,
>
> Gregory Meno (of Calamari fame) and I are working on what is now officially a blueprint for Jewel ( http://tracker.ceph.com/projects/ceph/wiki/Calamariapihardwarestorage ), and we'd like some feedback.
>
> Some of this has been addressed via separate conversations about the feature that some of this work started out as (identifying drives in a cluster by toggling their LED states), but we wanted to ask a more direct question: What is the preferred location/mechanism to execute operations on storage hardware?
>
> We see two clear options:
>
> 1. Make Calamari responsible for executing commands using various linux utilities (and /sys, when applicable).
> 2. Build a command set into RADOS to execute commands using various linux utilities. These commands could then be executed by Calamari using the rest api.
>
> The big win for #1 is the ability to rapidly iterate on the capabilities of the Calamari toolset (it is almost certainly going to be faster to create a set of scripts similar to Gregory's initial commit for SMART polling than to add that functionality inside RADOS. See: https://github.com/ceph/calamari/pull/267 ). For #2, we'd pick up the ability to run those same commands via the cli, which would give users a lot more flexibility in how they troubleshoot their cluster (Calamari wouldn't be required, it would just make life easier).

Hi Joe,

I'd reiterate my earlier comments[1] in favour of option 2.

I would be cautious about implementing any of this in Calamari until there are at least upstream packages available for folks to use, and broader uptake.  In the current situation, it's hard to ask people to try something out in Calamari, and much more straightforward to distribute something as part of Ceph.  Hardware is pretty varied, I would expect you'll need help from others in the community to ensure any hardware handling works as expected in diverse environments, which will be much simpler with ceph than calamari.

The part where some central python (calamari or otherwise) would really come into its own is in the fusion of information from multiple hosts, and exposing it to a user interface.  On that aspect, I left some comments last time this came up: 
http://lists.ceph.com/pipermail/ceph-calamari-ceph.com/2015-May/000073.html

Ceph itself is getting a bit smarter with some of this stuff, e.g. the new "node ls" stuff gives you metadata about hosts and services without the need for calamari.  Hanging device info off these new structures would be a pretty reasonable thing to do, and if someone later has a GUI that they want to pipe that into, they can grab it via the mon along with everything else.

Cheers,
John


1. https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg23186.html
