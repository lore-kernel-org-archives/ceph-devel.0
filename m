From: Sage Weil <sage@inktank.com>
Subject: Re: v0.52 released
Date: Fri, 28 Sep 2012 08:16:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209280813401.10331@cobra.newdream.net>
References: <sfid-H20120927-210714-+028.22-1@marduk.tchpc.tcd.ie> <alpine.DEB.2.00.1209271306120.13352@cobra.newdream.net> (sfid-H20120927-210714-+028.22-1@marduk.tchpc.tcd.ie) <225281A5-AFB6-4A4F-9AA5-F73ACA236298@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49851 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758416Ab2I1PQB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Sep 2012 11:16:01 -0400
In-Reply-To: <225281A5-AFB6-4A4F-9AA5-F73ACA236298@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: ceph-devel@vger.kernel.org

Hi,

On Fri, 28 Sep 2012, Jimmy Tang wrote:
> Hi Sage,
> 
> On 27 Sep 2012, at 21:07, Sage Weil wrote:
> 
> > 
> > On the release side, this is also the first release for which we are 
> > building RPMs. Hooray! We're starting with just CentOS6/RHEL6 and Fedora 
> > 17 on x86_64, but will be adding additional distributions for v0.53, 
> > including OpenSUSE and Fedora 18. If there is a particular RPM-based 
> > distro that you'd like to see us build packages for, please let us know!
> > 
> > You can get v0.52 from:
> > * Git at git://github.com/ceph/ceph.git
> > * Tarball athttp://ceph.com/download/ceph-0.52.tar.gz
> > * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
> > * For RPMs, see http://ceph.com/docs/master/install/rpm
> 
> Scientific Linux 6 is something that we use here at our site, it's binary compatible with RHEL6 and Centos6. Since there is a 'stable' series of releases and a series of 'testing and development' releases would it be better to setup a repo with only stable releases and a testing repo for all development builds (and nighty builds)? It would make it easier for anyone who wants to deploy ceph  in production to just point to a stable repo and not get a development builds. It would be similar to how epel might structure their repos with a stable and a testing repo.

Ah, good point.  You can do that today with the debian repos, but we 
lumped all the rpms into ceph.com/rpms.  Currently

debian			symlink to debian-argonaut (latest stable)
debian-argonaut		stable argonaut releases
debian-testing		dev releases

We can do the same with the rpms...

rpm
rpm-argonaut
rpm-testing

?
sage


> Regards,
> Jimmy Tang
> 
> --
> Senior Software Engineer, Digital Repository of Ireland (DRI)
> Trinity Centre for High Performance Computing,
> Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
> http://www.tchpc.tcd.ie/
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
