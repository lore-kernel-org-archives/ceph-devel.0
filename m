From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: create pool_id device attribute
Date: Thu, 12 Jul 2012 12:35:12 -0500
Message-ID: <4FFF0AD0.6080808@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD875B.3060608@inktank.com> <4FFF03D0.2010604@inktank.com> <4FFF067D.8050603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33596 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932586Ab2GLRfP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 13:35:15 -0400
Received: by yhmm54 with SMTP id m54so2976589yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 10:35:14 -0700 (PDT)
In-Reply-To: <4FFF067D.8050603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/12/2012 12:16 PM, Josh Durgin wrote:
> Looks good.
> 
> I forgot to mention that this should also update the sysfs
> documentation at Documentation/ABI/testing/sysfs-bus-rbd.

Thanks.  I'll do that as a separate patch, but will get it
posted for review later this afternoon and will commit it
to the testing branch along with these changes.

					-Alex
