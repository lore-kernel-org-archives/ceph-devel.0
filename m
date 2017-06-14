From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: Clang does not like constexpression
Date: Wed, 14 Jun 2017 19:45:01 +0200
Message-ID: <CA+H5UW2MqpJtV9eWQ9VJg1XVkWRCv0HQf6KVWKwEcsQAHj=_qQ@mail.gmail.com>
References: <3b811d53-d45f-7ed2-a65f-b7114739e891@digiware.nl>
 <CA+H5UW2k7ZEJVYJXE4aGvbNkjBsN3mVaDiNpRY585CvyGpOdeA@mail.gmail.com> <20170614170617.GA6164@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36100 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752204AbdFNRu7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 13:50:59 -0400
Received: by mail-yw0-f177.google.com with SMTP id l75so4924872ywc.3
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 10:50:59 -0700 (PDT)
In-Reply-To: <20170614170617.GA6164@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jun 14, 2017 at 7:06 PM, Adam C. Emerson <aemerson@redhat.com> wrote:

> Though I admit the more builders we add the slower Jenkins is. Are there
> any older systems or variants we could prune out?

I fully understand and agree that verifying all PRs for everything is no-no
due to economical reasons. Though, maybe we don't need to spawn all
jobs automatically but, in some cases, delegate the decision to reviewers?
For instance, if someone faces a C++11-heavy code, he could trigger
a Clang validation just by posting comment like: "jenkins, Clang validation
please".

Regards,
Radek
