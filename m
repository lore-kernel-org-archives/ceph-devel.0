From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: RE: fadvise status
Date: Thu, 4 Dec 2014 08:40:13 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C8F9EA7@SHSMSX101.ccr.corp.intel.com>
References: <6AA21C22F0A5DA478922644AD2EC308C8F9021@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1412022136370.24518@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14886 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbaLDIk0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Dec 2014 03:40:26 -0500
In-Reply-To: <alpine.DEB.2.00.1412022136370.24518@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Thursday, December 4, 2014 2:57 PM
> To: Ma, Jianpeng
> Cc: sjust@redhat.com; ceph-devel@vger.kernel.org
> Subject: fadvise status
> 
> Hey,
> 
> I'm getting caught up after being out most of last week.  I see:
> 
> https://github.com/ceph/ceph/pull/2964
> 
> 	client side librados and librbd changes.  ready to go
> 
> https://github.com/ceph/ceph/pull/2988
> 
> 	osd changes.  look good, but needs a rebase (merge conflict?) and a test.
> I think at this point you should rebase everything into a single branch so that
> you can use the client-side stuff to add some simple functional tests in
> ceph_test_rados_api_[a]io.
Yes,  merge into a single branch(met one conflict) and WIP on test case.
> 
> https://github.com/ceph/ceph/pull/2817
> 
> 	I think this is superceded by the above changes.. can we just close it?
> 
 In my two pull requests don't contain this. I think they are independent. 
If you don't have disagreement on 2817. I think you can merge.

Thanks
Jianpeng

> Thanks!
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
