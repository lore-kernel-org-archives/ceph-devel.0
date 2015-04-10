From: Sage Weil <sage@newdream.net>
Subject: Re: loadable objectstore
Date: Fri, 10 Apr 2015 15:46:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504101545120.4469@cobra.newdream.net>
References: <1395275405.143.1428703419864.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54616 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbbDJWqD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Apr 2015 18:46:03 -0400
In-Reply-To: <1395275405.143.1428703419864.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: Varada.Kari@sandisk.com, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 10 Apr 2015, Matt W. Benjamin wrote:
> Hi Varada,
> 
> I pushed branch hammer-osfactory to https://github.com/linuxbox2/ceph.git
> 
> It can at least provide a starting point for discussion, if not a jumping off
> point;  I do think it's basically what Sage described.

I made a few comments on the pull request.  I think a factory class is the 
way to go, but we should be able to make the plugin loading part generic 
and not interface specific at all...

sage

> 
> I was able to update the CMake build system to build the tree, I haven't
> attempted Autotools. :(
> 
> Regards,
> 
> Matt
> 
> -- 
> Matt Benjamin
> CohortFS, LLC.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
> 
> http://cohortfs.com
> 
> tel.  734-761-4689 
> fax.  734-769-8938 
> cel.  734-216-5309 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
