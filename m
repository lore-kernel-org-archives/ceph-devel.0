From: Sage Weil <sage@newdream.net>
Subject: Re: rpmbuild version
Date: Mon, 30 Mar 2015 16:05:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503301604530.31431@cobra.newdream.net>
References: <BC97738F8E7C8742BABED7F06FB9DF9166411E6C@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34501 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbbC3XFv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Mar 2015 19:05:51 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9166411E6C@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 28 Mar 2015, Deneau, Tom wrote:
> Starting from a ceph git checkout I want to create a source tar.bz2 to feed to rpmbuild.
> I see there is a "make dist-bzip2" to make the actual source tar but if I want
> the built binaries to identify themselves as a custom version, what is the best way to do that?

You might take a look at 

	https://github.com/ceph/ceph-build/blob/master/build_rpms.sh

This what the gitbuilders are running at

	http://ceph.com/gitbuilder.cgi

for our test builds (for qa mostly).

sage

