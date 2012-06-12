From: Sage Weil <sage@inktank.com>
Subject: Re: cephx auth question
Date: Tue, 12 Jun 2012 09:56:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206120942040.6742@cobra.newdream.net>
References: <CAMmJxtJViXYznfRuzMqJsvWZ7YEghkgD2HUhHZ9h4AyaXFz+cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50789 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab2FLQ4V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 12:56:21 -0400
In-Reply-To: <CAMmJxtJViXYznfRuzMqJsvWZ7YEghkgD2HUhHZ9h4AyaXFz+cA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

A few things that Wido missed:

On Tue, 12 Jun 2012, John Axel Eriksson wrote:

> I asked a similar question in a previous email but I didn't get any
> satisfying answers. What exactly does cephx auth secure?
> >From the wiki I just get "this makes your cluster more secure", well
> from what? If I run on an internal network accessible only
> by a few trusted people - what does cephx auth secure in such a scenario?

There is some very preliminary docs at 

	http://ceph.com/docs/wip-auth/ops/manage/security/

Basically:

 * mutual authentication between client and server
 * capabilities limiting what clients are allowed to do

But:

 * no encryption of over-the-wire communications
 * no protection from hijacked TCP sessions (although simpler 
   man-in-the-middle attacks aren't possible)

> In that previous email I got the answer that it secures the cluster
> from mistakenly connecting to wrong cluster with rados and
> accidentally deleting a pool... well, can rados really "accidentally"
> connect to the wrong cluster?

The client can accidentally connect to the wrong cluster if fed the 
wrong monitor address or config.

> Only if I have the wrong config
> file right? And if I have the wrong config-file won't it be possible
> that I also have the "wrong" key in that case?

Yes.  

That said, daemons are careful to validate the cluster fsid before 
communicating regardless of whether cephx is enabled or not. 

You *can* put fsid = ... in the config file, but the client side isn't 
validating it currently, and that won't help if you point at the wrong 
config file.

> Another scenario would be if I take down an OSD that just sits in
> storage for say 6 months and then someone starts that machine
> again - with key-based auth that OSD wouldn't be able to
> connect(somehow? but if it has a working key?) but without auth it
> could
> possibly connect and wreak havoc in the cluster (since it is so much
> behind perhaps in both version of software and what's stored on it).
> I thought marking and OSD as down or out would do that?

Marking out manually will prevent the osd from being marked in 
automatically, but it will still start up and 'join' the cluster.  
However, whenever there is an incompatible change, we bump protocol 
numbers or add feature fits, so it shouldn't be able to do any damage.

I think the main motivation is to prevent a non-root user from, say, 
deleting your data pool, or to limit such 'admin' activity to a select 
number of nodes (e.g., the monitor hosts).

sage

> Are those the main reasons for having cephx auth? Is it to secure the
> cluster against people (myself included) making mistakes or  from
> hacking, or is there some technical reason that I don't know of or understand?
> 
> The reason I'm asking is because having cephx enabled makes cluster
> setup much more complicated...
> 
> 
> Thanks,
> 
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
