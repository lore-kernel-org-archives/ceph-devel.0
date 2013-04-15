From: Dan Mick <dan.mick@inktank.com>
Subject: Re: skip / disable journal
Date: Mon, 15 Apr 2013 15:48:57 -0700
Message-ID: <516C83D9.4030002@inktank.com>
References: <516C61EA.60507@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:53506 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab3DOWtA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 18:49:00 -0400
Received: by mail-pb0-f52.google.com with SMTP id mc8so2759990pbc.39
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 15:49:00 -0700 (PDT)
In-Reply-To: <516C61EA.60507@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 04/15/2013 01:24 PM, Stefan Priebe wrote:

> is there a possibility to disable / skip the jornal? Stuff like
> FlashCache, BCache and others seem to work much better but sequential
> I/O becomes a bottleneck if the ceph journal is on a single ssd.

As far as I know, the journal is a required element for consistency. 
Sequential I/O is a benefit of the journal.
