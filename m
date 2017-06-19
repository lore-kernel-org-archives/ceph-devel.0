From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Caught the first erroneous translated errorcode
Date: Mon, 19 Jun 2017 13:29:17 -0400
Message-ID: <20170619172916.GA27362@ultraspiritum.eng.arb.redhat.com>
References: <34251a6c-a335-fe31-0705-a5fe7af9ae08@digiware.nl>
 <CALe9h7fveb7hek7uoX59P2w7Yx3fCvLf5JL0qURTrhZHzcD7hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbdFSR3T (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Jun 2017 13:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4EF281252
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jun 2017 17:29:18 +0000 (UTC)
Received: from ultraspiritum.eng.arb.redhat.com (unknown [10.17.150.166])
        by smtp.corp.redhat.com (Postfix) with SMTP id 839358208A
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jun 2017 17:29:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALe9h7fveb7hek7uoX59P2w7Yx3fCvLf5JL0qURTrhZHzcD7hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 17/06/2017, John Spray wrote:
> Somewhat related perhaps: people running cephfs on ARM recently had
> this problem, for that case the solution was simply to define in Ceph
> some constants that mirror the linux ones, see commit 88d2da5e9.

We may wish to consider using std::error_code for Ceph's internal
error stuff rather than trying to shoehorn everything into the POSIX +
Whatever Linux Defines error codes. That way we could have a lot more
specificity and preserve the source of the error while still defining
an equivalence (where appropriate) to POSIX-derived error conditions.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
