From: Martin Mailand <martin@tuxadero.com>
Subject: Re: RBD layering design draft
Date: Sun, 17 Jun 2012 15:42:59 +0200
Message-ID: <4FDDDEE3.8020405@tuxadero.com>
References: <4FDB9FBB.9000807@inktank.com> <Pine.LNX.4.64.1206151742380.28086@cobra.newdream.net> <CAC-hyiEGzAF=hAae6mZLjOd+5jckVZD6+WfvJHpCYuueDCCX7g@mail.gmail.com> <Pine.LNX.4.64.1206160808050.1862@cobra.newdream.net>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:59874 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757204Ab2FQNnD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Jun 2012 09:43:03 -0400
In-Reply-To: <Pine.LNX.4.64.1206160808050.1862@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,
what's up locked, unlocked, unlocking?

-martin

Am 16.06.2012 17:11, schrieb Sage Weil:
> On Fri, 15 Jun 2012, Yehuda Sadeh wrote:
>> On Fri, Jun 15, 2012 at 5:46 PM, Sage Weil<sage@inktank.com>  wrote:
>>> Looks good!  Couple small things:
>>>
>>>>      $ rbd unpreserve pool/image@snap
>>>
>>> Is 'preserve' and 'unpreserve' the verbiage we want to use here?  Not sure
>>> I have a better suggestion, but preserve is unusual.
>>>
>>
>> freeze, thaw/unfreeze?
>
> Freeze/thaw usually mean something like quiesce I/O or read-only, usually
> temporarily.  What we actaully mean is "you can't delete this".  Maybe
> pin/unpin?  preserve/unpreserve may be fine, too!
>
> sage
