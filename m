From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph docs page down
Date: Mon, 21 Jan 2013 08:31:45 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301210830010.29915@cobra.newdream.net>
References: <CACkq2mpwNrhujqOjeSCOxFZOFzcy3W4=GjyVDaq47Fsb0c=K7w@mail.gmail.com> <50FD69C9.4010804@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50828 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab3AUQbp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jan 2013 11:31:45 -0500
In-Reply-To: <50FD69C9.4010804@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Travis Rhoden <trhoden@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

They're back up now.

They're auto-generated from git, the build failed due to an 
intermittent network connectivity problem, and eventually the old content 
timed out because master wasn't updated over the weekend.  Need to 
special-case the docs gitbuilder, or increase the timeout, or something so 
that this doesn't happen again..

sage

On Mon, 21 Jan 2013, Wido den Hollander wrote:

> Hi,
> 
> On 01/21/2013 05:11 PM, Travis Rhoden wrote:
> > I suspect someone is working on it, but http://ceph.com/docs/master/
> > is returning HTTP 404.
> > 
> 
> I don't know if anyone is working on it, but in the meantime, use:
> http://eu.ceph.com/docs/master/
> 
> Wido
> 
> >   - Travis
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
