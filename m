From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 0/2] rbd: clear EXISTS flag for disappearing snapshot
Date: Wed, 01 May 2013 16:40:12 -0500
Message-ID: <51818BBC.70602@inktank.com>
References: <51818945.1040002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:37789 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762032Ab3EAVkP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 17:40:15 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so2454548ieb.27
        for <ceph-devel@vger.kernel.org>; Wed, 01 May 2013 14:40:14 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id d4sm29628313igc.3.2013.05.01.14.40.13
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:40:14 -0700 (PDT)
In-Reply-To: <51818945.1040002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 05/01/2013 04:29 PM, Alex Elder wrote:
> The first patch in this series puts back some functionality
> that was deleted inadvertently by the previous commit.  Josh
> pointed out it had disappeared.  The second one replaces a
> linear search of snapshot ids with a binary search for
> efficiency.
> 
> 					-Alex

These patches are available in the "review/wip-slabs" branch of
the ceph-client git repository.  The patches in these other two
series are there as well:

[PATCH 0/4] rbd: use slab caches for frequently allocated structures
[PATCH 0/3] libceph: use slab caches in messenger and osd osd client

					-Alex

> [PATCH 1/2] rbd: clear EXISTS flag if mapped snapshot disappears
> [PATCH 2/2] rbd: use binary search for snapshot lookup
> 

