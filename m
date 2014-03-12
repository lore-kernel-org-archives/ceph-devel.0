From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 0/3] patches for rbd
Date: Wed, 12 Mar 2014 00:28:16 -0500
Message-ID: <531FF070.9000803@ieee.org>
References: <1394598285-17225-1-git-send-email-lucienchao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37165 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbaCLFaC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 01:30:02 -0400
Received: by mail-ig0-f170.google.com with SMTP id uq10so13674790igb.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Mar 2014 22:30:01 -0700 (PDT)
In-Reply-To: <1394598285-17225-1-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <lucienchao@gmail.com>, ceph-devel@vger.kernel.org
Cc: sage@inktank.com

On 03/11/2014 11:24 PM, Guangliang Zhao wrote:
> Hi,
> 
> I am sorry that didn't notice Jean-Tiare's mail at all, just sage's
> reminds me. 
> 
> There are 3 patches, the first is optimization for rbd writing, the
> remaining two are support for rbd discard. If you have completed the 
> discard things, just ignore them.
> 
> Guangliang Zhao (3):
>   rbd: skip the copyup when an entire object writing
>   rbd: extend the operation type
>   rbd: add discard support for rbd
> 
>  drivers/block/rbd.c |  190 +++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 154 insertions(+), 36 deletions(-)
> 

Oh, one more thing.  I reviewed only the code changes presented
here.  I did not go back to walk through the discard call chains
to make sure you're doing things correctly.  I'm just assuming
that, and based on that, I think your changes look overall correct
to me.

					-Alex
