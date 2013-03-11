From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/7, v2] libceph: abstract message data information
Date: Mon, 11 Mar 2013 12:03:48 -0700
Message-ID: <513E2A94.3090008@inktank.com>
References: <513B5CAF.4010702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:40013 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251Ab3CKTE3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 15:04:29 -0400
Received: by mail-pb0-f54.google.com with SMTP id rr4so4063062pbb.41
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 12:04:28 -0700 (PDT)
In-Reply-To: <513B5CAF.4010702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/09/2013 08:00 AM, Alex Elder wrote:
> Over half of these have been reviewed already, but I'm re-posting
> them because I've rebased them to be on top of the series I just
> posted (that is, these are based on branch "review/wip-cleanup"
> or 60b789f libceph: record byte count not page count), and because
> I've added two more patches since the last time I sent them out.
>
> I won't bother summarizing them again this time, their individual
> descriptions should be good enough.
>
> 					-Alex
>
> The patches below marked with "***" are still in need of review.
>
> [PATCH 1/7] libceph: isolate message page field manipulation
> [PATCH 2/7] libceph: set page info with byte length         ***
> [PATCH 3/7] libceph: isolate other message data fields
> [PATCH 4/7] ceph: only set message data pointers if non-empty
> [PATCH 5/7] libceph: record message data byte length        ***
> [PATCH 6/7] libceph: set response data fields earlier       ***
> [PATCH 7/7] libceph: activate message data assignment checks

These look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

