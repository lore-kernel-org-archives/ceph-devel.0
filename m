From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Luminous 12.1.1 upgrade mgr woes
Date: Wed, 19 Jul 2017 14:27:27 +1200
Message-ID: <c7d70dcd-50d3-895d-9f26-c8732e65d806@catalyst.net.nz>
References: <b98f9901-d21b-1a28-bec8-423b56583c05@catalyst.net.nz>
 <CALe9h7crTisnMZNqicOa3Tc=dDxvM-cKCxPmf5cpXfrwvR5Bpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([202.78.240.226]:43962
        "EHLO cat-porwal-prod-mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751969AbdGSC1b (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Jul 2017 22:27:31 -0400
In-Reply-To: <CALe9h7crTisnMZNqicOa3Tc=dDxvM-cKCxPmf5cpXfrwvR5Bpg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 18/07/17 23:32, John Spray wrote:

> On Tue, Jul 18, 2017 at 10:03 AM, Mark Kirkwood
> <mark.kirkwood@catalyst.net.nz> wrote:
>> Hi,
>>
>> Just had a go at this - 12.1.1 from a freshly deployed Jewel (10.2.9) on
>> Ubuntu 16.04, following
>> http://docs.ceph.com/docs/master/release-notes/#upgrade-from-jewel-or-kraken.
>>
>> So it all worked ok *except* for the the mgr deploy, this hang at the
>> key/caps modification stage (see attached). Now I managed to work around it:
>>
>> - switch cephx to none in ceph.conf
>>
>> - restart mon
>>
>> - redeploy mgr
> Hmm, I suspect the issue is with the bootstrap-mgr keyring.  I notice
> that when trying a "mgr create" on an upgraded cluster, ceph-deploy is
> prompting me to do a "gatherkeys", at which point it generates the
> keyring.  However, the bootstrap-mgr identity that I have inside the
> mon is weird, its key is AAAAAAAAAAAAAAAA.
>
> Even after I've got the bootstrap-mgr keyring (whose AAA... key
> matches the weird one that the mon has), I get EINVAL connecting, and
> the mon is logging "error when trying to handle auth request, probably
> malformed request".
>
>

Yeah, that is what I'm seeing here (I didn't notice that the 
bootstrap-mgr key was weird/truncated...well spotted).

regards
Mark
