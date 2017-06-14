From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Are we ready for 10.2.8 - cephfs
Date: Wed, 14 Jun 2017 19:39:45 +0200
Message-ID: <1c7fab31-4990-681d-eb5f-0ae4a1977a41@suse.cz>
References: <be949951-5e1c-9471-23f6-2c595baec10a@suse.cz>
 <CABZ+qq=p_=8PHCwBoo=aQ1V5CeRk4QdNiK7t=ooeisFHB9etyg@mail.gmail.com>
 <CALe9h7dUCBXKnyxGVi3utN_ArkZixO-SZ+xH60L23R11FELMzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60759 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751920AbdFNRjt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Jun 2017 13:39:49 -0400
In-Reply-To: <CALe9h7dUCBXKnyxGVi3utN_ArkZixO-SZ+xH60L23R11FELMzw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Nathan, if we have time to do another pre-merge test run for jewel
> backports, then there are a few with label:cephfs and my review on,
> that would just need to go through a fs suite.

OK, I think we can manage that. Please note that it's the 
milestone:jewel tag in the PR that determines whether the PR gets picked 
up for integration testing. If the milestone is not set, the script 
doesn't see it. (I will look into patching the script so it makes noise 
if it sees a PR targeting the jewel branch but without a milestone, or 
with the wrong milestone.)

Nathan
