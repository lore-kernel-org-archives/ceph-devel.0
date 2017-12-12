From: Dan Mick <dmick@redhat.com>
Subject: Re: better doc (and build) validation
Date: Mon, 11 Dec 2017 20:08:59 -0800
Message-ID: <837d39fb-0cf1-a51f-18e9-2555f747ef13@redhat.com>
References: <CAC-Np1xfCMOD6fCeSvDZ9Wo1dGvtL816oicvBs94YarMNNcZAA@mail.gmail.com>
 <CAJ4mKGaRMb3BZ4hF5smid5u9-UwsBgirdqG9uu3HMvvieW_6zw@mail.gmail.com>
 <CAC-Np1x9R9F5Y=X-HafVmQfzgCe67A6YmJ6GdCrdGHY62KZ4_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751379AbdLLEI7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 11 Dec 2017 23:08:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 756A37F7A2
        for <ceph-devel@vger.kernel.org>; Tue, 12 Dec 2017 04:08:59 +0000 (UTC)
In-Reply-To: <CAC-Np1x9R9F5Y=X-HafVmQfzgCe67A6YmJ6GdCrdGHY62KZ4_w@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 12/05/2017 12:27 PM, Alfredo Deza wrote:
> On Tue, Dec 5, 2017 at 12:44 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> On Tue, Dec 5, 2017 at 5:31 AM, Alfredo Deza <adeza@redhat.com> wrote:
>>> It seems like we keep hitting catastrophic build errors with minor doc
>>> changes. The last one was introduced by a change I made to the
>>> ceph-disk man page that updated the title:
>>>
>>> https://github.com/ceph/ceph/pull/19241/commits/bd00560c20caeeb1ded211cb81533280338014d1

> It failed there because the man pages are generated differently, using
> a couple of ad-hoc helpers that try to ensure certain conditions. In
> this case, it was a Python
> utility (ceph/man/conf.py). It was trying to make sure that the title
> of the man page matched the name of the man page.
> I had added "[DEPRECATED]" to the ceph-disk title, which failed the assertion.

Ugh.  FWIW I agree that's horrid.  Seems to me the doc build should be
doing the same thing the docs-part-of-the-binary-build is doing (and
always should have) and yes I know it's not simple.

