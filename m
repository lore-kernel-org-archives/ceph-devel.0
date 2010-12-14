From: Sage Weil <sage@newdream.net>
Subject: Re: packaging for ceph-gui
Date: Tue, 14 Dec 2010 12:37:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012141235310.22978@cobra.newdream.net>
References: <Pine.LNX.4.64.1012141155100.26702@cobra.newdream.net>
 <1292358476.25794.88.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46357 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759597Ab0LNUca (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Dec 2010 15:32:30 -0500
In-Reply-To: <1292358476.25794.88.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: ceph-devel@vger.kernel.org

On Tue, 14 Dec 2010, Laszlo Boszormenyi wrote:
> Hi Sage,
> 
> On Tue, 2010-12-14 at 11:56 -0800, Sage Weil wrote:
> > Colin separated out the gui from the 'ceph' binary (it's gceph) in the 
> > unstable branch of git, which means we can break it into a separate 
> > package and eliminate all the gtk dependencies for the other stuff.
>  Yes, I've seen that, which was a very good decision. ceph is for every
> kind of machines, mostly servers. There's no need other binaries (GTK+
> or others) that not strictly necessary to operate a service. They occupy
> space and may expose security problems. On the other hand, I don't like
> running GUIs when I'm on a slow connection (maybe just to fix a config
> file from a PDA).
> 
> > Maybe a ceph-gui, recommended by ceph?
>  It's up to you how to name it. As for the rule of thumb, packages named
> after the binary they contain. So it should be gceph, but can be
> ceph-gui if you want.

I'm inclined to rename gceph to ceph-gui, actually, unless anyone has any 
strong opinions about it...

> I was a bit lazy to check out, is ceph mandatory for using gceph? As
> I've seen no, the logic remained in ceph.cc , the command line and gui
> tool went to cmd.cc and gceph.cc respectively.
> The question is, when do you want to merge these changes to rc? There
> are unstable and gceph trees available, but are they for v0.24 or not?

The binary is standalone.  They should just recommend each other, I think. 
And this is all in the unstable branch (for v0.25), so we can just change 
it there.

sage
