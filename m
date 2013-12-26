From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/2] rbd: tear down watch request if rbd_dev_device_setup()
 fails
Date: Thu, 26 Dec 2013 12:34:36 -0800
Message-ID: <52BC92DC.6010807@inktank.com>
References: <1387224335-902-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:50664 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab3LZUfX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Dec 2013 15:35:23 -0500
Received: by mail-yh0-f52.google.com with SMTP id i7so1837721yha.11
        for <ceph-devel@vger.kernel.org>; Thu, 26 Dec 2013 12:35:20 -0800 (PST)
In-Reply-To: <1387224335-902-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 12/16/2013 12:05 PM, Ilya Dryomov wrote:
> Hello,
>
> Currently, if rbd_dev_device_setup() fails, we don't tear down our
> watch request.  Looks like this bug was introduced by 1f3ef78861ac,
> which moved a tear down call while fixing something else.  Fix it.
>
> These patches can be pulled from wip-rbd-unwatch branch of
> ceph-client.git.
>
> Thanks,
>
>                  Ilya
>
>
> Ilya Dryomov (2):
>    rbd: introduce rbd_dev_header_unwatch_sync() and switch to it
>    rbd: tear down watch request if rbd_dev_device_setup() fails
>
>   drivers/block/rbd.c |   41 ++++++++++++++++++++++++++++-------------
>   1 file changed, 28 insertions(+), 13 deletions(-)
>

These look good to me.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
