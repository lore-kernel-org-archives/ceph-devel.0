From: Sage Weil <sage@newdream.net>
Subject: Re: Fedora 21 packages
Date: Sat, 28 Mar 2015 10:36:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503281034470.18934@cobra.newdream.net>
References: <CAMWPydSzi4E8YmwL+-0PFbnNTFvEJ3duVFigfmnrTWzwFQY9QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47442 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbbC1Rga (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Mar 2015 13:36:30 -0400
In-Reply-To: <CAMWPydSzi4E8YmwL+-0PFbnNTFvEJ3duVFigfmnrTWzwFQY9QQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 28 Mar 2015, Mustafa Muhammad wrote:
> Hi,
> I am trying to install ceph on Fedora 21, but I can't find the
> packages, is there any?
> If not, can you please provide packages? I think they are more
> important than Fedora 20 packages since F21 has more support time
> remaining.

We don't have f21 packages yet; knee deep in other release issues.

We are always looking for people interested in maintaining the upstream CI 
and build/release environment, though; it's a surprising amount of work 
keeping it all running!  There are other distros and architectures we're 
missing too (e.g. we have armv7l hardware but no time to resurrect the 
builds) for lack to time.

sage
