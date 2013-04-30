From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/5] rbd: eliminate object version tracking
Date: Tue, 30 Apr 2013 11:32:54 -0700
Message-ID: <51800E56.6040904@inktank.com>
References: <517FB909.40309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:50640 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758599Ab3D3Sdt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 14:33:49 -0400
Received: by mail-pb0-f42.google.com with SMTP id up15so391536pbc.1
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 11:33:49 -0700 (PDT)
In-Reply-To: <517FB909.40309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/30/2013 05:28 AM, Alex Elder wrote:
> As of this patch:
>      rbd: set up watch in rbd_dev_image_probe()
> there is no longer any need to keep track of the
> object version for an rbd header object.  Getting
> rid of it allows quite a bit of code to get
> simplified, and the patches after the first in
> this series do just that.
>
> 					-Alex
>
> [PATCH 1/5] rbd: stop tracking header object version
> [PATCH 2/5] rbd: get rid of some version parameters
> [PATCH 3/5] rbd: more version parameter removal
> [PATCH 4/5] rbd: drop rbd_obj_method_sync() version parameter
> [PATCH 5/5] rbd: drop obj_request->version

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

