From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: v0.52 released
Date: Fri, 28 Sep 2012 09:45:50 +0100
Message-ID: <225281A5-AFB6-4A4F-9AA5-F73ACA236298@tchpc.tcd.ie>
References: <sfid-H20120927-210714-+028.22-1@marduk.tchpc.tcd.ie> <alpine.DEB.2.00.1209271306120.13352@cobra.newdream.net>  (sfid-H20120927-210714-+028.22-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:48895 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757233Ab2I1Ipz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Sep 2012 04:45:55 -0400
In-Reply-To: <alpine.DEB.2.00.1209271306120.13352@cobra.newdream.net>  (sfid-H20120927-210714-+028.22-1@marduk.tchpc.tcd.ie)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

On 27 Sep 2012, at 21:07, Sage Weil wrote:

> 
> On the release side, this is also the first release for which we are 
> building RPMs. Hooray! We're starting with just CentOS6/RHEL6 and Fedora 
> 17 on x86_64, but will be adding additional distributions for v0.53, 
> including OpenSUSE and Fedora 18. If there is a particular RPM-based 
> distro that you'd like to see us build packages for, please let us know!
> 
> You can get v0.52 from:
> * Git at git://github.com/ceph/ceph.git
> * Tarball athttp://ceph.com/download/ceph-0.52.tar.gz
> * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
> * For RPMs, see http://ceph.com/docs/master/install/rpm

Scientific Linux 6 is something that we use here at our site, it's binary compatible with RHEL6 and Centos6. Since there is a 'stable' series of releases and a series of 'testing and development' releases would it be better to setup a repo with only stable releases and a testing repo for all development builds (and nighty builds)? It would make it easier for anyone who wants to deploy ceph  in production to just point to a stable repo and not get a development builds. It would be similar to how epel might structure their repos with a stable and a testing repo.

Regards,
Jimmy Tang

--
Senior Software Engineer, Digital Repository of Ireland (DRI)
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/

