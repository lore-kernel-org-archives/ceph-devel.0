From: Sage Weil <sage@newdream.net>
Subject: Re: 0.31
Date: Sun, 10 Jul 2011 14:36:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107101433470.10951@cobra.newdream.net>
References: <4E19837D.7030702@ufm.su> <Pine.LNX.4.64.1107101411040.10951@cobra.newdream.net>
 <4E1A19AC.8060304@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36856 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab1GJVdJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Jul 2011 17:33:09 -0400
In-Reply-To: <4E1A19AC.8060304@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Mon, 11 Jul 2011, Fyodor Ustinov wrote:
> On 07/11/2011 12:12 AM, Sage Weil wrote:
> > Hmm, yeah the 'loaded dup inode' messages should never happen.  They
> > appear to be just files, though, not directories, so you can safely ignore
> > them.  The namespace repair will need to clean that up at some point. The
> > recursive rstat errors you saw are probably just fallout from that, and
> > can also be ignored.
> I understand it correctly, that until not  implemented the Feature # 86 I have
> no way to fix this?

Right.  Well, this is going to come incrementally.  We'll have a namespace 
scan that fixes some basic issues before there is a full-blown robust 
repair tool.

> > I'm curious how you got into that state, though.  Are you running a single
> > or clustered mds?  Is the workload purely amanda?
>
> Single mds. I have these clients:
> 1. Amanda. Used cfuse.
> 2. Gate. Used cfuse. NFS gate.
> 3. One experimental server with many different workloads.
> 
> WBR,
>     Fyodor.
> 
> P.S. My friends have always said that I can find a bug in the software, even
> where it can not be. Sometimes it interferes. :)
> 
> I will try again to use ceph with BackupPC. Last time it was over "brain
> explosion" in ceph. :)

:) Okay.  We're putting locking specific tests in place before trying to 
reproduce #1150 with Amanda, BTW.  It sounds like we need an amanda-like 
workload though anyway, given the issues you're seeing.  How old is this 
fs?  How many times has it been upgraded?

sage

