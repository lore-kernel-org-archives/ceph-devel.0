From: Tommi Virtanen <tv@inktank.com>
Subject: Re: ceph osd create
Date: Wed, 1 Aug 2012 16:43:51 -0700
Message-ID: <CADvuQRGCpKP+ePn4phE_WbvG0nYubKhL_oa3CaqO5D4AuU-5+g@mail.gmail.com>
References: <CA+jddaMGhVvOReO854qbQM=j2X3rhM2FtbwLu4DOpYLkr5UW_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37078 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab2HAXoN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 19:44:13 -0400
Received: by vcbfk26 with SMTP id fk26so7654212vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Aug 2012 16:44:12 -0700 (PDT)
In-Reply-To: <CA+jddaMGhVvOReO854qbQM=j2X3rhM2FtbwLu4DOpYLkr5UW_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 1, 2012 at 4:27 PM, Mandell Degerness
<mandell@pistoncloud.com> wrote:
> As of this time, we are allocating OSD numbers based on servers.  The
> "ceph osd create" command seems like it may be useful, but is not
> documented nearly well enough yet. Can someone please provide answers
> to the following:
>
> 1. Is this guaranteed to always produce an OSD number that is unique,
> with no worries about race conditions?

Yes.

You can also use "ceph osd create UUID", so it's safe to run multiple
times, get the same result for the same UUID, and not waste numbers.

> 2. Does this eliminate the need to worry about the value of max_osd?

It increases max_osd as necessary.
https://github.com/ceph/ceph/blob/master/src/mon/OSDMonitor.cc#L2167

> 3. Are there any other side effects of running the command?

Nope.


You may be interested in digging into the mechanics of the new chef
deployment stuff, and "osd hotplugging" as I call it. It completely
automates osd id allocation.

http://ceph.com/docs/master/install/chef/
http://ceph.com/docs/master/config-cluster/chef/

More architectural docs don't really exist yet, sorry.
