From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] O_DIRECT on deep-scrub read
Date: Wed, 7 Oct 2015 07:50:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510070748580.8667@cobra.newdream.net>
References: <56150598.1080604@sadziu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39853 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbJGOu0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Oct 2015 10:50:26 -0400
In-Reply-To: <56150598.1080604@sadziu.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Pawe=B3_Sadowski?= <ceph@sadziu.pl>
Cc: ceph-users <ceph-users@ceph.com>, ceph-devel@vger.kernel.org

It's not, but it would not be ahrd to do this.  There are fadvise-style 
hints being passed down that could trigger O_DIRECT reads in this case.  
That may not be the best choice, though--it won't use data that happens 
to be in cache and it'll also throw it out..

On Wed, 7 Oct 2015, Pawe? Sadowski wrote:

> Hi,
> 
> Can anyone tell if deep scrub is done using O_DIRECT flag or not? I'm
> not able to verify that in source code.
> 
> If not would it be possible to add such feature (maybe config option) to
> help keeping Linux page cache in better shape?
> 
> Thanks,
> 
> -- 
> PS
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
