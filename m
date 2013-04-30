From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: rbd: enforce parent overlap
Date: Tue, 30 Apr 2013 16:20:18 +0300
Message-ID: <20130430132018.GL5123@mwanda>
References: <20130430072410.GA7237@elgon.mountain>
 <517FB19A.9070703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:26725 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760460Ab3D3NUV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 09:20:21 -0400
Content-Disposition: inline
In-Reply-To: <517FB19A.9070703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Apr 30, 2013 at 06:57:14AM -0500, Alex Elder wrote:
> On 04/30/2013 02:24 AM, Dan Carpenter wrote:
> > Hello Alex Elder,
> > 
> > This is a semi-automatic email about new static checker warnings.
> 
> Cool, I've never used smatch before.  Great to get these
> automated warnings.
> 
> I looked at this, and this is not a problem.  An earlier
> commit, about 10 before that one:
>     rbd: always check IMG_DATA flag
> implements a comparable check.  Any rbd object request
> with the IMG_DATA flag set (obj_request_img_data_test()
> returns true) will have a non-null image_request pointer.
> 
> I suppose I should have asserted it was non-null, I do
> that all over the place...

If Smatch knows a variable is never NULL then it ignores
inconsistent NULL checking but it would be better to just remove the
unneeded check.

regards,
dan carpenter

