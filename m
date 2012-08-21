From: Alex Elder <elder@inktank.com>
Subject: Fwd: Re: [PATCH 2/4] ceph: tolerate (and warn on) extraneous dentry
 from mds
Date: Tue, 21 Aug 2012 15:02:29 -0500
Message-ID: <5033E955.7030906@inktank.com>
References: <5033E93D.3050802@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60224 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab2HUUCc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Aug 2012 16:02:32 -0400
Received: by yenl14 with SMTP id l14so207650yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Aug 2012 13:02:31 -0700 (PDT)
In-Reply-To: <5033E93D.3050802@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Forgot to copy the list.  Sorry.	-Alex


-------- Original Message --------
Subject: Re: [PATCH 2/4] ceph: tolerate (and warn on) extraneous dentry
from mds
Date: Tue, 21 Aug 2012 15:02:05 -0500
From: Alex Elder <elder@inktank.com>
To: Sage Weil <sage@inktank.com>

On 08/21/2012 02:19 PM, Sage Weil wrote:
> If the MDS gives us a dentry and we weren't prepared to handle it,
> WARN_ON_ONCE instead of crashing.
> 
> Reported-by: Yan, Zheng <zheng.z.yan@intel.com>
> Signed-off-by: Sage Weil <sage@inktank.com>

The fix looks good to me, but I confess I did not follow the
calling paths through well enough to know when we might see
a null d_locked_dir.

Reviewed-by: Alex Elder <elder@inktank.com>

. . .



