From: John Spray <jspray@redhat.com>
Subject: Re: Proposal to rename ceph-qa-suite project in tracker.ceph.com
Date: Tue, 14 Feb 2017 00:10:02 +0000
Message-ID: <CALe9h7cNKpPUq0iLk9UOj1tgXkSY7NKADCkaZibTY5Y4OR1ZhA@mail.gmail.com>
References: <d7e1ef80-56ad-63f9-cbf8-a4ef1ada8be8@suse.cz> <alpine.DEB.2.11.1702132224320.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35366 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdBNAKY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 19:10:24 -0500
Received: by mail-wm0-f47.google.com with SMTP id v186so4284540wmd.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2017 16:10:23 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702132224320.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Nathan Cutler <ncutler@suse.cz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Feb 13, 2017 at 10:25 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 13 Feb 2017, Nathan Cutler wrote:
>> Now that ceph-qa-suite has been assimilated into ceph/ceph.git, shall we
>> rename http://tracker.ceph.com/projects/ceph-qa-suite ?
>>
>> If nobody objects, I'd like to rename it to "tests" so it would cover both
>> teuthology tests and make check tests.
>
> Go for it.  I'd say that many of the tests can actually go in the relevant
> projects directly, though; we can use 'tests' for the underlying
> infrastructure (like ceph.py, ceph_manager.py, an so on)?

Yes -- for actual test cases we have the relevant category/component
fields within e.g. the 'fs' subproject.

Maybe the rename should be to "test infrastructure" or something like
that, so that anyone looking at it doesn't think they're looking at
all test-related stuff.

John

>
> sage
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
