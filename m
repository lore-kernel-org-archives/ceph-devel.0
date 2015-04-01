From: Sage Weil <sage@newdream.net>
Subject: Re: Advice for implementation of LED behavior in Ceph ecosystem
Date: Wed, 1 Apr 2015 16:17:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504011613410.23387@cobra.newdream.net>
References: <2C438B34CAC8264398F5C7AF7411910A6341F7EB@G4W3206.americas.hpqcorp.net> <551C6083.4070707@redhat.com> <551C693E.6020100@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48445 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbDAXRd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Apr 2015 19:17:33 -0400
In-Reply-To: <551C693E.6020100@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: "Handzik, Joe" <joseph.t.handzik@hp.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 1 Apr 2015, John Spray wrote:
> I guess in this interesting case you could either:
>  * Allow other OSDs on the same host to handle the 'tell blink' command for
> the dead OSD's drive
>  * Leave this to calamari/whoever to read the dead OSD's block device path
> from "ceph osd metadata", and go blink the LEDs themselves.

#2 really sounds safer to me.  In particular, you need to be really 
careful not to flash an LED until you're sure you don't need the data on 
the disk (i.e., it's down+out and the cluster state is healthy--no heroic 
measures needed).  I think anything that triggers flashing that doesn't 
have a holistic view of the cluster would be dangerous.

That, combined with the complications around ceph-osd possibly not 
running, make me thing this would be the calamari agent that does the 
flashing.

It also may be necessary for the disk -> last known state mapping to go 
somewhere other than in just osd metadata; if the osd is recreated or the 
id gets reused that info go away.  (We could also be careful to avoid 
deallocating the id until the disk is removed, I guess, but it's another 
constraint to worry about.)

sage
