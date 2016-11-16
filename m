From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Build Warnings: spotting them, and cleaning them up
Date: Wed, 16 Nov 2016 17:29:35 -0500
Message-ID: <20161116222935.GB8507@ultraspiritum.eng.arb.redhat.com>
References: <CAJ4mKGa6ECp6Qdy9jU2fF_NWONKZp=hviTyN68LXvw94J9Fd9w@mail.gmail.com>
 <20161116221018.GA8507@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGbUhfi5SA5UKNN_rZbPZ=eHHLohjzJeiy4qr+0sDg=7Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423025AbcKPWbK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 16 Nov 2016 17:31:10 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 270D53D94D
        for <ceph-devel@vger.kernel.org>; Wed, 16 Nov 2016 22:31:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGbUhfi5SA5UKNN_rZbPZ=eHHLohjzJeiy4qr+0sDg=7Eg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 16/11/2016, Gregory Farnum wrote:
> Is that branch going to merge imminently? If not maybe we could pull
> out this and the BlueStore fixes for fast merging. :)

It is in wip-sage-testing at the moment.

> Is this different from the boost changes you mentioned you already
> have? :)

Yes and no. The boost changes fix everything in external dependencies
I know about. I was just pointing out that we shouldn't have trouble
addressing future problems if they crop up.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
