From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 5/6] ceph: check mds_wanted for imported cap
Date: Sun, 06 Jan 2013 16:21:15 +0800
Message-ID: <50E933FB.7040801@intel.com>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com> <1357299261-20591-6-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1301052216330.15430@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:54976 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab3AFIVS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 6 Jan 2013 03:21:18 -0500
In-Reply-To: <alpine.DEB.2.00.1301052216330.15430@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 01/06/2013 02:20 PM, Sage Weil wrote:
> On Fri, 4 Jan 2013, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> The MDS may have incorrect wanted caps after importing caps. So the
>> client should check the value mds has and send cap update if necessary.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  fs/ceph/caps.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index 7e90299..16c10f8 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -2425,10 +2425,12 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
>>  	     ceph_cap_string(used),
>>  	     ceph_cap_string(dirty));
>>  	if (wanted != le32_to_cpu(grant->wanted)) {
>> -		dout("mds wanted %s -> %s\n",
>> -		     ceph_cap_string(le32_to_cpu(grant->wanted)),
>> -		     ceph_cap_string(wanted));
>> -		grant->wanted = cpu_to_le32(wanted);
> 
> Doh, this was a holdover from when we used to re-use the incoming message 
> and send it back out over the wire.
> 
>> +		dout("mds wanted = %s\n",
>> +		     ceph_cap_string(le32_to_cpu(grant->wanted)));
> 
> Any reason to drop the "old -> new" output?
> 
will and it back in next patch

>> +		/* imported cap may not have correct mds_wanted */
>> +		if (cap == ci->i_auth_cap &&
>> +		    (wanted & ~(cap->mds_wanted | cap->issued)))
>> +			check_caps = 1;
> 
> I think we want
> 
> 		if (cap == ci->i_auth_cap)
> 			check_caps = 1;
probably, we need

if (le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT)
  check_caps = 1;

Regards
Yan, Zheng

> 
> If we want more caps, check_caps will request immediately.  If we have 
> extra, we'll put the cap on the delay list.
> 
> sage
> 
> 
>>  	}
>>  
>>  	cap->seq = seq;
>> -- 
>> 1.7.11.7
>>
>>

