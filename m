From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 29/39] mds: avoid double auth pin for file recovery
Date: Thu, 21 Mar 2013 14:58:07 -0700
Message-ID: <CAPYLRzjLezkb-gFE1w_RU4AXSFPxFp4J7SnMV1z1P_DS+E2riQ@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-30-git-send-email-zheng.z.yan@intel.com>
	<CAPYLRzigAZ5Omf5aU2sDLU6_Dzc9+6B5GRLvL9cti_tme5d+_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:52297 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab3CUV6I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Mar 2013 17:58:08 -0400
Received: by mail-qa0-f48.google.com with SMTP id hu16so1175223qab.14
        for <ceph-devel@vger.kernel.org>; Thu, 21 Mar 2013 14:58:07 -0700 (PDT)
In-Reply-To: <CAPYLRzigAZ5Omf5aU2sDLU6_Dzc9+6B5GRLvL9cti_tme5d+_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Went over those mechanisms quickly but a bit more carefully; looks good.
Reviewed-by: Greg Farnum <greg@inktank.com>

On Wed, Mar 20, 2013 at 8:20 PM, Gregory Farnum <greg@inktank.com> wrote:
> This looks good on its face but I haven't had the chance to dig
> through the recovery queue stuff yet (it's on my list following some
> issues with recovery speed). How'd you run across this? If it's being
> added to the recovery queue multiple times I want to make sure we
> don't have some other machinery trying to dequeue it multiple times,
> or a single waiter which needs to be a list or something.
> -Greg
>
> On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  src/mds/MDCache.cc | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
>> index 973a4d0..e9a79cd 100644
>> --- a/src/mds/MDCache.cc
>> +++ b/src/mds/MDCache.cc
>> @@ -5502,8 +5502,10 @@ void MDCache::_queue_file_recover(CInode *in)
>>    dout(15) << "_queue_file_recover " << *in << dendl;
>>    assert(in->is_auth());
>>    in->state_clear(CInode::STATE_NEEDSRECOVER);
>> -  in->state_set(CInode::STATE_RECOVERING);
>> -  in->auth_pin(this);
>> +  if (!in->state_test(CInode::STATE_RECOVERING)) {
>> +    in->state_set(CInode::STATE_RECOVERING);
>> +    in->auth_pin(this);
>> +  }
>>    file_recover_queue.insert(in);
>>  }
>>
>> --
>> 1.7.11.7
>>
