From: Alex Elder <elder@inktank.com>
Subject: Re: rbd: enforce parent overlap
Date: Tue, 30 Apr 2013 06:57:14 -0500
Message-ID: <517FB19A.9070703@inktank.com>
References: <20130430072410.GA7237@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:44299 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759488Ab3D3L5Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 07:57:16 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so363357iar.16
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 04:57:15 -0700 (PDT)
In-Reply-To: <20130430072410.GA7237@elgon.mountain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/30/2013 02:24 AM, Dan Carpenter wrote:
> Hello Alex Elder,
> 
> This is a semi-automatic email about new static checker warnings.

Cool, I've never used smatch before.  Great to get these
automated warnings.

I looked at this, and this is not a problem.  An earlier
commit, about 10 before that one:
    rbd: always check IMG_DATA flag
implements a comparable check.  Any rbd object request
with the IMG_DATA flag set (obj_request_img_data_test()
returns true) will have a non-null image_request pointer.

I suppose I should have asserted it was non-null, I do
that all over the place...

					-Alex

> The patch 64548e0638af: "rbd: enforce parent overlap" from Apr 21,
> 2013, leads to the following Smatch complaint:
> 
> drivers/block/rbd.c:1449 rbd_osd_read_callback()
> 	 error: we previously assumed 'img_request' could be null (see line 1448)
> 
> drivers/block/rbd.c
>   1447			img_request = obj_request->img_request;
>   1448			layered = img_request && img_request_layered_test(img_request);
>                                   ^^^^^^^^^^^
> Old check.
>   1449			rbd_dev = img_request->rbd_dev;
>                                   ^^^^^^^^^^^^^^^^^^^^
> New dereference.
> 
>   1450		}
>   1451	
> 
> regards,
> dan carpenter
> 

