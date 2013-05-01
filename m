From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/4] rbd: get rid of the snapshot list
Date: Tue, 30 Apr 2013 18:32:41 -0700
Message-ID: <518070B9.3060601@inktank.com>
References: <517FBBF0.9020904@inktank.com> <5180688F.1020703@inktank.com> <51806C07.60007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:44138 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932725Ab3EABdh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 21:33:37 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so610977pde.4
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 18:33:37 -0700 (PDT)
In-Reply-To: <51806C07.60007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/30/2013 06:12 PM, Alex Elder wrote:
> On that, the only thing inefficient is looking up the
> snapshot id given its name.  It is so inefficient it
> might be worth offering an op that does that for us,
> because as it is we have to do a sequential search
> to find out a snapshot's name.  (Maybe it's not that
> important to track the name for parent snapshots but
> users might be interested.)

That would be more efficient, but I don't think it's worth going that
far. The client would need a way to work with current osds too, and
it's not that much data - it's mainly the extra latency from fetching
it that would be the problem. Iterating over 1000 snapshot names in
memory is much faster, and only done when mapping for the kernel.

Userspace fetches all the snapshot metadata in one operation, and
indexes it by name in memory (which is useful since all the librbd
calls relating to snapshots deal with names).
