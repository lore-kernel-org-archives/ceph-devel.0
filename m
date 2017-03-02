From: Sage Weil <sage@newdream.net>
Subject: Re: Document about ceph object class APIs
Date: Thu, 2 Mar 2017 15:27:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703021523380.651@piezo.novalocal>
References: <CY4PR10MB159188A69CC453D4D1337CEBE4280@CY4PR10MB1591.namprd10.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49041 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbdCBPwA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Mar 2017 10:52:00 -0500
In-Reply-To: <CY4PR10MB159188A69CC453D4D1337CEBE4280@CY4PR10MB1591.namprd10.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiye" <Zhiye.Wang@Arcserve.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 2 Mar 2017, Wang, Zhiye wrote:
> Dear all,
> 
> Where can I find document about how to extend ceph?
> 
> The only doc I can see is here:
> http://docs.ceph.com/docs/master/architecture/#extending-ceph
> 
> And some examples in https://github.com/ceph/ceph/tree/master/src/cls
>
> Where can I get document for those APIs? And are those APIs kept stable 
> from release to release?

The example classes are the best documentation currently.  The APIs are 
quite stable, although in principle they could change.  The class plugins 
need to be compiled against a specific build of ceph anyway, so you would 
discover any future change at build time.  The storage calls (reads and 
writes) roughly correspond to the RADOS operations defined in 
include/rados.h (they map to the operations interpreted by do_osd_ops() in 
PrimaryLogPG.cc), and those rados operations maintain compatibility across 
many Ceph releases as they are normally originating from clients 
connecting to the system that could be running other versions.

Hope that helps!
sage
