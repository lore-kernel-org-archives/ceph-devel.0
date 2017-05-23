From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Haven't been paying attention: Gperf missing
Date: Tue, 23 May 2017 00:18:51 -0400
Message-ID: <20170523041850.GA28714@ultraspiritum.eng.arb.redhat.com>
References: <9cc2b255-f617-e109-b9b9-23a32ea8509f@digiware.nl>
 <CAF-wwdFP4Wy-4Bx+wkW=btjCQokTW3QaLSaVudJJyBM=2XmaLA@mail.gmail.com>
 <9c1c2403-c114-bec9-d37b-e217d2d23e69@digiware.nl>
 <CAF-wwdFRzGxAdtXAAoieUYADZ7YQrf8u9Zkwqxs2FCk+bgwaSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750885AbdEWESy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 May 2017 00:18:54 -0400
Content-Disposition: inline
In-Reply-To: <CAF-wwdFRzGxAdtXAAoieUYADZ7YQrf8u9Zkwqxs2FCk+bgwaSQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>, Kefu Chai <kchai@redhat.com>

On 23/05/2017, Brad Hubbard wrote:
> I had to install gperf myself when this change came in (which wasn't
> an issue for me).
> 
> Kefu may have further input.

It's only needed if you're building RGW, at least for the moment. I use
it as part of the S3 Bucket Policy support. (Someone else might use it
for something else later.)

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
