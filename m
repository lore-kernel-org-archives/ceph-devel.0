From: John Leach <john@brightbox.co.uk>
Subject: Re: librados: failed to decode message of type 59 v1: buffer::end_of_buffer
Date: Tue, 25 Sep 2012 10:54:45 +0100
Message-ID: <50617F65.10706@brightbox.co.uk>
References: <5060CD3F.7060101@brightbox.co.uk> <alpine.DEB.2.00.1209241836210.2213@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp131.iad.emailsrvr.com ([207.97.245.131]:57078 "EHLO
	smtp131.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab2IYJys (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 05:54:48 -0400
In-Reply-To: <alpine.DEB.2.00.1209241836210.2213@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 25/09/12 02:37, Sage Weil wrote:
> Hi John,
> 
> It looks like we aren't encoding the old format for the pool_stat_t 
> structure (which changed in v0.42).  Can you try with the patch from 
> wip-3212 applied?  You can get debs from the gitbuilders, see
> 
> 	http://ceph.com/docs/master/install/debian/
> 
> under development testing packages.
> 
> Thanks!
> sage
> 
> http://tracker.newdream.net/issues/3212

I've tested and this looks fixed (as in, my client now gives a better
error message when trying to connect). have responded to ticket 3212.
Thanks!

The logs are more helpful now but my client still hangs - how should I
detect this situation in code (using librados)? It just keeps trying to
connect and finally returns a "Connection timed out" error.

tbh, I presume this really isn't a common situation but just wanted to
be sure that I'm not missing something.

Thanks,

John.


> 
> On Mon, 24 Sep 2012, John Leach wrote:
> 
>> Hi,
>>
>> I'm calling rados_ioctx_pool_stat and it's hanging.
>>
>> logs show:
>>
>>> 2012-09-24 21:30:08.411947 7f0041251700 failed to decode message of type 59 v1: buffer::end_of_buffer
>>> 2012-09-24 21:30:08.412286 7f0043255700 monclient: hunting for new mon
>>
>> my local client is the Ubuntu Precise provided librados2 package
>> (0.41-1ubuntu2.1)
>>
>> my cluster is running the unstable packages provided by Ceph
>> (0.51-1precise).
>>
>> If I upgrade my client just up to the stable 0.48.1argonaut-1precise
>> package, it fixes the problem.
>>
>> If the protocol changed, then I'd expect librados would let me know. Is
>> there some way to check this? rados_version returns the version of the
>> library, but I can't see how to get the version of the cluster (or quite
>> how I'd compare them in a meaningful way).
>>
>> Thanks,
>>
>> John.
>> --
>> UK multi-zone cloud: http://brightbox.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

