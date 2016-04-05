From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] rbd: use GFP_NOIO consistently for request allocations
Date: Tue, 5 Apr 2016 11:50:29 +0200
Message-ID: <20160405115029.7c10cd6b@echidna.suse>
References: <1459847619-27819-1-git-send-email-ddiss@suse.de>
	<CAOi1vP82HraoD5PGcCBdwY-2UJtX0fUsDhU5oyChEPrVKvKF=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52940 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932568AbcDEJub (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Apr 2016 05:50:31 -0400
In-Reply-To: <CAOi1vP82HraoD5PGcCBdwY-2UJtX0fUsDhU5oyChEPrVKvKF=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 5 Apr 2016 11:41:47 +0200, Ilya Dryomov wrote:

> I've got the first two fixed in one of my wip branches but it's tied to
> ceph_osdc_alloc_request() changes.  Given that allocation failures were
> observed, I guess it's worth sending this one to stable right away.
> I'll queue it up, thanks David.

Feel free to add Cc: stable@ tags as you see fit.
Thanks for the feedback Ilya!
