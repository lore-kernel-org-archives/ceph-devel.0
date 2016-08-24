From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Fork and RDMA operations
Date: Wed, 24 Aug 2016 19:21:13 -0400
Message-ID: <20160824232113.GA2092@ultraspiritum.eng.arb.redhat.com>
References: <emc456988a-f658-4bfd-b373-ceec459da0a7@lt-vu-7440>
 <alpine.DEB.2.11.1608121314380.17762@piezo.us.to>
 <CACJqLybXfss4ay5+9WV6Ux1myrkDBiBN2jUSrbVKB44kak-XQg@mail.gmail.com>
 <alpine.DEB.2.11.1608121625320.17762@piezo.us.to>
 <d026edff-3e36-e3e3-42d8-811534638439@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbcHXXWQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 19:22:16 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1101C0B787D
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 23:21:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <d026edff-3e36-e3e3-42d8-811534638439@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 24/08/2016, Casey Bodley wrote:
[snip]
> The next step is to prevent global_init()/common_init()/CephContext from
> doing any work in the parent process (esp. spawning threads for Log,
> CephContextServiceThread, and AdminSocket). Decoupling the config parsing
> from CephContext initialization seems like a natural way to accomplish that.
> So the parent would create and initialize the md_config_t object, then after
> fork, the child would pass that as an argument when creating the
> CephContext.
> 
> How does that sound for a start?

I'm very much in favor of the decoupling idea. If we did that we could
simply not create the CephContext at all until after the fork.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
