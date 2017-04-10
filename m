From: Loic Dachary <loic@dachary.org>
Subject: Re: crush multiweight implementation details
Date: Mon, 10 Apr 2017 16:53:57 +0200
Message-ID: <e0486aed-57d8-ec7c-8686-3c0775f69095@dachary.org>
References: <6bcba5f9-7f68-bcf7-3f85-323b4fa6dd29@dachary.org>
 <alpine.DEB.2.11.1704101410300.2999@piezo.novalocal>
 <b5755ce1-730a-f3d5-7c54-28e2c0628aa1@dachary.org>
 <alpine.DEB.2.11.1704101442540.2999@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46128 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbdDJOyB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Apr 2017 10:54:01 -0400
In-Reply-To: <alpine.DEB.2.11.1704101442540.2999@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 04/10/2017 04:44 PM, Sage Weil wrote:
> On Mon, 10 Apr 2017, Loic Dachary wrote:
>> On 04/10/2017 04:11 PM, Sage Weil wrote:
>>> On Mon, 10 Apr 2017, Loic Dachary wrote:
>>>> Hi Sage,
>>>>
>>>> We could have:
>>>>
>>>> struct crush_choose_arg {
>>>>   __u32 bucket_id;
>>>>   __u32 num_items;
>>>>   __u32 *ids; // override the bucket items for placement
>>>>   __u32 num_positions;
>>>>   __u32 *weights; // size is num_positions*num_items
>>>> };
>>>>  
>>>> struct crush_choose_arg_map {
>>>>   struct crush_choose_arg *args;
>>>>   __u32 size;
>>>> };
>>>>
>>>> and
>>>>
>>>> void crush_init_workspace(const struct crush_map *m, struct crush_choose_arg_map *arg_map, void *v) {
>>>> ...
>>>> if (m->buckets[b]->id == arg_map[b]->bucket_id)
>>>>    w->work[b]->arg = arg_map[b];
>>>> ...
>>>> }
>>>>
>>>> with
>>>>
>>>> struct crush_work_bucket {
>>>>     __u32 perm_x; /* @x for which *perm is defined */
>>>>     __u32 perm_n; /* num elements of *perm that are permuted/defined */
>>>>     __u32 *perm;  /* Permutation of the bucket's items */
>>>>     struct crush_choose_arg *arg;
>>>> };
>>>>
>>>> There would be no need to change the code path since crush_bucket_choose 
>>>> already is given the crush_work_bucket. And crush_init_workspace already 
>>>> has logic that is algorithm dependent. And all the sanity checks could 
>>>> be done in crush_init_workspace so that the choose function only does 
>>>> what's absolutely necessary.
>>>
>>> Allowing overrides of the bucket items too makes me nervous (do we have a 
>>> use for that yet?), 
>>
>> Maybe I misunderstood what you were after with bucket_id in http://pad.ceph.com/p/crush-multiweight around here ?
>>
>> struct crush_bucket_weight_set {
>>   __u32 bucket_id;  /* used as input to hash in place of bucket id */
>>   __u32 num_positions, num_items;
>>   __u32 *data; // index like [item*num_items+pos]
>> };
> 
> It's just the bucket id that matters; the members of the bucket don't need 
> to change.  I'm not sure that the __u32 *ids above is needed for 
> anything... unless I'm misunderstanding something?

The code would look like this:

static int bucket_straw2_choose(const struct crush_bucket_straw2 *bucket,
				int x, int r, const struct crush_choose_arg_list *arg_map, int position)
{
        struct crush_choose_arg_at_position *arg = get_straw2_choose_arg(bucket, arg_map, position);
	unsigned int i, high = 0;
	unsigned int u;
	unsigned int w;
        unsigned int id;
	__s64 ln, draw, high_draw = 0;

	for (i = 0; i < bucket->h.size; i++) {
		w = arg->weights[i];
                id = arg->ids[i];
                dprintk("weight 0x%x item %d\n", w, id);
		if (w) {
			u = crush_hash32_3(bucket->h.hash, x, id, r);

I don't see how changing the bucket id alone would work otherwise since it's not used.

> 
> sage
> 
>  
>>> but otherwise this looks reasonable!
>>
>> Cool :-)
>>
>> -- 
>> Loïc Dachary, Artisan Logiciel Libre
>>

-- 
Loïc Dachary, Artisan Logiciel Libre
