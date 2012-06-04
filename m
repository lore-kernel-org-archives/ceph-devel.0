From: Greg Farnum <greg@inktank.com>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Mon, 4 Jun 2012 13:17:43 -0700
Message-ID: <9C7F8B20FB3B49508B9FBEE725AB34EE@inktank.com>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com>
 <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com>
 <DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu>
 <05C460A496DC45689D6578B20D699425@inktank.com>
 <217DCA5E-26E6-4357-96E7-0C9AF4E06071@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47331 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab2FDUR6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 16:17:58 -0400
Received: by pbbrp8 with SMTP id rp8so6467751pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 13:17:58 -0700 (PDT)
In-Reply-To: <217DCA5E-26E6-4357-96E7-0C9AF4E06071@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Nam Dang <namd@de.cs.titech.ac.jp>, ceph-devel <ceph-devel@vger.kernel.org>

On Thursday, May 31, 2012 at 4:58 PM, Noah Watkins wrote:
> 
> On May 31, 2012, at 3:39 PM, Greg Farnum wrote:
> > > 
> > > Nevermind to my last comment. Hmm, I've seen this, but very rarely.
> > Noah, do you have any leads on this? Do you think it's a bug in your Java code or in the C/++ libraries?
> 
> 
> 
> I _think_ this is because the JVM uses its own threading library, and Ceph assumes pthreads and pthread compatible mutexes--is that assumption about Ceph correct? Hence the error that looks like Mutex::lock(bool) being reference for context during the segfault. To verify this all that is needed is some synchronization added to the Java.
I'm not quite sure what you mean here. Ceph is definitely using pthread threading and mutexes, but I don't see how the use of a different threading library can break pthread mutexes (which are just using the kernel futex stuff, AFAIK).
But I admit I'm not real good at handling those sorts of interactions, so maybe I'm missing something?

> There are only two segfaults that I've ever encountered, one in which the C wrappers are used with an unmounted client, and the error Nam is seeing (although they could be related). I will re-submit an updated patch for the former, which should rule that out as the culprit.
> 
> Nam: where are you grabbing the Java patches from? I'll push some updates.
> 
> 
> The only other scenario that comes to mind is related to signaling:
> 
> The RADOS Java wrappers suffered from an interaction between the JVM and RADOS client signal handlers, in which either the JVM or RADOS would replace the handlers for the other (not sure which order). Anyway, the solution was to link in the JVM libjsig.so signal chaining library. This might be the same thing we are seeing here, but I'm betting it is the first theory I mentioned.
Hmm. I think that's an issue we've run into but I thought it got fixed for librados. Perhaps I'm mixing that up with libceph, or just pulling past scenarios out of thin air. It never manifested as Mutex count bugs, though!
-Greg

