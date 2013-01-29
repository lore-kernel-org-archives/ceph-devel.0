From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 07/25] mds: don't early reply rename
Date: Tue, 29 Jan 2013 09:44:09 +0800
Message-ID: <51072969.1040705@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com> <1358910541-15535-8-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1301281342130.2055@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59140 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580Ab3A2Boi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Jan 2013 20:44:38 -0500
In-Reply-To: <alpine.DEB.2.00.1301281342130.2055@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 01/29/2013 05:44 AM, Sage Weil wrote:
> On Wed, 23 Jan 2013, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> _rename_finish() does not send dentry link/unlink message to replicas.
>> We should prevent dentries that are modified by the rename operation
>> from getting new replicas when the rename operation is committing. So
>> don't mark xlocks "done" and early reply for rename
> 
> Can we change this to only skip early reply if there are replicas?  Or 
> change things so we do send thos messages (or something isilar) early?  As 
> is this will kill workloads like rsync that rename every file.
> 

How about not mark xlocks on dentries done.

Regards
Yan, Zheng


> Thanks!
> s
> 
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  src/mds/Server.cc | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
>> index eced76f..4492341 100644
>> --- a/src/mds/Server.cc
>> +++ b/src/mds/Server.cc
>> @@ -796,6 +796,14 @@ void Server::early_reply(MDRequest *mdr, CInode *tracei, CDentry *tracedn)
>>      return;
>>    }
>>  
>> +  // _rename_finish() does not send dentry link/unlink message to replicas.
>> +  // so do not mark xlocks "done", the xlocks prevent srcdn and destdn from
>> +  // getting new replica.
>> +  if (mdr->client_request->get_op() == CEPH_MDS_OP_RENAME) {
>> +    dout(10) << "early_reply - rename, not allowed" << dendl;
>> +    return;
>> +  }
>> +
>>    MClientRequest *req = mdr->client_request;
>>    entity_inst_t client_inst = req->get_source_inst();
>>    if (client_inst.name.is_mds())
>> -- 
>> 1.7.11.7
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

