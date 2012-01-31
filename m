From: Jon <jon@islandtechnologies.net>
Subject: Re: Ceph behavior in case of network failure
Date: Tue, 31 Jan 2012 15:34:46 -0800
Message-ID: <0C314DF0-5ACA-4CF4-A04F-C7EF8C0A1023@islandtechnologies.net>
References: <loom.20120129T054836-318@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lax-gw06.mailroute.net ([199.89.0.106]:33667 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753060Ab2AaXnd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2012 18:43:33 -0500
In-Reply-To: <loom.20120129T054836-318@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhan <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

I look forward to the availability of TRILL on commodity ethernet switches.

http://en.wikipedia.org/wiki/TRILL_(computing)

I expect that clustered systems like Ceph will help increase demand for TRILL.

On Jan 28, 2012, at 8:52 PM, Madhusudhan wrote:

> I have configured ceph in centos5.6 after a 
> very long fight. Now, i am in the way 
> to evaluate the Ceph. Forget me if my 
> question looks amateur. If we consider a 
> situation where my core switch fails, 
> resulting in n/w failure in entire data 
> center. What happens to ceph cluster ? 
> will it sustain this n/w failure and comes 
> online when the n/w is restored ? 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

