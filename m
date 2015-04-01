From: "Handzik, Joe" <joseph.t.handzik@hp.com>
Subject: Re: Advice for implementation of LED behavior in Ceph ecosystem
Date: Wed, 1 Apr 2015 23:48:18 +0000
Message-ID: <D4BC34EA-07C3-4763-BD8C-BF8EBC917B55@hp.com>
References: <2C438B34CAC8264398F5C7AF7411910A6341F7EB@G4W3206.americas.hpqcorp.net>
 <551C6083.4070707@redhat.com>
 <551C693E.6020100@redhat.com>,<alpine.DEB.2.00.1504011613410.23387@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:60650 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbbDAXuM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Apr 2015 19:50:12 -0400
In-Reply-To: <alpine.DEB.2.00.1504011613410.23387@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Well, keep in mind that this isn't just for identification of failed disks. I can conceive of use cases where a user flips on one or more drive LEDs for identification or debugging purposes. That would be the distinction between identity and fail. We can give the user the ability to distinguish between the two and figure out which they'd want to use at any given time (also, keep in mind that the failure LED is not customer controllable behind some storage controllers anyway...).

I was wondering if I'd need to carry along the last known disk state...guess I'll figure that nuance out as I go.

Joe

> On Apr 1, 2015, at 6:17 PM, Sage Weil <sage@newdream.net> wrote:
> 
> #2 really sounds safer to me.  In particular, you need to be really 
> careful not to flash an LED until you're sure you don't need the data on 
> the disk (i.e., it's down+out and the cluster state is healthy--no heroic 
> measures needed).  I think anything that triggers flashing that doesn't 
> have a holistic view of the cluster would be dangerous.
> 
> That, combined with the complications around ceph-osd possibly not 
> running, make me thing this would be the calamari agent that does the 
> flashing.
> 
> It also may be necessary for the disk -> last known state mapping to go 
> somewhere other than in just osd metadata; if the osd is recreated or the 
> id gets reused that info go away.  (We could also be careful to avoid 
> deallocating the id until the disk is removed, I guess, but it's another 
> constraint to worry about.)
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
