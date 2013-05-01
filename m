From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 0/4] rbd: get rid of the snapshot list
Date: Tue, 30 Apr 2013 20:16:37 -0500
Message-ID: <51806CF5.2080703@inktank.com>
References: <517FBBF0.9020904@inktank.com> <5180688F.1020703@inktank.com> <51806C07.60007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:37282 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933347Ab3EABQj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 21:16:39 -0400
Received: by mail-ve0-f170.google.com with SMTP id 15so937600vea.15
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 18:16:38 -0700 (PDT)
In-Reply-To: <51806C07.60007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/30/2013 08:12 PM, Alex Elder wrote:
> On that, the only thing inefficient is looking up the
> snapshot id given its name.  It is so inefficient it
> might be worth offering an op that does that for us,
> because as it is we have to do a sequential search
> to find out a snapshot's name.  (Maybe it's not that
> important to track the name for parent snapshots but
> users might be interested.)

Looking at this, I was confused as I wrote it...

For a v2 snapshot, we iterate across snapshot ids in
the context, and fetch the name for each.  Only
when we find the name that matches the one sought
do we know which id it's associated with.

Anyway, once we know the id it's a direct query
for all the other info.

					-Alex
