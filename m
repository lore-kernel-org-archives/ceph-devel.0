From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST 0/3] rbd: no need for file mapping calculation
Date: Wed, 16 Jan 2013 18:34:54 -0800
Message-ID: <50F7634E.9010204@inktank.com>
References: <50E6EC84.2060304@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:37932 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581Ab3AQCe6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 21:34:58 -0500
Received: by mail-pb0-f47.google.com with SMTP id wz17so1090115pbc.34
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 18:34:57 -0800 (PST)
In-Reply-To: <50E6EC84.2060304@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/04/2013 06:51 AM, Alex Elder wrote:
> Currently every osd request submitted by the rbd code undergoes a
> file mapping operation, which is common with what the ceph file system
> uses.  But some analysis shows that there is no need to do this for
> rbd, because it already takes care of its own blocking of image data
> into distinct objects.  Removing this simplifies things.  I especially
> think removing this improves things conceptually, removing a complex
> mapping operation from the I/O path.
>
> 					-Alex
>
> [PATCH REPOST 1/3] rbd: pull in ceph_calc_raw_layout()
> [PATCH REPOST 2/3] rbd: open code rbd_calc_raw_layout()
> [PATCH REPOST 3/3] rbd: don't bother calculating file mapping

We'll want to use similar methods later for fancier rbd striping with 
format 2 images, but that'll take more restructuring later anyway.
This is fine for now.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
