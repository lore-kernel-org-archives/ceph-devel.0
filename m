From: Sage Weil <sage@inktank.com>
Subject: Re: RGW: Refusing FastCGI request with empty CONTENT_LENGTH ? Why
 ?
Date: Tue, 2 Apr 2013 08:27:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304020827210.4476@cobra.newdream.net>
References: <CAF6-1L4GdD8w=3y-0fnVHLA1RPAoKmr-EwST9_pteD_i8opkPw@mail.gmail.com> <CAF6-1L6y81uVN29ZJyjxOHv5r=cQXqoYdSV22AGHY1U9Xgu57g@mail.gmail.com> <CAF6-1L5L1s4hdvrFLAiF7Z0ByJ0JcDASwrvM4AexPfmgvCg0=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44003 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932437Ab3DBP1b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 11:27:31 -0400
In-Reply-To: <CAF6-1L5L1s4hdvrFLAiF7Z0ByJ0JcDASwrvM4AexPfmgvCg0=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 2 Apr 2013, Sylvain Munaut wrote:
> Hi,
> 
> Replying to myself
> 
> > So that means if there is a CONTENT_LENGTH field in the environment
> > but it's empty, then the request is just refused.
> 
> This is fixed in master but wasn't backported to the bobtail branch,
> which is how I missed it ...

Which commit?  We can probably backport it..

s

> Sorry for the noise.
> 
> Cheers,
> 
>     Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
