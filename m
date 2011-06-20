From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: inconsistent chunk
Date: Mon, 20 Jun 2011 20:19:40 +0300
Message-ID: <4DFF812C.70900@ufm.su>
References: <4DFAE436.9060606@ufm.su>	<E58F9FF9-B13F-45D7-86D3-5C1940A919C7@dreamhost.com>	<4DFCC3EE.2090700@ufm.su> <7CF4E65F-BFA1-429D-BE72-CE86ED79992F@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:55531 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755523Ab1FTRTn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Jun 2011 13:19:43 -0400
In-Reply-To: <7CF4E65F-BFA1-429D-BE72-CE86ED79992F@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, samuel.just@dreamhost.com

On 06/20/2011 08:16 PM, Gregory Farnum wrote:
>>> 4. Can I recover the data without backup?
>>> Possibly. If the inconsistency is just that one of the OSDs is storing the object and another OSD says the object shouldn't exist, that can be recovered from by working out which one is correct.
>>>
>>> Have you manually adjusted the contents of any OSDs? Can you think of anything you've done that might have triggered this?
>> I step by step down osd servers until only one remains (hmm, it is not clear how this is consistent with "pg_size 2"). After one day I step by step up osd servers.
> Well if you've got enough space and step down slowly enough all the data will simply exist on the one up OSD in a degraded form. :)
>
> Is it still marked as inconsistent? If that's really all you did it shouldn't be, but maybe restarting the cluster would let it fix itself. :/
> -Greg

Yes, I restarted osd server with inconsistent pg and cluster now in 
consistent state.

WBR,
     Fyodor.

