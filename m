From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 09/13] libceph: start tracking connection socket state
Date: Tue, 12 Jun 2012 11:58:34 -0500
Message-ID: <4FD7753A.7060000@inktank.com>
References: <4FC673FC.3060004@inktank.com> <4FC6766B.1090307@inktank.com> <CAAM7YA=4M_NQq03UCiEO=RQ=D3d3LHq1T9fbCkiqBxvv-AQyLA@mail.gmail.com> <Pine.LNX.4.64.1206112158170.10716@cobra.newdream.net> <4FD6CD6A.9040505@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:40038 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab2FLQ6h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 12:58:37 -0400
Received: by vcbf11 with SMTP id f11so2933321vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 12 Jun 2012 09:58:36 -0700 (PDT)
In-Reply-To: <4FD6CD6A.9040505@linux.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@linux.intel.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 06/12/2012 12:02 AM, Yan, Zheng wrote:
> On 06/12/2012 01:00 PM, Sage Weil wrote:
>> Yep.  This was just fixed yesterday, in the testing-next branch, by 
>> 'libceph: transition socket state prior to actual connect'.
>>
>> Are you still hitting the bio null deref?
>>
> No,
> 
> Cheers
> Yan, Zheng

Would you be able to narrow down exactly what fixed the bio null
problem?  Are you able to easily reproduce it?  Are you running
the master branch, or testing, or what?

Thank you.

					-Alex

