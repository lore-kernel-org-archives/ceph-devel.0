From: "Handzik, Joe" <joseph.t.handzik@hp.com>
Subject: RE: Advice for implementation of LED behavior in Ceph ecosystem
Date: Wed, 1 Apr 2015 22:10:06 +0000
Message-ID: <2C438B34CAC8264398F5C7AF7411910A6341FA7D@G4W3206.americas.hpqcorp.net>
References: <2C438B34CAC8264398F5C7AF7411910A6341F7EB@G4W3206.americas.hpqcorp.net>
 <551C6083.4070707@redhat.com> <551C693E.6020100@redhat.com>
 <551C69B1.9070100@redhat.com> <551C6B6F.9080308@redhat.com>
 <551C6C30.4040705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:50211 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbbDAWLW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Apr 2015 18:11:22 -0400
In-Reply-To: <551C6C30.4040705@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sounds like this LED flashing business is going to evolve. I'll let you guys know when I have a first pass implementation in play...you can tell me which future pieces I might've forgotten to take into account.

Really, really great info. I think the key takeaway for me is to see how much I can get done in Ceph by itself, and involve Calamari and Calamari-clients only when necessary. At least to start.

-----Original Message-----
From: John Spray [mailto:john.spray@redhat.com] 
Sent: Wednesday, April 01, 2015 5:08 PM
To: Mark Nelson; Handzik, Joe; ceph-devel@vger.kernel.org
Subject: Re: Advice for implementation of LED behavior in Ceph ecosystem

On 01/04/2015 23:04, John Spray wrote:
> On 01/04/2015 22:57, Mark Nelson wrote:
>> It seems to me that the OSD potentially would flash the LED on it's 
>> way down if it thinks it's drive is dead/dying?
> That's a good idea for the case where ceph-osd is proactively 
> identifying a failing drive.  I'm also thinking about the case where 
> we come back from a reboot and a drive is sufficiently unreadable that 
> ceph-disk doesn't see the OSD partitions and ceph-osd never gets 
> started, or the OSD's local filesystem is unmountable.  Because the 
> keyring lives on that local filesystem, OSDs couldn't phone home in 
> that case, even to report a failure.
Sorry, mental lapse: we're not talking about phoning home, we're talking 
about flashing the LED.  So perhaps ceph-disk itself could be modified 
to flash an LED on a drive if it has a GPT partition ID for a ceph osd 
but we can't mount it or start an OSD service.

John
