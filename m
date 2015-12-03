From: Casey Bodley <cbodley@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 10:16:31 -0500 (EST)
Message-ID: <1998646860.28019612.1449155791509.JavaMail.zimbra@redhat.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com> <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:34363 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460AbbLCPQz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 10:16:55 -0500
In-Reply-To: <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, ceph-devel@vger.kernel.org

Hi,

To those writing benchmarks, please note that the standard library
provides std::make_shared() as an optimization for shared_ptr. It
creates the object and its shared storage in a single allocation,
instead of the two allocations required for
"std::shared_ptr<Foo> fs (new Foo())".

Casey

----- Original Message -----
> 1- I agree we should avoid shared_ptr whenever possible.
> 
> 2- unique_ptr should not have any more overhead than a raw pointer--the
> compiler is enforcing the single-owner semantics.  See for example
> 
> 	https://msdn.microsoft.com/en-us/library/hh279676.aspx
> 
> "It is exactly is efficient as a raw pointer and can be used in STL
> containers."
> 
> Unless the implementation is broken somehow?  That seems unlikely...
> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
