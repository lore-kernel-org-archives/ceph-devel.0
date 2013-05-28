From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 0/30] mds: lookup-by-ino & fixes
Date: Tue, 28 May 2013 11:03:17 +0800
Message-ID: <51A41E75.8000801@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1305231118510.32642@cobra.newdream.net> <519F286B.2@intel.com> <alpine.DEB.2.00.1305271219350.1350@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14703 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758698Ab3E1DDT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 May 2013 23:03:19 -0400
In-Reply-To: <alpine.DEB.2.00.1305271219350.1350@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com, sam.lang@inktank.com

On 05/28/2013 03:21 AM, Sage Weil wrote:
> On Fri, 24 May 2013, Yan, Zheng wrote:
>> On 05/24/2013 02:22 AM, Sage Weil wrote:
>>> On Thu, 23 May 2013, Yan, Zheng wrote:
>>>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>>>
>>>> Patch 1~21 are random fixes for MDS cluster. Patch 22~28 rework
>>>> the backtrace handling. Patch 29 introduces lookup-by-ino helper.
>>>> Path 30 uses the lookup-by-ino helper to fix issue #4850.
>>>>
>>>> This patch series are also in:
>>>>   git://github.com/ukernel/ceph.git wip-mds
>>>
>>> Awesome!  I pushed this to wip-mds in ceph.git for now.  Note that 
>>> gitbuilders are picking up a failure due to the encoding changes.  For the 
>>> types and messages that change, can you mark them in the 
>>> ceph-object-corpus.git tree?  Look for the forward_incompat/ dirs and 
>>> follow that example.
>>>
>> Could you be more specific. Change in patch 14 should only affect MExportDir
>> and MExportCaps, object-corpus does not contain objects for these two messages.
>> Patch 27 looks suspicious, does the incompatible change you mentioned cause the
>> failure?
> 
> http://gitbuilder.sepia.ceph.com/gitbuilder-oneiric-amd64/log.cgi?log=f8499e07035fbff063b50b13ac295432884c7e27
> 
> is the one I saw, but there are likely others; run 'make check-local' to 
> run the encoding checks.
> 

It turned out to be a bug in path "mds: journal backtrace update in EMetaBlob::fullbit"
I forgot to initialize 'state' when decoding old format.

Regards
Yan, Zheng
