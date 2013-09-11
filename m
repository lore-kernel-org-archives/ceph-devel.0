From: Sage Weil <sage@inktank.com>
Subject: Re: Jerasure 1.2A plugin for Ceph
Date: Wed, 11 Sep 2013 09:29:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309110927280.23522@cobra.newdream.net>
References: <522055BE.2040200@dachary.org> <CFA250A5-F536-4C28-AC69-10C7F2B6DD39@cs.utk.edu> <52308EDD.5020100@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42229 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053Ab3IKQ3o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Sep 2013 12:29:44 -0400
In-Reply-To: <52308EDD.5020100@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: James Plank <plank@cs.utk.edu>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 11 Sep 2013, Loic Dachary wrote:
> [cc'ing the devel mailing list]
> 
> Hi James,
> 
> Thanks for the positive feedback :-) I found the API fairly 
> straightforward and I don't see what could be improved. However, I've 
> learnt about erasure code and designed the Ceph plugin abstract API 
> mostly by studying jerasure. I'm probably biased : let hear what others 
> have to suggest.
> 
> Cheers
> 
> On 11/09/2013 17:04, James Plank wrote:
> > Hi Loic -- I took a scan, and it looks like a nice usage of the 
> > library.  Here's a question -- for the next revision of jerasure, are 
> > there any functionalities that you would like to see, that would make 
> > your life as a developer easier?  Thanks!  Jim ----------

Hi James-

Late to this discussion, and this may have already been covered, but: 
there is a bunch of Intel-optimized code floating around for various 
erasure codes.  I would love to see this incorporated into jerasure (with 
automatic arch and CPU feature detection) so that users can transparently 
take advantage of it.

sage


> > 
> > On Aug 30, 2013, at 4:20 AM, Loic Dachary wrote:
> > 
> >> Hi James,
> >>
> >> The first version of the jerasure 1.2A plugin for Ceph is complete at
> >>
> >> https://github.com/ceph/ceph/pull/538#commits-pushed-763275e
> >>
> >> This commit introduces the main part:
> >> ErasureCodeJerasure: base class for jerasure ErasureCodeInterface
> >> https://github.com/dachary/ceph/commit/76d2842358465e560a4929d60131762f8c93804f
> >>
> >> and each technique is derived from it in six successive commits, starting from here
> >> ErasureCodeJerasure: define technique ReedSolomonVandermonde
> >>
> >> It would be great if you could take a look and let us know if you see anything odd.
> >>
> >> Cheers
> >>
> >> -- 
> >> Lo?c Dachary, Artisan Logiciel Libre
> >> All that is necessary for the triumph of evil is that good people do nothing.
> >>
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do nothing.
> 
> 
