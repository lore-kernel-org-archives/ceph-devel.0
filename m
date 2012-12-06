From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 0/2] fixes for undeletable empty directory
Date: Thu, 06 Dec 2012 23:09:11 +0800
Message-ID: <50C0B517.303@intel.com>
References: <1354608588-25840-1-git-send-email-zheng.z.yan@intel.com> <50BF093F.4060709@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62153 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489Ab2LFPJg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 Dec 2012 10:09:36 -0500
In-Reply-To: <50BF093F.4060709@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <ao@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

On 12/05/2012 04:43 PM, Amon Ott wrote:
> Am 04.12.2012 09:09, schrieb Yan, Zheng:
>> These two patches fix MDS restart issues that may corrupt the fragstat accounting
>> and cause undeletable empty directory. These two patches, together with the patch
>> "mds: fix journaling issue regarding rstat accounting", have passed overnight
>> "fsstress + restart MDS every 120s" test. No undeletable directory was found.
>>
>> These patches are also in:
>>   git://github.com/ukernel/ceph.git wip-mds
> 
> Thank you very much for working on MDS issues, your work gave me some
> hope that our very long standing crashes at MDS failover could be fixed
> soon.
Hi,

Sorry for the delay

> 
> Right now, we have our four node test cluster running with 0.55 and your
> latest patches. Hopefully, today's stress test will work fine.
> 
> One question: with your latest patches, is a multiple MDS setup stable
> in your tests? So far, we only tried with max mds = 1. As our work load
> writes many small files, some load sharing for MDS would be nice to
> have. I would be willing to help with tests and reports, if needed.
> 
No, multiple MDS setup is still unstable.

Regards
Yan, Zheng

> Amon Ott
> 

