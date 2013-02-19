From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Mon losing touch with OSDs
Date: Tue, 19 Feb 2013 14:02:03 +1100
Message-ID: <20130219030202.GA5010@onthe.net.au>
References: <20130215032939.GA25578@onthe.net.au>
 <alpine.DEB.2.00.1302142051250.19927@cobra.newdream.net>
 <20130215220521.GA29999@onthe.net.au>
 <20130217234107.GA19416@onthe.net.au>
 <alpine.DEB.2.00.1302171743460.25660@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:55691 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757367Ab3BSDCG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Feb 2013 22:02:06 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302171743460.25660@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Feb 17, 2013 at 05:44:29PM -0800, Sage Weil wrote:
> On Mon, 18 Feb 2013, Chris Dunlop wrote:
>> On Sat, Feb 16, 2013 at 09:05:21AM +1100, Chris Dunlop wrote:
>>> On Thu, Feb 14, 2013 at 08:57:11PM -0800, Sage Weil wrote:
>>>> On Fri, 15 Feb 2013, Chris Dunlop wrote:
>>>>> In an otherwise seemingly healthy cluster (ceph 0.56.2), what might cause the
>>>>> mons to lose touch with the osds?
>>>> 
>>>> Can you enable 'debug ms = 1' on the mons and leave them that way, in the 
>>>> hopes that this happens again?  It will give us more information to go on.
>>> 
>>> Debug turned on.
>> 
>> We haven't experienced the cluster losing touch with the osds completely
>> since upgrading from 0.56.2 to 0.56.3, but we did lose touch with osd.1
>> for a few seconds before it recovered. See below for logs (reminder: 3
>> boxes, b2 is mon-only, b4 is mon+osd.0, b5 is mon+osd.1).
> 
> Hrm, I don't see any obvious clues.  You could enable 'debug ms = 1' on 
> the osds as well.  That will give us more to go on if/when it happens 
> again, and should not affect performance significantly.

Done: ceph osd tell '*' injectargs '--debug-ms 1'

Now to wait for it to happen again.

Chris
