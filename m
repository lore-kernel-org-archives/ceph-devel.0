From: Casey Bodley <cbodley@redhat.com>
Subject: Re: RGW zones and admin ops
Date: Thu, 30 Mar 2017 15:38:37 -0400
Message-ID: <03607fca-d508-36ee-31c6-04c70f30ecd6@redhat.com>
References: <CAN1NP8h0h8Vo-EpjbmWSYg_L3G3KpCGfFUPBMJ=Crno3CgUW6w@mail.gmail.com>
 <58c1dd40-f8a6-a909-65d5-11d788aab530@redhat.com>
 <CAN1NP8i4-hDmiEgr6b+pJb95QNnhSMZo1Aded91qdnR2jjUhFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35167 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934017AbdC3Tik (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Mar 2017 15:38:40 -0400
Received: by mail-qk0-f176.google.com with SMTP id r142so49728591qke.2
        for <ceph-devel@vger.kernel.org>; Thu, 30 Mar 2017 12:38:39 -0700 (PDT)
In-Reply-To: <CAN1NP8i4-hDmiEgr6b+pJb95QNnhSMZo1Aded91qdnR2jjUhFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Forumulator V <forumulator@gmail.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

(cc: ceph-devel)

On 03/30/2017 02:42 PM, Forumulator V wrote:
> Hi,
>
> Thanks for the answers, they helped a lot. I'm writing a proposal for
> an alternate backend for RGW.
>
> I have a few more questions.
> i.) So each Zone will consist of multiple RGW instances(mainly for
> load balancing) and they would all share the same Ceph cluster.
> Different zones would have diff. clusters(typically). Zonegroups would
> have multiple zones. Did I get this right?
That's right.
> ii.) Typically, would the zones be geographically separated? Or would
> that be zonegroups?
The zones would be geographically separated, yes. (see iv. for more)
> iii.) Is realm a collection of Zonegroups themselves, into the bigger
> set? Why are there so many levels of collection?
Right. If you think of each zonegroup as a distinct dataset, it makes 
sense to allow more than one. And because metadata is replicated between 
all zonegroups, you could manage a single set of accounts/users at the 
realm level, that are shared by each zonegroup.
> iv.) You mentioned :
>> It's a similar concept to regions, but mostly within the context of replication.
> What do you mean by context of replication. Are the objects replicated
> between zonegroups too, in addition to any replication
> already happening on a storage cluster?
RGW multisite solves the problem of geo replication across wide area 
networks, using asynchronous replication. On the other hand, rados-level 
replication within a single ceph cluster is synchronous. Spreading a 
ceph cluster over a wide area network doesn't work well, because each of 
your writes would take a long time to complete.
> v.) Finally, since the Zonegroup data is stores as metadata by the
> RGW, the (alternate) backend itself does not need to support any
> special operations for this, right? And the same goes for user metadata?
Right, these things are just stored as rados objects. In rgw, we call 
them 'system objects' to distinguish them from swift/s3 objects. An 
alternate backend would just need to support reading/writing system 
objects, similar to the rgw_get/put_system_obj() functions in rgw_tools.h.
> Sorry for so many questions, this Zonegroup thing has eluded me since
> the first time I read the docs.
>
> Thanks!
> Pranjal
>
> On Wed, Mar 29, 2017 at 7:19 PM, Casey Bodley <cbodley@redhat.com> wrote:
>> On 03/29/2017 12:03 AM, Forumulator V wrote:
>>> Hi,
>>>
>>> I was going through the RGW code, and couldn't understand a few parts.
>>>
>>> i.) Where is zones and zonegroup information stored(on the backend)?
>>> Also do all RGW instances in a zone store objects on the same object
>>> storage cluster?
>>
>> The multisite configuration (zone/zonegroup/period/realm) is stored as rados
>> objects in the rgw.root pool (see RGW_DEFAULT_ZONE_ROOT_POOL and friends in
>> rgw_rados.cc).
>>
>> Generally, each zone will run in a separate ceph cluster. RGW instances
>> within a zone will share the same storage.
>>
>> But the zone itself contains the list of pool names used for its storage, so
>> it's also possible to run multiple zones on the same ceph cluster without
>> clobbering each others data - each zone will use separate pools by default.
>>
>>> ii.) What do zones and zonegroups really correspond to? Are they like
>>> regions in S3?
>>
>> It's a similar concept to regions, but mostly within the context of
>> replication. The first draft of rgw multisite actually used the term
>> 'region' instead of zonegroup. You can think of a zonegroup as a replicated
>> dataset - zones within a single zonegroup will replicate each others object
>> data.
>>
>>> iii.) Where are the users and their metadata stored? Is it also on the
>>> backend?
>>>
>> Following up on point ii., users and buckets are considered 'metadata' by
>> rgw multisite, and are replicated across all zonegroups. Users are stored as
>> rados objects across several of the zone's pools (see the
>> RGWZoneParams::user_*_pool fields in rgw_rados.h).
>>
>>> I'm sure the answers are there in the code, I understood some of it
>>> but not these parts.
>>>
>>> Thanks,
>>> Pranjal
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> I'm happy to answer more questions, if you have them. I also welcome
>> suggestions for improving our existing documentation at
>> http://docs.ceph.com/docs/master/radosgw/multisite/.
>>
>> Casey

