From: John Spray <john.spray@redhat.com>
Subject: Re: Advice for implementation of LED behavior in Ceph ecosystem
Date: Wed, 01 Apr 2015 23:04:31 +0100
Message-ID: <551C6B6F.9080308@redhat.com>
References: <2C438B34CAC8264398F5C7AF7411910A6341F7EB@G4W3206.americas.hpqcorp.net> <551C6083.4070707@redhat.com> <551C693E.6020100@redhat.com> <551C69B1.9070100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56387 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbbDAWEe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Apr 2015 18:04:34 -0400
In-Reply-To: <551C69B1.9070100@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, "Handzik, Joe" <joseph.t.handzik@hp.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/04/2015 22:57, Mark Nelson wrote:
> It seems to me that the OSD potentially would flash the LED on it's 
> way down if it thinks it's drive is dead/dying?
That's a good idea for the case where ceph-osd is proactively 
identifying a failing drive.  I'm also thinking about the case where we 
come back from a reboot and a drive is sufficiently unreadable that 
ceph-disk doesn't see the OSD partitions and ceph-osd never gets 
started, or the OSD's local filesystem is unmountable.  Because the 
keyring lives on that local filesystem, OSDs couldn't phone home in that 
case, even to report a failure.

John
