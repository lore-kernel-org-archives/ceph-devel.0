From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 13:06:17 -0400
Message-ID: <20170614170617.GA6164@ultraspiritum.eng.arb.redhat.com>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
 <CA+H5UW2k7ZEJVYJXE4aGvbNkjBsN3mVaDiNpRY585CvyGpOdeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751904AbdFNRGS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 13:06:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DE764E4C3
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 17:06:18 +0000 (UTC)
Received: from ultraspiritum.eng.arb.redhat.com (unknown [10.17.150.166])
        by smtp.corp.redhat.com (Postfix) with SMTP id 24DB38E516
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 17:06:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CA+H5UW2k7ZEJVYJXE4aGvbNkjBsN3mVaDiNpRY585CvyGpOdeA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 14/06/2017, Radoslaw Zarzynski wrote:
> Thanks for the info, Willem. I'm on it.
> 
> BTW: it would be nice to have a Clang builder to find out similar
> issues as early as possible.

Oh yes, please Infrastructure Gods.

Though I admit the more builders we add the slower Jenkins is. Are there
any older systems or variants we could prune out?

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
