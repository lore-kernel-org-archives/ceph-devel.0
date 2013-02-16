From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/4] libceph: get rid of some unneeded function parameters
Date: Sat, 16 Feb 2013 15:26:15 -0800
Message-ID: <51201597.6070000@inktank.com>
References: <511FB409.8080007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:50737 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119Ab3BPX0T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 18:26:19 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so2220831pad.11
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 15:26:18 -0800 (PST)
In-Reply-To: <511FB409.8080007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 02/16/2013 08:30 AM, Alex Elder wrote:
> This series eliminates some unneeded parameters from functions
> in the osd client.
>
> 					-Alex
>
> [PATCH 1/4] ceph: kill ceph_osdc_writepages() "nofail" parameter
> [PATCH 2/4] ceph: kill ceph_osdc_writepages() "dosync" parameter
> [PATCH 3/4] ceph: kill ceph_osdc_writepages() "flags" parameter
> [PATCH 4/4] ceph: kill ceph_osdc_new_request() "num_reply"

These all look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

