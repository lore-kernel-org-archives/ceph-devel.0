From: Sage Weil <sage@newdream.net>
Subject: Re: read performance not perfect
Date: Sat, 6 Aug 2011 12:08:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108061207280.17864@cobra.newdream.net>
References: <CABAwU-YJ8DFjphavMQ+NjqPU7=fFBtwsEMzE7xT1G8gp4LywSA@mail.gmail.com>
 <Pine.LNX.4.64.1107181012540.22215@cobra.newdream.net>
 <CABAwU-YKmEC=umFLzDb-ykPbzQ9s3sKoUmQbkumExrXEwyveNA@mail.gmail.com>
 <Pine.LNX.4.64.1108040846500.17151@cobra.newdream.net>
 <loom.20110804T213454-854@post.gmane.org> <Pine.LNX.4.64.1108041252230.26398@cobra.newdream.net>
 <4E3B2D78.5060605@ufm.su> <Pine.LNX.4.64.1108041825230.29841@cobra.newdream.net>
 <4E3B8F0E.20606@ufm.su> <Pine.LNX.4.64.1108050905350.12301@cobra.newdream.net>
 <4E3D1F87.5020005@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55434 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191Ab1HFTEL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Aug 2011 15:04:11 -0400
In-Reply-To: <4E3D1F87.5020005@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Sat, 6 Aug 2011, Fyodor Ustinov wrote:
> On 08/05/2011 07:07 PM, Sage Weil wrote:
> > 
> > This is not.  I'll open a bug and try to track this one down.  It looks
> > new.
> In yours kernel version I do not see this trouble.

Oh, this might have been the bug Jim was seeing a few weeks back, fixed by 
0da5d70369e87f80adf794080cfff1ca15a34198 (merged into 3.0-rc1).  In any 
case, if you see this again with the current code, let us know!

sage
