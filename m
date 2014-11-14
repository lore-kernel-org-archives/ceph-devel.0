From: Joaquim Rocha <joaquim.rocha@cern.ch>
Subject: XAttrs limited to 100 bytes
Date: Fri, 14 Nov 2014 15:24:18 +0100
Message-ID: <54661092.7010804@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:58738 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754728AbaKNOYV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 14 Nov 2014 09:24:21 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi folks,

I found out recently that xattributes are limited to 100 chars in length 
so I saw the commits that introduced this change [1] but I don't 
understand why this is needed if we take into account that by default 
xattributes are going into the omap.

In those changes it also prevents that limit to go over 100 even 
configured that way so I would like to know the reason for this limit 
and if there is any other way we can override it I might be missing.

For my use case I will need a much larger length so I think that there 
should be a way to easily increase the limit (or even have a much larger 
value as the default).

[1] https://github.com/ceph/ceph/pull/2111


Cheers,

--
Joaquim Rocha

