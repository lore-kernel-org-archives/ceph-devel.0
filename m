From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Mon losing touch with OSDs
Date: Sat, 23 Feb 2013 11:57:24 +1100
Message-ID: <20130223005724.GB8844@onthe.net.au>
References: <20130217234107.GA19416@onthe.net.au>
 <alpine.DEB.2.00.1302171743460.25660@cobra.newdream.net>
 <20130219030202.GA5010@onthe.net.au>
 <20130220020703.GA8567@onthe.net.au>
 <20130222030614.GA13873@onthe.net.au>
 <alpine.DEB.2.00.1302221344550.5703@cobra.newdream.net>
 <20130222233555.GA9173@onthe.net.au>
 <alpine.DEB.2.00.1302221543090.5703@cobra.newdream.net>
 <20130223000843.GA10200@onthe.net.au>
 <alpine.DEB.2.00.1302221612230.5703@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:58486 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab3BWA50 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 19:57:26 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302221612230.5703@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Feb 22, 2013 at 04:13:21PM -0800, Sage Weil wrote:
> On Sat, 23 Feb 2013, Chris Dunlop wrote:
>> On Fri, Feb 22, 2013 at 03:43:22PM -0800, Sage Weil wrote:
>>> On Sat, 23 Feb 2013, Chris Dunlop wrote:
>>>> On Fri, Feb 22, 2013 at 01:57:32PM -0800, Sage Weil wrote:
>>>>> On Fri, 22 Feb 2013, Chris Dunlop wrote:
>>>>>> G'day,
>>>>>> 
>>>>>> It seems there might be two issues here: the first being the delayed
>>>>>> receipt of echo replies causing an seemingly otherwise healthy osd to be
>>>>>> marked down, the second being the lack of recovery once the downed osd is
>>>>>> recognised as up again.
>>>>>> 
>>>>>> Is it worth my opening tracker reports for this, just so it doesn't get
>>>>>> lost?
>>>>> 
>>>>> I just looked at the logs.  I can't tell what happend to cause that 10 
>>>>> second delay.. strangely, messages were passing from 0 -> 1, but nothing 
>>>>> came back from 1 -> 0 (although 1 was queuing, if not sending, them).
>> 
>> Is there any way of telling where they were delayed, i.e. in the 1's output
>> queue or 0's input queue?
> 
> Yeah, if you bump it up to 'debug ms = 20'.  Be aware that that will 
> generate a lot of logging, though.

I really don't want to load the system with too much logging, but I'm happy
modifying code...  Are there specific interesting debug outputs which I can
modify so they're output under "ms = 1"?

Chris
