From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 0/2] rbd: separating mapping info from rbd_device
Date: Mon, 22 Oct 2012 08:07:10 -0500
Message-ID: <508544FE.7060606@inktank.com>
References: <5076E8CF.1060108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41212 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab2JVNHL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 09:07:11 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3496805iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 06:07:11 -0700 (PDT)
In-Reply-To: <5076E8CF.1060108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 10/11/2012 10:42 AM, Alex Elder wrote:
> The rbd device structure has up to now contained information about
> the rbd image (and possibly snapshot id) that backs it as well as
> the device interface it represents in Linux when it is mapped.  In
> order to add layering support we're going to want to separate the
> mapping information from the image information more clearly.  This
> was begun recently but these two patches do the bulk of the movement
> of the rest of the mapping-related fields.
> 
>                     -Alex
> 
> [PATCH 1/2] rbd: move dev_id and list links into mapping
> [PATCH 2/2] rbd: move more stuff into mapping

I'm retracting this series, I no longer think it's quite the
right way to proceed.

					-Alex
