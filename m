From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Luminous 12.1.1 upgrade mgr woes
Date: Tue, 18 Jul 2017 16:30:38 +0100
Message-ID: <2cb8bb3d-8baa-7252-da02-b066483be615@suse.de>
References: <b98f9901-d21b-1a28-bec8-423b56583c05@catalyst.net.nz>
 <CALe9h7crTisnMZNqicOa3Tc=dDxvM-cKCxPmf5cpXfrwvR5Bpg@mail.gmail.com>
 <2408e280-b17f-d291-47ce-8bde4b4bea6f@suse.de>
 <CALe9h7epURo_gr18-hTrLNxF+RxkXGwjAUqC=ctxs_TUq_d_fA@mail.gmail.com>
 <0bb5938b-994b-33db-c047-c35255514738@suse.de>
 <alpine.DEB.2.11.1707181507440.27271@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54377 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751430AbdGRPal (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Jul 2017 11:30:41 -0400
In-Reply-To: <alpine.DEB.2.11.1707181507440.27271@piezo.novalocal>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/18/2017 04:08 PM, Sage Weil wrote:
> On Tue, 18 Jul 2017, Joao Eduardo Luis wrote:
>> On 07/18/2017 01:20 PM, John Spray wrote:
>>> On Tue, Jul 18, 2017 at 1:17 PM, Joao Eduardo Luis <joao@suse.de> wrote:
>>>> On 07/18/2017 12:32 PM, John Spray wrote:
>>>>>
>>>>> On Tue, Jul 18, 2017 at 10:03 AM, Mark Kirkwood
>>>>> <mark.kirkwood@catalyst.net.nz> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Just had a go at this - 12.1.1 from a freshly deployed Jewel (10.2.9)
>>>>>> on
>>>>>> Ubuntu 16.04, following
>>>>>>
>>>>>> http://docs.ceph.com/docs/master/release-notes/#upgrade-from-jewel-or-kraken.
>>>>>>
>>>>>> So it all worked ok *except* for the the mgr deploy, this hang at the
>>>>>> key/caps modification stage (see attached). Now I managed to work
>>>>>> around
>>>>>> it:
>>>>>>
>>>>>> - switch cephx to none in ceph.conf
>>>>>>
>>>>>> - restart mon
>>>>>>
>>>>>> - redeploy mgr
>>>>>
>>>>>
>>>>> Hmm, I suspect the issue is with the bootstrap-mgr keyring.  I notice
>>>>> that when trying a "mgr create" on an upgraded cluster, ceph-deploy is
>>>>> prompting me to do a "gatherkeys", at which point it generates the
>>>>> keyring.  However, the bootstrap-mgr identity that I have inside the
>>>>> mon is weird, its key is AAAAAAAAAAAAAAAA.
>>>>>
>>>>> Even after I've got the bootstrap-mgr keyring (whose AAA... key
>>>>> matches the weird one that the mon has), I get EINVAL connecting, and
>>>>> the mon is logging "error when trying to handle auth request, probably
>>>>> malformed request".
>>>>>
>>>>> So yeah, something's pretty broken here!
>>>>
>>>>
>>>> I was having that when working on `osd new`, I think, but IIRC I managed
>>>> to
>>>> fix the bug.
>>>>
>>>> This may be somehow related to the refactoring I did on AuthMonitor
>>>> though.
>>>>
>>>> Is this just a matter of running a 'mgr create' on an upgraded cluster? If
>>>> so, I'll try reproducing this in the afternoon and see if I can figure out
>>>> what went wrong.
>>>
>>> Pretty much -- my cluster was a bit different though because it had
>>> been kraken, so the mon nodes already had mgrs on them.  I was running
>>> "mgr create" one one of the nodes that had never had a mgr or monitor
>>> on it.
>>
>> Looks like the problem is due to the auth entity not having a key at all when
>> it's added during upgrade.
>>
>> PR https://github.com/ceph/ceph/pull/16395 fixes it.
> 
> That fix looks right to me.  Were you able to reproduce the original
> issue, and/or did you test with the fix?

Yes to both.

Reproducing is trivial, coming from kraken:

- have a vstart kraken cluster
- upgrade monitors to luminous
- see a 'client.bootstrap-mgr' entry popping up on 'auth list' with a 
key something like 'AAAAAAAA'

After the fix, the key is a proper cephx key.

   -Joao
