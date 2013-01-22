From: Sage Weil <sage@inktank.com>
Subject: Re: Consistently reading/writing rados objects via command line
Date: Mon, 21 Jan 2013 21:14:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301212113140.29915@cobra.newdream.net>
References: <CAPud5_7tn1yEkCZSb+f7MC8_-jGFPzm+VZp6RAMBK8vaX3sArA@mail.gmail.com> <0CFBBA27610A4E35A8D340A46E009F40@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57459 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab3AVFOr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 00:14:47 -0500
In-Reply-To: <0CFBBA27610A4E35A8D340A46E009F40@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Nick Bartos <nick@pistoncloud.com>, ceph-devel@vger.kernel.org

On Mon, 21 Jan 2013, Gregory Farnum wrote:
> On Monday, January 21, 2013 at 5:01 PM, Nick Bartos wrote:
> > I would like to store some objects in rados, and retrieve them in a
> > consistent manor. In my initial tests, if I do a 'rados -p foo put
> > test /tmp/test', while it is uploading I can do a 'rados -p foo get
> > test /tmp/blah' on another machine, and it will download a partially
> > written file without returning an error code, so the downloader cannot
> > tell the file is corrupt/incomplete.
> >  
> > My question is, how do I read/write objects in rados via the command
> > line in such a way where the downloader does not get a corrupt or
> > incomplete file? It's fine if it just returns an error on the client
> > and I can try again, I just need to be notified on error.
> >  
> You must be writing large-ish objects? By default the rados tool will upload objects 4MB at a time and you're trying to download mid-way through the full object upload. You can add a "--block-size 20971520" to upload 20MB in a single operation, but make sure you don't exceed the "osd max write size" (90MB by default).
> This is all client-side stuff, though ? from the RADOS object store's perspective, the file is complete after each 4MB write. If you want something more sophisticated (like handling larger objects) you'll need to do at least some minimal tooling of your own, e.g. by setting an object xattr before starting and after finishing the file change, then checking for that presence when reading (and locking on reads or doing a check when the read completes). You can do that with the "setxattr", "rmxattr", and "getxattr" options.

With a bit of additional support in the rados tool, we could write to 
object $foo.tmp with key $foo, and then clone it into position and delete 
the .tmp.

If they're really big objects, though, you may also be better off with 
radosgw, which provides striping and atomicity..

sage
