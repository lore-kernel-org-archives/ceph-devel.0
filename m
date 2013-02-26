From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: maintanance on osd host
Date: Tue, 26 Feb 2013 20:44:42 +0100
Message-ID: <512D10AA.2020906@profihost.ag>
References: <512CCD19.7010509@profihost.ag> <alpine.DEB.2.00.1302260904440.2730@cobra.newdream.net> <727CEF0E-7D1E-4298-B0E4-9729CAA4E787@profihost.ag> <alpine.DEB.2.00.1302260922510.4819@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:58994 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757465Ab3BZTol (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 14:44:41 -0500
In-Reply-To: <alpine.DEB.2.00.1302260922510.4819@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

Am 26.02.2013 18:24, schrieb Sage Weil:
> On Tue, 26 Feb 2013, Stefan Priebe - Profihost AG wrote:
>> But that redults in a 1-3s hickup for all KVM vms. This is not what I want.
>
> You can do
>
>   kill $pid
>   ceph osd down $osdid
>
> (or even reverse the order, if the sequence is quick enough) to avoid
> waiting for the failure detection delay.  But if the OSDs are going down,
> then the peering has to happen one way or another.

But exaclty this results in starting backfill immediatly. My idea was to 
first mark the osd down so the mon knows about this fact. So no I/O is 
stalled. And then reboot the whole host but exactly this does not work 
like expected as backfilling is starting immediatly after setting the 
osd to down ;-(

Greets,
Stefan
