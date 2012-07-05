From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Osd placement rule questions
Date: Thu, 05 Jul 2012 16:55:05 +1200
Message-ID: <4FF51E29.3000205@catalyst.net.nz>
References: <4FF50DD2.6030507@catalyst.net.nz> <Pine.LNX.4.64.1207042055350.6931@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49930 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab2GEEzJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 00:55:09 -0400
In-Reply-To: <Pine.LNX.4.64.1207042055350.6931@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/07/12 15:57, Sage Weil wrote:
> On Thu, 5 Jul 2012, Mark Kirkwood wrote:
>
>> 2/ Also I would like to be able to say make my number of copies 3, but if I
>> lose datacenter0 (where 2 copies are), don't try to have 3 copies at
>> datacenter1 (so run degraded in that case). Is that possible?
> That is what you get now.  Doing the opposite (2 copies in DC1, 1 in DC2,
> but if DC2 is down 3 in DC1) is not currently possible with the crush
> rules.
>

Ah, right - excellent and thanks for clarifying! I guess I was 
unconsciously (and incorrectly) thinking that the crush rule would be 
modified when (say) datacenter0 was not available.

Cheers

Mark
