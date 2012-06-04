From: Greg Farnum <greg@inktank.com>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Mon, 4 Jun 2012 13:57:38 -0700
Message-ID: <36FA810BCDCA43DDA8A20A4A99BFAFF8@inktank.com>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com>
 <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com>
 <DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu>
 <05C460A496DC45689D6578B20D699425@inktank.com>
 <217DCA5E-26E6-4357-96E7-0C9AF4E06071@cs.ucsc.edu>
 <9C7F8B20FB3B49508B9FBEE725AB34EE@inktank.com>
 <CAPrxi59++wux__pY1M0qu+=YcVWAbkbLVWuxa95=ZLo8R64XiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60360 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab2FDU6d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 16:58:33 -0400
Received: by dady13 with SMTP id y13so6350366dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 13:58:33 -0700 (PDT)
In-Reply-To: <CAPrxi59++wux__pY1M0qu+=YcVWAbkbLVWuxa95=ZLo8R64XiA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, Nam Dang <namd@de.cs.titech.ac.jp>, ceph-devel <ceph-devel@vger.kernel.org>

On Monday, June 4, 2012 at 1:47 PM, Noah Watkins wrote:
> On Mon, Jun 4, 2012 at 1:17 PM, Greg Farnum <greg@inktank.com (mailto:greg@inktank.com)> wrote:
> 
> > I'm not quite sure what you mean here. Ceph is definitely using pthread threading and mutexes, but I don't see how the use of a different threading library can break pthread mutexes (which are just using the kernel futex stuff, AFAIK).
> > But I admit I'm not real good at handling those sorts of interactions, so maybe I'm missing something?
> 
> 
> 
> The basic idea was that threads in Java did not map 1:1 with kernel
> threads (think co-routines), which would break a lot of stuff,
> especially futex. Looking at some documentation, old JVMs had
> something called Green Threads, but have now been abandoned in favor
> of native threads. So maybe this theory is now irrelevant, and
> evidence seems to suggest you're right and Java is using native
> threads.

Gotcha, that makes sense.
 
> 
> > > The RADOS Java wrappers suffered from an interaction between the JVM and RADOS client signal handlers, in which either the JVM or RADOS would replace the handlers for the other (not sure which order). Anyway, the solution was to link in the JVM libjsig.so signal chaining library. This might be the same thing we are seeing here, but I'm betting it is the first theory I mentioned.
> 
> > Hmm. I think that's an issue we've run into but I thought it got fixed for librados. Perhaps I'm mixing that up with libceph, or just pulling past scenarios out of thin air. It never manifested as Mutex count bugs, though!
> 
> I haven't tested the Rados wrappers in a while. I've never had to link
> in the signal chaining library for libcephfs.
> 
> I wonder if the Mutex::lock(bool) being printed out is a red herring... 
Well, it's a SIGSEGV. So my guess is that's the frame that happens to be going outside its allowed bounds, probably because it's the first frame actually accessing the memory off of a bad (probably NULL) pointer. For instance, if it not only failed to mount the client, but even to create the context object? 

