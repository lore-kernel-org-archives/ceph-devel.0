From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: [PATCH] libceph: apply new_state before new_up_client on
 incrementals
Date: Thu, 21 Jul 2016 12:22:55 -0700
Message-ID: <5791210F.8040408@redhat.com>
References: <1468963597-10667-1-git-send-email-idryomov@gmail.com>
 <57901170.4000809@redhat.com>
 <CAOi1vP-BOfzQpNH1yRaZO78F0aT3ictmWJ_UO-9K1bsQDriM_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41487 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753848AbcGUTW4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Jul 2016 15:22:56 -0400
In-Reply-To: <CAOi1vP-BOfzQpNH1yRaZO78F0aT3ictmWJ_UO-9K1bsQDriM_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 07/21/2016 08:27 AM, Ilya Dryomov wrote:
> On Thu, Jul 21, 2016 at 2:04 AM, Josh Durgin <jdurgin@redhat.com> wrote:
>> On 07/19/2016 02:26 PM, Ilya Dryomov wrote:
>>>
>>> Currently, osd_weight and osd_state fields are updated in the encoding
>>> order.  This is wrong, because an incremental map may look like e.g.
>>>
>>>       new_up_client: { osd=6, addr=... } # set osd_state and addr
>>>       new_state: { osd=6, xorstate=EXISTS } # clear osd_state
>>>
>>> Suppose osd6's current osd_state is EXISTS (i.e. osd6 is down).  After
>>> applying new_up_client, osd_state is changed to EXISTS | UP.  Carrying
>>> on with the new_state update, we flip EXISTS and leave osd6 in a weird
>>> "!EXISTS but UP" state.  A non-existent OSD is considered down by the
>>> mapping code
>>>
>>> 2087    for (i = 0; i < pg->pg_temp.len; i++) {
>>> 2088            if (ceph_osd_is_down(osdmap, pg->pg_temp.osds[i])) {
>>> 2089                    if (ceph_can_shift_osds(pi))
>>> 2090                            continue;
>>> 2091
>>> 2092                    temp->osds[temp->size++] = CRUSH_ITEM_NONE;
>>>
>>> and so requests get directed to the second OSD in the set instead of
>>> the first, resulting in OSD-side errors like:
>>>
>>> [WRN] : client.4239 192.168.122.21:0/2444980242 misdirected
>>> client.4239.1:2827 pg 2.5df899f2 to osd.4 not [1,4,6] in e680/680
>>>
>>> and hung rbds on the client:
>>>
>>> [  493.566367] rbd: rbd0: write 400000 at 11cc00000 (0)
>>> [  493.566805] rbd: rbd0:   result -6 xferred 400000
>>> [  493.567011] blk_update_request: I/O error, dev rbd0, sector 9330688
>>>
>>> The fix is to decouple application from the decoding and:
>>> - apply new_weight first
>>> - apply new_state before new_up_client
>>> - twiddle osd_state flags if marking in
>>> - clear out some of the state if osd is destroyed
>>>
>>> Fixes: http://tracker.ceph.com/issues/14901
>>>
>>> Cc: stable@vger.kernel.org # 3.15+: 6dd74e44dc1d: libceph: set 'exists'
>>> flag for newly up osd
>>> Cc: stable@vger.kernel.org # 3.15+
>>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>>> ---
>>>    net/ceph/osdmap.c | 156
>>> +++++++++++++++++++++++++++++++++++++++---------------
>>>    1 file changed, 113 insertions(+), 43 deletions(-)
>>
>>
>> This matches userspace's incremental handling now. Looks good.
>
> Technically, no.  new_primary_affinity is decoded along with new_weight
> in userspace and crushmap is applied at the very end, after weights and
> states are applied.  AFAICT crushmap is applied last only because of
> the userspace-only adjust_osd_weights(), which needs to have the new
> weights.
>
> As for primary-affinity, the following
>
>      new_up_client: { osd=X, addr=... }
>      new_state: { osd=X, xorstate=EXISTS }
>      new_primary_affinity: { osd=X, aff=Y }
>
> would be misinterpreted - the kernel client would stay on aff=Y instead
> of aff=1 (reset), but I don't see a (obvious, at least) way to get such
> a map, and, as I wanted this to be as small as possible for backporting,
> I punted on that.  Let me know if you see otherwise.

Yeah, I also see no way for this to happen, and it isn't likely to be
needed in the future either. So keeping this update small sounds good
to me.

Josh

