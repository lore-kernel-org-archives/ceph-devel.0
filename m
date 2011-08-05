From: Sage Weil <sage@newdream.net>
Subject: Re: read performance not perfect
Date: Fri, 5 Aug 2011 13:17:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108051315420.12301@cobra.newdream.net>
References: <CABAwU-YJ8DFjphavMQ+NjqPU7=fFBtwsEMzE7xT1G8gp4LywSA@mail.gmail.com>
 <Pine.LNX.4.64.1107181012540.22215@cobra.newdream.net>
 <CABAwU-YKmEC=umFLzDb-ykPbzQ9s3sKoUmQbkumExrXEwyveNA@mail.gmail.com>
 <Pine.LNX.4.64.1108040846500.17151@cobra.newdream.net>
 <loom.20110804T213454-854@post.gmane.org> <Pine.LNX.4.64.1108041252230.26398@cobra.newdream.net>
 <4E3B2D78.5060605@ufm.su> <Pine.LNX.4.64.1108041825230.29841@cobra.newdream.net>
 <4E3B8F0E.20606@ufm.su> <Pine.LNX.4.64.1108050905350.12301@cobra.newdream.net>
 <4E3C44DC.9090906@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45180 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756221Ab1HEUMq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2011 16:12:46 -0400
In-Reply-To: <4E3C44DC.9090906@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Fri, 5 Aug 2011, Fyodor Ustinov wrote:
> On 08/05/2011 07:07 PM, Sage Weil wrote:
> > 
> > This is the problem.  The readahead patches in the master branch of
> > git://ceph.newdream.net/git/ceph-client.git.  They're not upstream yet.
> > Sorry that wasn't clear!
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=e9852227431a0ed6ceda064f33e4218757acab6c
> - it's not this patch?

Nope, it's ebd62c49c0a71a9af6b92b4f0cedfd2b1d46c16e, in ceph-client.git.  
Then d0a287e18a81a0314a9aa82b6f54eb7f5ecabd60 bumps up the default rasize
window.

FWIW I saw a big jump in read spead on my cluster (now fully saturates the 
client interface).

sage
