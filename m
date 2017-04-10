From: Loic Dachary <loic@dachary.org>
Subject: Re: crush multiweight implementation details
Date: Mon, 10 Apr 2017 16:39:59 +0200
Message-ID: <b5755ce1-730a-f3d5-7c54-28e2c0628aa1@dachary.org>
References: <6bcba5f9-7f68-bcf7-3f85-323b4fa6dd29@dachary.org>
 <alpine.DEB.2.11.1704101410300.2999@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:45233 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbdDJOqr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Apr 2017 10:46:47 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id EB68D47BD13
        for <ceph-devel@vger.kernel.org>; Mon, 10 Apr 2017 16:40:03 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.11.1704101410300.2999@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 04/10/2017 04:11 PM, Sage Weil wrote:
> On Mon, 10 Apr 2017, Loic Dachary wrote:
>> Hi Sage,
>>
>> We could have:
>>
>> struct crush_choose_arg {
>>   __u32 bucket_id;
>>   __u32 num_items;
>>   __u32 *ids; // override the bucket items for placement
>>   __u32 num_positions;
>>   __u32 *weights; // size is num_positions*num_items
>> };
>>  
>> struct crush_choose_arg_map {
>>   struct crush_choose_arg *args;
>>   __u32 size;
>> };
>>
>> and
>>
>> void crush_init_workspace(const struct crush_map *m, struct crush_choose_arg_map *arg_map, void *v) {
>> ...
>> if (m->buckets[b]->id == arg_map[b]->bucket_id)
>>    w->work[b]->arg = arg_map[b];
>> ...
>> }
>>
>> with
>>
>> struct crush_work_bucket {
>>     __u32 perm_x; /* @x for which *perm is defined */
>>     __u32 perm_n; /* num elements of *perm that are permuted/defined */
>>     __u32 *perm;  /* Permutation of the bucket's items */
>>     struct crush_choose_arg *arg;
>> };
>>
>> There would be no need to change the code path since crush_bucket_choose 
>> already is given the crush_work_bucket. And crush_init_workspace already 
>> has logic that is algorithm dependent. And all the sanity checks could 
>> be done in crush_init_workspace so that the choose function only does 
>> what's absolutely necessary.
> 
> Allowing overrides of the bucket items too makes me nervous (do we have a 
> use for that yet?), 

Maybe I misunderstood what you were after with bucket_id in http://pad.ceph.com/p/crush-multiweight around here ?

struct crush_bucket_weight_set {
  __u32 bucket_id;  /* used as input to hash in place of bucket id */
  __u32 num_positions, num_items;
  __u32 *data; // index like [item*num_items+pos]
};

> but otherwise this looks reasonable!

Cool :-)

-- 
Loïc Dachary, Artisan Logiciel Libre
