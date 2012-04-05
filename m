From: Wido den Hollander <wido@widodh.nl>
Subject: Re: cephx auth
Date: Thu, 05 Apr 2012 10:00:32 +0200
Message-ID: <4F7D5120.80702@widodh.nl>
References: <Pine.LNX.4.64.1204042317560.28065@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:50536 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab2DEIAe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 04:00:34 -0400
In-Reply-To: <Pine.LNX.4.64.1204042317560.28065@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 04/05/2012 08:18 AM, Sage Weil wrote:
> Should we make cephx auth the default?  Currently it is still 'none', but
> this code is 2 years old now and I haven't seen an auth-related bug in at
> least half a year.

I'd say yes. I haven't seen any cephx related issues either.

I don't see any reason to stick with 'none'.

Wido

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

