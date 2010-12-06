From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Odd "data used" reporting behavior by ceph -w
Date: Mon, 6 Dec 2010 16:02:48 -0700
Message-ID: <1291676568.4879.326.camel@sale659.sandia.gov>
References: <1291412399.4879.288.camel@sale659.sandia.gov>
 <AANLkTi=3fJz8aoywUCMzBrOWtENfaqEJ__76PXHrmppQ@mail.gmail.com>
 <1291418749.4879.319.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1012042048060.28007@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:60216 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389Ab0LFXDD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Dec 2010 18:03:03 -0500
In-Reply-To: <Pine.LNX.4.64.1012042048060.28007@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

On Sat, 2010-12-04 at 21:59 -0700, Sage Weil wrote:
> 
> > > > 4) recreate files, same size/name as step 2);
> > > >
> > > > Note that this step takes _much_ longer: 1448 sec vs. 41 sec.
> > > > Maybe redirecting stdout onto a file from an echo of nothing
> > > > is a really stupid way to truncate a file, but still...
> > > > seems like something might not be right?
> 
> When you say 'recreate', you mean you 0-truncate the file, and then reopen 
> and write new data, right?  It's not a _new_ file that happens to have the 
> same name?

Yes, I 0-truncate the file, then open that same file again.

> 
> My first guess is that it's related to the fact that the truncate is done 
> on a different client and the 'wanted' caps aren't getting released, 
> forcing IO to be synchronous.  Can you repeat that experiment, but 
> write + truncate + rewrite all on the same node?

Yes, it definitely matters on which clients the operations
occur.  If the create, 0-truncate, rewrite all happen on
the same client, all is well.

If I truncate a file on a different client, I see the slowdown.

-- Jim

> 
> It may also be that there is some contention on the OSDs due to the object 
> deletes going in parallel with the new data being written.  I wouldn't 
> expect that to be an issue though... :/
> 
> Thanks!
> sage




