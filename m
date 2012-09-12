From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rbd map error with new rbd format
Date: Wed, 12 Sep 2012 07:28:05 -0700
Message-ID: <50509BF5.1040402@inktank.com>
References: <50508692.3050209@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45652 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758985Ab2ILO2N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 10:28:13 -0400
Received: by pbbrr13 with SMTP id rr13so2348182pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Sep 2012 07:28:13 -0700 (PDT)
In-Reply-To: <50508692.3050209@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

On 09/12/2012 05:56 AM, Martin Mailand wrote:
> Hi,
>
> whilst testing the new rbd layering feature I found a problem with rbd
> map. It seems rbd map doesn't support the new format.

Yeah, format 2 and layering support is in progress for kernel rbd,
but not ready yet. The userspace side is all ready in the master
branch, but it takes more time to implement in the kernel.

Btw, instead of --new-format you should use --format 2. It's in
the man page in the master branch.

Josh

>
> -martin
>
>
> ceph -v
> ceph version 0.51-265-gc7d11cd
> (commit:c7d11cd7b813a47167108c160358f70ec1aab7d6)
>
>
> rbd create --size 100000 --new-format new
> rbd map new
> add failed: (2) No such file or directory
>
>
> rbd create --size 100000 old
> rbd map old
> rbd showmapped
> id      pool    image   snap    device
> 1       rbd     old     -       /dev/rbd1
>
>
> rbd info new
> rbd image 'new':
>          size 100000 MB in 25000 objects
>          order 22 (4096 KB objects)
>          block_name_prefix: rbd_data.101e1a89b511
>          old format: False
>          features: layering
> rbd info old
> rbd image 'old':
>          size 100000 MB in 25000 objects
>          order 22 (4096 KB objects)
>          block_name_prefix: rb.0.1021.23697452
>          old format: True
>          features:

