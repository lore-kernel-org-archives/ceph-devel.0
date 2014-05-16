From: Sage Weil <sage@inktank.com>
Subject: Re: XioMessenger (RDMA) Status Update
Date: Fri, 16 May 2014 11:21:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405161058010.32477@cobra.newdream.net>
References: <624098295.166.1400015293897.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60090 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbaEPSV1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 May 2014 14:21:27 -0400
In-Reply-To: <624098295.166.1400015293897.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>

Hi Matt,

I've rebased this branch on top of master and pushed it to wip-xio in 
ceph.git, and then opened a pull request to capture review:

	https://github.com/ceph/ceph/pull/1819

I would like to get some of the preliminary pieces into master sooner 
rather than later so we can start cutting down on the size of the branch.  
I've started by looking just first few patches that modify the Messenger 
and made a few clean ups:

 - use SimplePolicyMessage for SimpleMessenger, too, to avoid dup code
 - move PipeConnection into a separate header and tweak a few things to 
   remove it from the generic Messenger/Message/Connection interface
 - cleaned up a bit of cruft from the original patch
 - resolved a few merge conflicts between firefly and master

Before I get too far into this can you take a look?  I'd like to pull 
*all* of the non-xio stuff to the top of the branch and get it in good 
shape first.

I think the next step for me is to look at how you've instantiated the 
alternate xio messenger and clean up that interface.  This is probably 
also a good time for us to get the entity_addr_t and entity_name_t stuff 
sorted out.

Thanks!
sage


On Tue, 13 May 2014, Matt W. Benjamin wrote:

> Hi Ceph Devs,
> 
> I've pushed two Ceph+Accelio branches, xio-firefly and xio-firefly-cmake to our
> public ceph repository https://github.com/linuxbox2/linuxbox-ceph.git .
> 
> These branches are pulled up to the HEAD of ceph/firefly, and also have improvements
> to XioMessenger which allow:
> 
> 1. operation of (at least) a minimal Ceph Mon and OSD cluster over Xio messaging alone
> 2. initial support for Accelio in the MDS server and Client/libcephfs (not formally tested)
> 
> There are some new config options:
> 
> (global addr) "rdma local" sets a local rdma interface address
> (global bool) "cluster rdma" selects Accelio for intra-cluster communication
> (global bool) "client rdma" selecs Accelio for libcephfs communications
> 
> These changes haven't been strenuously tested, we'll expect to have additional information
> and likely new, simple rados bench results against this code in the next several days,
> at latest.
> 
> Thanks,
> 
> Matt
> 
> -- 
> Matt Benjamin
> CohortFS, LLC.
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
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
