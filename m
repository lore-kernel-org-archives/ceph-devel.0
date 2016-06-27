From: Samuel Just <sjust@redhat.com>
Subject: Re: libradosstriper
Date: Mon, 27 Jun 2016 15:25:29 -0700
Message-ID: <CAN=+7FVmmgAuVF6cjwvGdyAU4YEXr8jLX-qiNjH50w6_YMs02g@mail.gmail.com>
References: <alpine.DEB.2.11.1606272216370.7088@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35313 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbcF0WZb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 18:25:31 -0400
Received: by mail-qk0-f179.google.com with SMTP id a125so31402156qkc.2
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 15:25:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606272216370.7088@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: sebastien.ponce@cern.ch, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The something like ceph_test_rados could then be wired into
ceph-qa-suite to be tested with osd thrashing to ensure that ordering
works and continues to work as expected.
-Sam

On Mon, Jun 27, 2016 at 3:18 PM, Sage Weil <sweil@redhat.com> wrote:
> Hi Sebastien,
>
> Do you mind updating us on the current status of libradosstriper?  Where
> does it stand feature-wise with what you need, how are you currently using
> it or how do you plan to use it, and what is still missing?
>
> Also, one thing we really want to see is test coverage for the code so
> that we can comfortably point users toward it.  This ideally would look
> something like the ceph_test_rados_api_* tests that verify individual
> operations behave as expected, and/or something like ceph_test_rados that
> throws random operations at is and verifies it returns correct results
> that match its in-memory model.
>
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
