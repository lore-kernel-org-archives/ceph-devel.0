From: Sage Weil <sage@inktank.com>
Subject: Re: libs3 build errors
Date: Fri, 11 May 2012 16:52:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205111652280.17928@cobra.newdream.net>
References: <32649264-9077-48F0-AF8B-B59EACDBD6B1@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52163 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761157Ab2EKXwm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 May 2012 19:52:42 -0400
In-Reply-To: <32649264-9077-48F0-AF8B-B59EACDBD6B1@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Fri, 11 May 2012, Noah Watkins wrote:
> The latest master branch passes ./configure and dpkg-checkbuilddeps tests, but the the build fails:
> 
> Making all in libs3
> make[3]: Entering directory `/home/nwatkins/projects/ceph/ceph/src/libs3'
> make[3]: *** No rule to make target `libxml/parser.h', needed by `build/obj/simplexml.do'.  Stop.
> make[3]: Leaving directory `/home/nwatkins/projects/ceph/ceph/src/libs3'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/home/nwatkins/projects/ceph/ceph/src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/nwatkins/projects/ceph/ceph/src'
> make: *** [all-recursive] Error 1
> 
> Any work around? I'm on Ubuntu 11.04.. the only thing I see in the repositories is a libxml2-dev, but includes <libxml2/parser.h>.

Did you 'git submodule update --init'?

sage


> 
> Thanks,
> - Noah--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
