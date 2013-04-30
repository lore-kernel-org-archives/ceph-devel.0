From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/3] rbd: a few small issues
Date: Tue, 30 Apr 2013 11:32:44 -0700
Message-ID: <51800E4C.10905@inktank.com>
References: <517FB770.1070500@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:59125 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761100Ab3D3Sdk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 14:33:40 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so365551dae.3
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 11:33:39 -0700 (PDT)
In-Reply-To: <517FB770.1070500@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/30/2013 05:22 AM, Alex Elder wrote:
> This series has two patches that fix two annoyances
> and a third that makes snapshot names be treated
> consistently as constant data.
>
> 					-Alex
>
> [PATCH 1/3] rbd: fix up the layering warning message
> [PATCH 2/3] rbd: don't revalidate so much
> [PATCH 3/3] rbd: snap names are pointer to constant data

These all look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

