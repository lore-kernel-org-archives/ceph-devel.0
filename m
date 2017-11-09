From: Sage Weil <sage@newdream.net>
Subject: Re: Osd failure detection
Date: Thu, 9 Nov 2017 14:19:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711091418540.21250@piezo.novalocal>
References: <A80E9066-6266-49E2-9BD7-137E8136D6B9@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:33055 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754799AbdKIOTs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Nov 2017 09:19:48 -0500
In-Reply-To: <A80E9066-6266-49E2-9BD7-137E8136D6B9@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei Jin <wjin.cn@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 9 Nov 2017, Wei Jin wrote:
> Hi, List,
> 
> From Luminous release, I noticed following information:
> 
>  "Some OSD failures are now detected almost immediately, whereas previously the heartbeat timeout (which defaults to 20 seconds) had to expire.  This prevents IO from blocking for an extended period for failures where the host remains up but the ceph-osd process is no longer running."
> 
> This is critical and we have no plan to upgrade to Luminous so far.
> Is there any plan to back port it Jewel? Or anybody know the related pr or patches? Maybe I could do it by myself.

No plans.  The original series merged here, 
a033dc6f5b4cef357db6f5951062d680e880ba0e, but there were likely many 
follow-on patches as well that you'll need to find.

sage

