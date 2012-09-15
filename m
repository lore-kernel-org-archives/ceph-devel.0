From: Sage Weil <sage@inktank.com>
Subject: Re: Status of Fencing
Date: Sat, 15 Sep 2012 04:14:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209150404000.16190@cobra.newdream.net>
References: <CA+jddaNnQAaQ0cT5-0OarOdrRqsuTrbm8naZnsfUCUdXWT0z9Q@mail.gmail.com> <5053CBC2.1050406@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41291 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab2IOLOw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Sep 2012 07:14:52 -0400
In-Reply-To: <5053CBC2.1050406@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Mandell Degerness <mandell@pistoncloud.com>, ceph-devel@vger.kernel.org

On Fri, 14 Sep 2012, Josh Durgin wrote:
> On 09/14/2012 05:14 PM, Mandell Degerness wrote:
> > I was wondering if there was an update on the RBD fencing question.
> > Either knowing when an RBD is mounted elsewhere or being able to
> > enforce a fence on an RBD would be really helpful.
> > 
> > -Mandell Degerness
> 
> Advisory locking of rbd images is ready for review in the wip-librbd-locking
> branch. This lets you lock/unlock images with the rbd cli tool,
> so you could detect when it's being used, but fencing is not
> implemented yet.

After talking it over with a few people, I have some confidence that the 
'incremental' fencing scheme I suggested a few weeks back will work... 
certainly with btrfs, and almost certainly with XFS.  Basically, this 
amounts to:

 - identify old rbd lock holder (rbd lock list <img>)
 - blacklist old owner (ceph osd blacklist add <addr>)
 - break old rbd lock (rbd lock remove <img> <lockid> <addr>)
 - lock rbd image on new host (rbd lock add <img> <lockid>)
 - map rbd image on new host

The trick is making sure that the new image owner knows about the osdmap 
that includes the new blacklist... this ensures that any rbd objects that 
client reads is no longer touchable by the old guy.  This is probably 
always the case if the mounting/mapping kernel is intracting with the 
cluster for the first time, but I'd like to have a positive confirmation 
of that, and/or a general way to make sure a client has at last a given 
osdmap even in the case where it already has a cluster session (because 
another image is mapped).

Anyway, enough pieces are already in place that you should be able to play 
with this.  The main piece of work we need for this scheme is a test that 
continually yanks a filesystem away from a VM/host, remounts, and 
continues, while verifying things don't go sour.

Moving forward, we also need to make the rbd clients take/release locks 
themselves (instead of the user doing so explicitly), and make the 
'takeover' process a bit more streamlined.

sage
