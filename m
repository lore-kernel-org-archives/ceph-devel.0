From: John Spray <john.spray@redhat.com>
Subject: Re: Advice for implementation of LED behavior in Ceph ecosystem
Date: Wed, 01 Apr 2015 22:55:10 +0100
Message-ID: <551C693E.6020100@redhat.com>
References: <2C438B34CAC8264398F5C7AF7411910A6341F7EB@G4W3206.americas.hpqcorp.net> <551C6083.4070707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56718 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbbDAVzS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Apr 2015 17:55:18 -0400
In-Reply-To: <551C6083.4070707@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Handzik, Joe" <joseph.t.handzik@hp.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/04/2015 22:17, John Spray wrote:
> Once you have found the block device and reported it in the OSD 
> metadata, you can use that information to go poke its LEDs using 
> enclosure services hooks as you suggest, and wrap that in an OSD 
> 'tell' command (OSD::do_command).  In a similar vein to finding the 
> block device, it would be a good thing to have a config option here so 
> that admins can optionally specify a custom command for flashing a 
> particular OSD's LED.  Admins might not bother setting that, but it 
> would mean a system integrator could optionally configure ceph to work 
> with whatever exotic custom stuff they have.
One more thought occurs to me -- one of the main cases where you'd want 
to flash an LED would be to identify the drive of an OSD that is 
down/out due to a dead drive.  In that instance, the ceph-osd process 
wouldn't actually be running, so you wouldn't be able to send it the 
'tell' to flash the LED.

I guess in this interesting case you could either:
  * Allow other OSDs on the same host to handle the 'tell blink' command 
for the dead OSD's drive
  * Leave this to calamari/whoever to read the dead OSD's block device 
path from "ceph osd metadata", and go blink the LEDs themselves.

Cheers,
John
