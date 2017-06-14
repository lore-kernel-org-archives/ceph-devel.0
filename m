From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Are we ready for 10.2.8 - cephfs
Date: Wed, 14 Jun 2017 20:45:39 +0200
Message-ID: <44b31673-0021-fe48-251e-61780614a283@suse.cz>
References: <be949951-5e1c-9471-23f6-2c595baec10a@suse.cz>
 <CABZ+qq=p_=8PHCwBoo=aQ1V5CeRk4QdNiK7t=ooeisFHB9etyg@mail.gmail.com>
 <CALe9h7dUCBXKnyxGVi3utN_ArkZixO-SZ+xH60L23R11FELMzw@mail.gmail.com>
 <1c7fab31-4990-681d-eb5f-0ae4a1977a41@suse.cz>
 <CALe9h7eetaO1bBht1QBZTZm8T=5uFGSf6FYoX-px5ETeDDoc+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36121 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751670AbdFNSpm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 14:45:42 -0400
In-Reply-To: <CALe9h7eetaO1bBht1QBZTZm8T=5uFGSf6FYoX-px5ETeDDoc+A@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Just curious, why do we add that label?  I've always filtered this by
> using "base:jewel" in github.

Well, when we are trying to get backports merged for the "next" point 
release while the "current" one is in QE, we open PRs targeting 
jewel-next - so that's not ironclad.

But I don't really know the answer to why the milestone tag is there. 
It's what we've always populated the integration branch by. I agree it's 
not optimal because PRs can get delayed waiting for someone to set the 
milestone.
