From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 2/7] rbd: record mapped size
Date: Fri, 07 Sep 2012 16:52:07 -0500
Message-ID: <504A6C87.3030404@inktank.com>
References: <5049F951.2030706@inktank.com> <5049FA71.1020809@inktank.com> <504A469E.2030203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42174 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2IGVwK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 17:52:10 -0400
Received: by iahk25 with SMTP id k25so41084iah.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 14:52:10 -0700 (PDT)
In-Reply-To: <504A469E.2030203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/07/2012 02:10 PM, Josh Durgin wrote:
> On 09/07/2012 06:45 AM, Alex Elder wrote:
>> Add the size of the mapped image to the set of mapping-specific
>> fields in an rbd_device, and use it when setting the capacity of the
>> disk.
>>
>> Rename the "seq" argument to snap_by_name() to be "snap_id" to be
>> consistent with other usage.
> 
> This doesn't seem to be part of this commit anymore.
> Assuming the commit message is fixed,

I deleted it.	-Alex

> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

. . .



