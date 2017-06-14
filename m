From: John Spray <jspray@redhat.com>
Subject: Re: Are we ready for 10.2.8 - cephfs
Date: Wed, 14 Jun 2017 13:44:58 -0400
Message-ID: <CALe9h7eetaO1bBht1QBZTZm8T=5uFGSf6FYoX-px5ETeDDoc+A@mail.gmail.com>
References: <be949951-5e1c-9471-23f6-2c595baec10a@suse.cz> <CABZ+qq=p_=8PHCwBoo=aQ1V5CeRk4QdNiK7t=ooeisFHB9etyg@mail.gmail.com>
 <CALe9h7dUCBXKnyxGVi3utN_ArkZixO-SZ+xH60L23R11FELMzw@mail.gmail.com> <1c7fab31-4990-681d-eb5f-0ae4a1977a41@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35961 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbdFNRpe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 13:45:34 -0400
Received: by mail-wr0-f182.google.com with SMTP id 36so10465567wry.3
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 10:45:33 -0700 (PDT)
In-Reply-To: <1c7fab31-4990-681d-eb5f-0ae4a1977a41@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jun 14, 2017 at 1:39 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>> Nathan, if we have time to do another pre-merge test run for jewel
>> backports, then there are a few with label:cephfs and my review on,
>> that would just need to go through a fs suite.
>
>
> OK, I think we can manage that. Please note that it's the milestone:jewel
> tag in the PR that determines whether the PR gets picked up for integration
> testing. If the milestone is not set, the script doesn't see it. (I will
> look into patching the script so it makes noise if it sees a PR targeting
> the jewel branch but without a milestone, or with the wrong milestone.)

Just curious, why do we add that label?  I've always filtered this by
using "base:jewel" in github.

John

> Nathan
