From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: final mon issues
Date: Fri, 26 Apr 2013 15:13:57 -0500
Message-ID: <517AE005.2030608@inktank.com>
References: <alpine.DEB.2.00.1304261240460.13630@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:61889 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014Ab3DZUNy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 16:13:54 -0400
Received: by mail-ia0-f179.google.com with SMTP id p22so4036452iad.10
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 13:13:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1304261240460.13630@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: greg@inktank.com, ceph-devel@vger.kernel.org, mike.dawson@scholarstack.com

On 04/26/2013 02:43 PM, Sage Weil wrote:
> I've merged the double-forward fix.  I still have one remaining problem
> that I can reproduce with my tests which looks like an overlap of mon
> overload forwarded message priorities; I'm testing two possible fixes to
> see which are necessary to resolve it.
>
> The memory issues with people using the gitbuilder appear to be because
> our gitbuilders weren't linking in tcmalloc.  The latest 'next' build
> *does* link it now, so if you are one of those people, please re-test!
>
> I don't think either of those problems is related to the sync issues Mike
> is seeing, though.  I believe that is the final outstanding issue...?
>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

fwiw, I'm seeing consistently lower mon usage now.  1-2GB instead of 
5-14GB during performance tests.

Mark
