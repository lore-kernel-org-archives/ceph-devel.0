From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH] ceph: add halt mount option support
Date: Mon, 17 Feb 2020 23:45:16 +0800
Message-ID: <ae54de81-f191-d4cd-8d86-d06958946095@redhat.com>
References: <20200216064945.61726-1-xiubli@redhat.com>
 <78ff80dd12d497be7a6606a60973f7e2d864e910.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23611 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729347AbgBQPpe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Feb 2020 10:45:34 -0500
In-Reply-To: <78ff80dd12d497be7a6606a60973f7e2d864e910.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/2/17 21:04, Jeff Layton wrote:
> On Sun, 2020-02-16 at 01:49 -0500, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> This will simulate pulling the power cable situation, which will
>> do:
>>
>> - abort all the inflight osd/mds requests and fail them with -EIO.
>> - reject any new coming osd/mds requests with -EIO.
>> - close all the mds connections directly without doing any clean up
>>    and disable mds sessions recovery routine.
>> - close all the osd connections directly without doing any clean up.
>> - set the msgr as stopped.
>>
>> URL: https://tracker.ceph.com/issues/44044
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> There is no explanation of how to actually _use_ this feature?

 From the tracker's description I am assuming it just will do something 
like testing some features in the cephfs by simulating connections to 
the client node are lost due to some reasons, such as lost power.

>   I assume
> you have to remount the fs with "-o remount,halt" ?

Yeah, right.


> Is it possible to
> reenable the mount as well?

For the "halt", no.

>    If not, why keep the mount around?

I would let the followed umount to continue to do the cleanup.


>   Maybe we
> should consider wiring this in to a new umount2() flag instead?

For the umount2(), it seems have conflicted with the MNT_FORCE, but a 
little different.


>
> This needs much better documentation.
>
> In the past, I've generally done this using iptables. Granted that that
> is difficult with a clustered fs like ceph (given that you potentially
> have to set rules for a lot of addresses), but I wonder whether a scheme
> like that might be more viable in the long run.
>
> Note too that this may have interesting effects when superblocks end up
> being shared between vfsmounts.

Yeah, this is based the superblock, so for the shared vfsmounts, they 
all will be halted at the same time.


>> @@ -4748,7 +4751,12 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
>>   		if (!session)
>>   			continue;
>>   
>> -		if (session->s_state == CEPH_MDS_SESSION_REJECTED)
>> +		/*
>> +		 * when halting the superblock, it will simulate pulling
>> +		 * the power cable, so here close the connection before
>> +		 * doing any cleanup.
>> +		 */
>> +		if (halt || (session->s_state == CEPH_MDS_SESSION_REJECTED))
>>   			__unregister_session(mdsc, session);
> Note that this is not exactly like pulling the power cable. The
> connection will be closed, which will send a FIN to the peer.

Yeah, it is.

I was thinking for the fuse client, if we send a KILL signal, the kernel 
will also help us close the socket fds and send the FIN to the peer ?

If the fuse client works for this case, so will it here.

>> @@ -1115,6 +1117,16 @@ int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl)
>>   }
>>   EXPORT_SYMBOL(ceph_monc_init);
>>   
>> +void ceph_monc_halt(struct ceph_mon_client *monc)
>> +{
>> +	dout("monc halt\n");
>> +
>> +	mutex_lock(&monc->mutex);
>> +	monc->halt = true;
>> +	ceph_con_close(&monc->con);
>> +	mutex_unlock(&monc->mutex);
>> +}
>> +
> The changelog doesn't mention shutting down connections to the mons.

Yeah, I missed it.

Thanks,

BRs
