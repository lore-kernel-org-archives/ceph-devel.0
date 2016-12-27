From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Clangs is complaining about type evaluations in test_mempool.cc
Date: Tue, 27 Dec 2016 11:19:15 -0500
Message-ID: <20161227161914.GA19064@ultraspiritum.eng.arb.redhat.com>
References: <a5128b5c-072c-6d86-63db-a54928bb8d9e@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755747AbcL0QVa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Dec 2016 11:21:30 -0500
Content-Disposition: inline
In-Reply-To: <a5128b5c-072c-6d86-63db-a54928bb8d9e@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 27/12/2016, Willem Jan Withagen wrote:
> Perhaps somebody has a suggestion on how to fix this??

I suspect that the container changes in
https://github.com/ceph/ceph/pull/12626 will fix it. The denc container
encodings in master always assume the default compare and allocator
parameters.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
