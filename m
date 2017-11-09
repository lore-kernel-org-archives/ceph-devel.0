From: David Disseldorp <ddiss@suse.de>
Subject: Re: Osd failure detection
Date: Thu, 9 Nov 2017 12:03:18 +0100
Message-ID: <20171109120318.1946caf2@suse.de>
References: <A80E9066-6266-49E2-9BD7-137E8136D6B9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753183AbdKILDT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Nov 2017 06:03:19 -0500
In-Reply-To: <A80E9066-6266-49E2-9BD7-137E8136D6B9@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei Jin <wjin.cn@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 9 Nov 2017 17:43:04 +0800, Wei Jin wrote:

> Hi, List,
> 
> From Luminous release, I noticed following information:
> 
>  "Some OSD failures are now detected almost immediately, whereas previously the heartbeat timeout (which defaults to 20 seconds) had to expire.  This prevents IO from blocking for an extended period for failures where the host remains up but the ceph-osd process is no longer running."

I assume you're referring to the ECONNREFUSED-fast-fail functionality
added by Piotr Dałek.

> This is critical and we have no plan to upgrade to Luminous so far.
> Is there any plan to back port it Jewel? Or anybody know the related pr or patches? Maybe I could do it by myself.

It was backported to Jewel, alongside a bunch of other async messenger
fixes, and submitted via https://github.com/ceph/ceph/pull/13212 . IIRC,
there's still a small async messenger leak blocking the PR.

Cheers, David
