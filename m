From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Are we ready for 10.2.8 - cephfs
Date: Tue, 27 Jun 2017 13:41:29 +0200
Message-ID: <cd9be044-1b2f-c698-4207-e6fbaaa854c7@suse.cz>
References: <be949951-5e1c-9471-23f6-2c595baec10a@suse.cz>
 <CABZ+qq=p_=8PHCwBoo=aQ1V5CeRk4QdNiK7t=ooeisFHB9etyg@mail.gmail.com>
 <CALe9h7dUCBXKnyxGVi3utN_ArkZixO-SZ+xH60L23R11FELMzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752529AbdF0Llb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Jun 2017 07:41:31 -0400
In-Reply-To: <CALe9h7dUCBXKnyxGVi3utN_ArkZixO-SZ+xH60L23R11FELMzw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi John:

I believe we have all the requested CephFS fixes in, now. Do you think 
10.2.8 is ready for QE, as far as CephFS is concerned?

Nathan

On 06/14/2017 04:25 PM, John Spray wrote:
> On Tue, Jun 13, 2017 at 7:49 AM, Dan van der Ster <dan@vanderster.com> wrote:
>> Hi,
>>
>> Would it be possible to get these into 10.2.8?
>>
>>      http://tracker.ceph.com/issues/19677
>>      http://tracker.ceph.com/issues/19762
>>      http://tracker.ceph.com/issues/20027
> 
> I've been a bit behind on reviewing backports lately, sorry about that.
> 
> I've merged the first two of those.  The third one had a PR that
> didn't have the cephfs label so it got missed.
> 
> Nathan, if we have time to do another pre-merge test run for jewel
> backports, then there are a few with label:cephfs and my review on,
> that would just need to go through a fs suite.
> 
> Cheers,
> John
