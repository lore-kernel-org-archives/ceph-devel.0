From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Luminous 12.1.1 upgrade mgr woes
Date: Tue, 18 Jul 2017 13:17:49 +0100
Message-ID: <2408e280-b17f-d291-47ce-8bde4b4bea6f@suse.de>
References: <b98f9901-d21b-1a28-bec8-423b56583c05@catalyst.net.nz>
 <CALe9h7crTisnMZNqicOa3Tc=dDxvM-cKCxPmf5cpXfrwvR5Bpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34017 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751322AbdGRMRw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Jul 2017 08:17:52 -0400
In-Reply-To: <CALe9h7crTisnMZNqicOa3Tc=dDxvM-cKCxPmf5cpXfrwvR5Bpg@mail.gmail.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/18/2017 12:32 PM, John Spray wrote:
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
> 
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
> So yeah, something's pretty broken here!

I was having that when working on `osd new`, I think, but IIRC I managed 
to fix the bug.

This may be somehow related to the refactoring I did on AuthMonitor though.

Is this just a matter of running a 'mgr create' on an upgraded cluster? 
If so, I'll try reproducing this in the afternoon and see if I can 
figure out what went wrong.

   -Joao
