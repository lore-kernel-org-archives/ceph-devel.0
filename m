From: Mark Nelson <mnelson@redhat.com>
Subject: Re: [IANA #821110] Application for a Port Number and/or Service Name
 "ceph" (fwd)
Date: Wed, 29 Apr 2015 12:31:07 -0500
Message-ID: <5541155B.7090609@redhat.com>
References: <alpine.DEB.2.00.1504290959540.24030@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47918 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965748AbbD2RbL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Apr 2015 13:31:11 -0400
In-Reply-To: <alpine.DEB.2.00.1504290959540.24030@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On 04/29/2015 12:02 PM, Sage Weil wrote:
> So, I picked 6789 way back in commit
> dc38de9b14c5386f9f446124ca6d6673eb8a1e20 because it was unused according
> to nmap-services.  It's there now, in use by smc-https (whatever that is),
> and says it was registered in 2002.  I guess the nmap-services file I
> looked at at the time was out of date?
>
> In any case, if we want an IANA assigned number, we'll need to change it.
>
> We should be able to make a transition reasonably painless by making
> clients try both ports when none is specified for some period.
>
> I'm assuming it's worth the effort... what do you think?

Yes, I think it's worth it.  Better now than when we are 10x bigger than 
<large storage vendor> right? ;)

Mark

>
> sage
>
