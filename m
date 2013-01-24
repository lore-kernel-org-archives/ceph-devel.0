From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 01/25] mds: fix end check in Server::handle_client_readdir()
Date: Thu, 24 Jan 2013 10:16:29 +0800
Message-ID: <5100997D.6010905@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com> <1358910541-15535-2-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1301230916200.29291@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40145 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954Ab3AXCQa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 Jan 2013 21:16:30 -0500
In-Reply-To: <alpine.DEB.2.00.1301230916200.29291@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 01/24/2013 01:17 AM, Sage Weil wrote:
> Hi Yan,
> 
> I pushed this one to next, thanks.  BTW what are you using to reproduce 
> this?  We'd like to continue to improve the coverage of 
> ceph-qa-suite.git/suites/fs.
> 

My scripts delete the test directory after finishing a round of fsstress testing.
I noticed that 'rm' emitted "cannot remove directory : Directory not empty" errors
These errors are tentative, if re-try deleting them, it will succeed.

Regards
Yan, Zheng

> Thanks!
> sage
> 
> On Wed, 23 Jan 2013, Yan, Zheng wrote:
> 
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> commit 1174dd3188 (don't retry readdir request after issuing caps)
>> introduced an bug that wrongly marks 'end' in the the readdir reply.
>> The code that touches existing dentries re-uses an iterator, and the
>> iterator is used for checking if readdir is end.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  src/mds/Server.cc | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
>> index b70445e..45eed81 100644
>> --- a/src/mds/Server.cc
>> +++ b/src/mds/Server.cc
>> @@ -2895,11 +2895,9 @@ void Server::handle_client_readdir(MDRequest *mdr)
>>  	continue;
>>        } else {
>>  	// touch everything i _do_ have
>> -	for (it = dir->begin(); 
>> -	     it != dir->end(); 
>> -	     it++) 
>> -	  if (!it->second->get_linkage()->is_null())
>> -	    mdcache->lru.lru_touch(it->second);
>> +	for (CDir::map_t::iterator p = dir->begin(); p != dir->end(); p++)
>> +	  if (!p->second->get_linkage()->is_null())
>> +	    mdcache->lru.lru_touch(p->second);
>>  
>>  	// already issued caps and leases, reply immediately.
>>  	if (dnbl.length() > 0) {
>> -- 
>> 1.7.11.7
>>
>>

