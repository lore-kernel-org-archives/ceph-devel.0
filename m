From: Sage Weil <sage@newdream.net>
Subject: Re: c++ build flags, clang++, -Wnomismatched-tags?
Date: Wed, 20 Jan 2016 17:57:17 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601201756390.18145@cpach.fuggernut.com>
References: <1295550971.21353553.1453329599755.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48387 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbcATW5K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jan 2016 17:57:10 -0500
In-Reply-To: <1295550971.21353553.1453329599755.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 20 Jan 2016, Matt Benjamin wrote:
> Hi Ceph C++ devs,
> 
> I notice building with clang lots of warnings like:
> 
>       'SequencerPosition' defined as a struct here but previously declared as a
>       class [-Wmismatched-tags]
> struct SequencerPosition {
> ^
> /home/mbenjamin/dev/rgw/ceph-upstream/src/os/ObjectMap.h:24:1: note: did you
>       mean struct here?
> class SequencerPosition;
> ^~~~~
> struct
> 3 warnings generated.
> 
> induced by -Wmismatched-tags, which apparently clang++ has by default.  As a ISO C++ developer, I don't think of "struct" as a token that can be mismatched with "class" in friend or forward declaration, but clearly the authors of this warning do.
> 
> I think my intuition would be to disable this warning.  What do others 
> think?

No arguments from me, although I wouldn't object to someone who wants to 
clean up the mismatches either.

sage
