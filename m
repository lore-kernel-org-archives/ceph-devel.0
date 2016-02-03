From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: CephFS and the next hammer release v0.94.6
Date: Wed, 3 Feb 2016 10:39:38 +0100
Message-ID: <56B1CADA.3090100@suse.cz>
References: <56B18773.6000304@dachary.org>
 <CAJ4mKGYBc5O312mGDYzfxYR3uwyVGBu0vgQr-0ofz60vtLLOyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45834 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbcBCJjk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Feb 2016 04:39:40 -0500
In-Reply-To: <CAJ4mKGYBc5O312mGDYzfxYR3uwyVGBu0vgQr-0ofz60vtLLOyw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> . . . and the fsx one
> is http://tracker.ceph.com/issues/14384. I'd get that quick backport
> in as well (it's just a change to the qa script to point at a working
> version of the repo).

Backport staged:

http://tracker.ceph.com/issues/14624
https://github.com/ceph/ceph/pull/7501

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
