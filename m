From: Ted Ts'o <tytso@mit.edu>
Subject: Re: OOM's on the Ceph client machine
Date: Thu, 21 Oct 2010 18:28:22 -0400
Message-ID: <20101021222822.GK3127@thunk.org>
References: <E1P5pFk-0001oE-Mv@tytso-glaptop>
 <AANLkTi=U_RLy8Nd-yeTqK4gK1EWuZOk=8drg4K_Uwk3+@mail.gmail.com>
 <20101013033406.GD4833@thunk.org>
 <Pine.LNX.4.64.1010130917210.7988@cobra.newdream.net>
 <20101014000306.GB11103@thunk.org>
 <20101021203648.GH3127@thunk.org>
 <Pine.LNX.4.64.1010211422200.18946@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:40410 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534Ab0JUW22 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Oct 2010 18:28:28 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1010211422200.18946@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org, mrubin@google.com

On Thu, Oct 21, 2010 at 02:46:11PM -0700, Sage Weil wrote:
> 
> Unfortunately it's not obvious to me from dmesg where the problem is, 
> other than that it looks like some of the osds aren't responding (but are 
> apparently still up).  There is a known regression in v0.22 that can cause 
> crashes in the osd cluster; we should have a fix pushed later today.  
> That would look a bit different, though (you'd see osd down messages).  
> I'll post an update (and probably v0.22.1) when that's been tested.

I looked earlier in the logs, and I do see some "osd down", "osd up",
and "osd socket closed" messages.  So it looks like the v0.22
regression you mentioned.  I'll wait for the git update and try
rebuilding the server.  Thanks!!

> > Also, It seems that there are issues moving back and forth between
> > 0.21 and 0.22 without reformating the ceph client.  Is that accurate?
> 
> Yeah, that isn't expected to work.  In general, rolling backward isn't 
> supported.  In this case we forgot to add an incompat flag to generate a 
> nice error message to that effect.

Is rolling forward between 0.21 and 0.22 expected to work?  Or should
I just do a mkcephfs just to be safe?  It's not a data preservation
issue, but rather the time it takes to do a mkcephfs.  Random
question: how do you feel about using Python?  Trying to make a
version of mkcephfs that runs in parallel would probably be easier if
we could port the shell script to a python script.  I don't think
there are any Python dependencies in Ceph right now, though.

      	      	     		     	  - Ted
