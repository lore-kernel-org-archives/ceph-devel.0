From: Sage Weil <sage@inktank.com>
Subject: Re: Need CRYPTO_CXXFLAGS with latest master?
Date: Sat, 3 Nov 2012 12:14:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1211031213350.25450@cobra.newdream.net>
References: <CAPrxi59wW8EgQerDbY4E=i7RYMQy-Tb24AaSeEXJZhVehX0=1w@mail.gmail.com> <CAPrxi59u69dhunXv1PcwTeQJBvNKZ1X2JSYcsVr-sULFJ3ZzAA@mail.gmail.com> <591CE14B-3A97-41C0-B04A-01EBE0CEE3D4@inktank.com> <CAPrxi5_MTtcNnKd13YtzFCAgapi1s=f=wBA7u1G-_8a=Eii=rg@mail.gmail.com>
 <18BB8BEE-0A64-42CB-9E6F-06941D9AC04A@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35672 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab2KCTOf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 15:14:35 -0400
In-Reply-To: <18BB8BEE-0A64-42CB-9E6F-06941D9AC04A@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gary Lowell <gary.lowell@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 2 Nov 2012, Gary Lowell wrote:
> Digging a little bit deeper, there is actually a comment in 
> common/ceph_crypto.h that when using libnss you need the CRYPTO_CXFLAGS.  
> Since the pk11 headers are installed, I'm not sure there is problem we 
> could detect.

Let's add the flags to all of our builds.  Is it possible to include them 
in AM_CXXFLAGS or something insetad of adding it to every target's 
CXXFLAGS?

sage

> This may be related to dmick's question about include paths.  Someone 
> who knows more history will have to answer that.
> 
> Cheers,
> Gary
> 
> 
> 
> On Nov 2, 2012, at 7:21 PM, Noah Watkins wrote:
> 
> > On Fri, Nov 2, 2012 at 6:04 PM, Gary Lowell <gary.lowell@inktank.com> wrote:
> >> Looks like the complaints come from a small number of newish programs that are compiled only when the --with-debug flag is given.  When building against cryptpp (--with-cryptpp) the pk11 headers are found implicitly and  when building agains libnss (--with-nss) they are not.
> >> 
> >> So we probably need the changes in your wip-make-crypto-flags branch.
> > 
> > Ahh that makes sense. Now I can reproduce it. The branch is up at
> > wip-crypto-flags. Seems like we should have ./configure blow up too if
> > it can't find this stuff?
> > 
> > - Noah
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
