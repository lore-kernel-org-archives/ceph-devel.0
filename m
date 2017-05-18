From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: What should we do if ceph feature bit is all used?
Date: Thu, 18 May 2017 11:50:50 -0400
Message-ID: <20170518155050.GC31766@ultraspiritum.eng.arb.redhat.com>
References: <CALZt5jyPyb8d0maz06LTguhC=++tzdKKY7fJ6DQHLkOS5amzDw@mail.gmail.com>
 <alpine.DEB.2.11.1705181338010.4016@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33281 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934310AbdERPuv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 18 May 2017 11:50:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F23A7804F8
        for <ceph-devel@vger.kernel.org>; Thu, 18 May 2017 15:50:50 +0000 (UTC)
Received: from ultraspiritum.eng.arb.redhat.com (unknown [10.17.150.166])
        by smtp.corp.redhat.com (Postfix) with SMTP id B88FC183B3
        for <ceph-devel@vger.kernel.org>; Thu, 18 May 2017 15:50:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1705181338010.4016@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 18/05/2017, Sage Weil wrote:
> We are recycling feature bits.  If you look at ceph_features.h in
> master, there are macros that make it explicit when a feature is
> deprecated and when it can be resused.  Once luminous is out we'll
> have another 10+ bits available.
>
> Right now the only ones we can't reuse are the ones that affect
> client behavior; those we have to be more careful deprecating in
> order to preserve support for old clients.

We could always use one of the feature bits to tell if we support a
/second/ collection of feature bits that is a length-marked bitset.

(Only half-way joking.)

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
