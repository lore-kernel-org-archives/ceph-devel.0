From: Loic Dachary <loic@dachary.org>
Subject: Re: jewel: bad rados_buffer_free from librados python bindings
Date: Thu, 20 Oct 2016 12:33:59 +0200
Message-ID: <58089D97.2020606@dachary.org>
References: <580881D6.2070603@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:34263 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752837AbcJTKeE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Oct 2016 06:34:04 -0400
In-Reply-To: <580881D6.2070603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

It passed 10 times in a row on the same branch (http://pulpito.ceph.com/loic-2016-10-20_09:32:24-rados-jewel-backports-distro-basic-smithi/). I guess it's a rare transient error and we were unlucky enough to hit it twice in a row.

On 20/10/2016 10:35, Loic Dachary wrote:
> H Sage,
> 
> It looks like http://tracker.ceph.com/issues/15454 surfaced in jewel (failed twice in a row at http://tracker.ceph.com/issues/17487#note-19). It did not occur before, therefore I suspect it's a side effect of some of the commits in the jewel backports integration branch ( http://tracker.ceph.com/issues/17487#note-16 ), but I don't see which commit in that branch could have caused that kind of misbehavior.
> 
> Since you marked http://tracker.ceph.com/issues/15454 as Resolved with no commits attached, I suppose it means it went away for some reason. Could you please confirm ? 
> 
> Cheers
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
