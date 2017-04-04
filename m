From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: How best to integrate dmClock QoS library into ceph codebase
Date: Tue, 4 Apr 2017 12:00:59 -0400
Message-ID: <20170404160059.GB22266@ultraspiritum.eng.arb.redhat.com>
References: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753759AbdDDQBE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Apr 2017 12:01:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BA7D3DBDF
        for <ceph-devel@vger.kernel.org>; Tue,  4 Apr 2017 16:01:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Eric Ivancich" <ivancich@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 04/04/2017, J. Eric Ivancich wrote:
> An argument for making it a submodule is that ceph already uses submodules and ceph developers are familiar with working with (and around) them.

I think this would be the overriding argument. If both submodules and
subtrees have their own set of drawbacks, it seems like a bad idea for
Ceph as a project to have to deal with /both/ sets of drawbacks
instead of just one.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
