From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: seastar starting points
Date: Wed, 13 Dec 2017 11:59:12 -0500
Message-ID: <20171213165911.GA7704@ultraspiritum.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752816AbdLMQ7N (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 13 Dec 2017 11:59:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7BD380461
        for <ceph-devel@vger.kernel.org>; Wed, 13 Dec 2017 16:59:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 13/12/2017, Sage Weil wrote:
> Another thought that is somewhat trivial but probably necessary and
> smallish is the log/ framework.  This might be a good test case for
> the legacy <-> seastar communications infrastructure.  It's all
> one-way, which simplifies things a bit, and the implementation
> should be pretty straightforward?

This might be a good opportunity to revisit how we do logging. What we
have right now is pretty heavyweight and does a lot of string
manipulation at runtime we might be better avoiding.

> Another question is how the logger/perfcounters will need to change
> in a seastar world.

We'd basically shard the perfcounters, have one set per core, and
handle queries by having one core send messages to the others asking
for the values and just returning the sum. It sounds more heavy, but
when we ditch the locks and atomics it ends up a lot less burdensome.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@OFTC, Actinic@Freenode
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
