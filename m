From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/4] rbd: handle images flattened while mapped
Date: Sat, 11 May 2013 14:09:44 -0700
Message-ID: <518EB398.7090409@inktank.com>
References: <518E83D3.4050709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:64373 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab3EKVJe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 17:09:34 -0400
Received: by mail-ie0-f180.google.com with SMTP id ar20so10289112iec.11
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 14:09:34 -0700 (PDT)
In-Reply-To: <518E83D3.4050709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/11/2013 10:45 AM, Alex Elder wrote:
> This series detects when a mapped clone image gets flattened,
> and if any requests were in flight when that occurs, causes
> them to get resubmitted.
>
> 					-Alex
>
> [PATCH 1/4] rbd: detect when clone image is flattened
> [PATCH 2/4] rbd: re-submit read request for flattened clone
> [PATCH 3/4] rbd: re-submit write request for flattened clone
> [PATCH 4/4] rbd: re-submit flattened write request (part 2)

These all look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

