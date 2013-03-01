From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Mon losing touch with OSDs
Date: Fri, 1 Mar 2013 13:02:39 +1100
Message-ID: <20130301020239.GA16236@onthe.net.au>
References: <alpine.DEB.2.00.1302221344550.5703@cobra.newdream.net>
 <20130222233555.GA9173@onthe.net.au>
 <alpine.DEB.2.00.1302221543090.5703@cobra.newdream.net>
 <20130223000843.GA10200@onthe.net.au>
 <alpine.DEB.2.00.1302221612230.5703@cobra.newdream.net>
 <20130223005724.GB8844@onthe.net.au>
 <alpine.DEB.2.00.1302221728550.19172@cobra.newdream.net>
 <20130223014908.GA9749@onthe.net.au>
 <alpine.DEB.2.00.1302221751200.19172@cobra.newdream.net>
 <20130223020253.GA11899@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:47040 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab3CACCm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Feb 2013 21:02:42 -0500
Content-Disposition: inline
In-Reply-To: <20130223020253.GA11899@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Feb 23, 2013 at 01:02:53PM +1100, Chris Dunlop wrote:
> On Fri, Feb 22, 2013 at 05:52:11PM -0800, Sage Weil wrote:
>> On Sat, 23 Feb 2013, Chris Dunlop wrote:
>>> On Fri, Feb 22, 2013 at 05:30:04PM -0800, Sage Weil wrote:
>>>> On Sat, 23 Feb 2013, Chris Dunlop wrote:
>>>>> On Fri, Feb 22, 2013 at 04:13:21PM -0800, Sage Weil wrote:
>>>>>> On Sat, 23 Feb 2013, Chris Dunlop wrote:
>>>>>>> On Fri, Feb 22, 2013 at 03:43:22PM -0800, Sage Weil wrote:
>>>>>>>> On Sat, 23 Feb 2013, Chris Dunlop wrote:
>>>>>>>>> On Fri, Feb 22, 2013 at 01:57:32PM -0800, Sage Weil wrote:
>>>>>>>>>> I just looked at the logs.  I can't tell what happend to cause that 10 
>>>>>>>>>> second delay.. strangely, messages were passing from 0 -> 1, but nothing 
>>>>>>>>>> came back from 1 -> 0 (although 1 was queuing, if not sending, them).
>>>>>>> 
>>>>>>> Is there any way of telling where they were delayed, i.e. in the 1's output
>>>>>>> queue or 0's input queue?
>>>>>> 
>>>>>> Yeah, if you bump it up to 'debug ms = 20'.  Be aware that that will 
>>>>>> generate a lot of logging, though.
>>>>> 
>>>>> I really don't want to load the system with too much logging, but I'm happy
>>>>> modifying code...  Are there specific interesting debug outputs which I can
>>>>> modify so they're output under "ms = 1"?
>>>> 
>>>> I'm basically interested in everything in writer() and write_message(), 
>>>> and reader() and read_message()...
>>> 
>>> Like this?
>> 
>> Yeah.  You could do 2 instead of 1 so you can turn it down.  I suspect 
>> that this is the lions share of what debug 20 will spam to the log, but 
>> hopefully the load is manageable!
> 
> Good idea on the '2'. I'll get that installed and wait for it to happen again.

FYI...

To avoid running out of disk space for the massive logs, I
started using logrotate on the ceph logs every two hours, which
does a 'service ceph reload' to re-open the log files.

In the week since doing that I haven't seen any 'slow requests'
at all (the load has stayed the same as before the change),
which means the issue with the osds dropping out, then the
system not recovering properly, also hasn't happened.

That's a bit suspicious, no?

I've now put the log dirs on each machine on their own 2TB
partition and reverted back to the default daily rotates.

And once more we're waiting... Godot, is that you?


Chris
