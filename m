From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 4/4] libceph: a few small changes
Date: Fri, 02 Mar 2012 15:28:59 -0800
Message-ID: <4F5157BB.1050108@dreamhost.com>
References: <4F4DAD34.2030202@dreamhost.com> <4F4DADB4.4040909@dreamhost.com> <Pine.LNX.4.64.1203021339350.6413@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55483 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965513Ab2CBX3A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 18:29:00 -0500
In-Reply-To: <Pine.LNX.4.64.1203021339350.6413@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 03/02/2012 01:40 PM, Sage Weil wrote:
>> +	default:
>> >  +		WARN(1, "unexpected socket state (%d)", sk->sk_state);
>> >  +		break;
>> >    	}
> This is a red herring... the switch isn't meant to be exhaustive, only to
> catch the interesting (shutdown) states.  I think #2099 can be closed as
> well.

That's pretty funny.  Didn't I open that bug?

I will drop the WARN() but will add a comment to indicate it's
explicitly not meant to cover all expected cases.

					-Alex
