From: Martin Mailand <martin@tuxadero.com>
Subject: Re: Assertion in v0.40 - os/FileStore.cc: 2438: FAILED assert(0 ==
 "unexpected error")
Date: Sun, 15 Jan 2012 12:39:37 +0100
Message-ID: <4F12BAF9.4040301@tuxadero.com>
References: <4F1193DE.7040202@tuxadero.com> <Pine.LNX.4.64.1201141835180.21391@cobra.newdream.net>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:57335 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab2AOLjn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 Jan 2012 06:39:43 -0500
In-Reply-To: <Pine.LNX.4.64.1201141835180.21391@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
that's exactly what I did, the first two crashes are in this log, 
unfortunately there was no debug level set.

http://85.214.49.87/ceph/osd.0.full.log.bz2

-martin



Am 15.01.2012 03:45, schrieb Sage Weil:
> Hi Martin-
>
> On Sat, 14 Jan 2012, Martin Mailand wrote:
>
>> Hi
>> one of four OSD died during the update to v0.40 with an Assertion
>> os/FileStore.cc: 2438: FAILED assert(0 == "unexpected error")
>> Even after a complete shutdown of the cluster an a new start with all OSD at
>> the same version, this osd did not start.
>>
>> The OSD Log it attached.
>
> It's trying to replay a transaction that appears to be invalid because the
> .2 clone is smaller than it thinks.  Is this the first time the OSD
> crashed, or did it crash once, and you cranked up logs and generated
> this one?  If you have the previous log, that would be helpful... it
> should have a similar tranasction dump but a different stack trace.
>
> Also, are any of the 6 patches on top of 0.40 related to the filestore or
> osd?
>
> Thanks!
> sage
>
