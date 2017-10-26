From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Why does Erasure-pool not support omap?
Date: Thu, 26 Oct 2017 11:49:15 -0400
Message-ID: <CA+aFP1B2LnPxMtrx+XuYNnaLRmVhG_AzuP5QGP6pi8PhzJtNhg@mail.gmail.com>
References: <201710251652060421729@zte.com.cn> <alpine.DEB.2.11.1710251213140.22592@piezo.us.to>
 <37aa304a-f13b-2cf8-c5c5-5d03d37feffa@redhat.com> <CAJ4mKGa+Xpt9a2P0y_cz9bohj7R_hP_Ysiar4oqRgW-yWJY+ug@mail.gmail.com>
 <alpine.DEB.2.11.1710261423200.22592@piezo.us.to> <CA+aFP1CtWxqXR0paxrkYku7+NYK23ncT=ffa-6j4Ft9cfW69Hg@mail.gmail.com>
 <CAKOnarnJp_BVx2ykWz2EsQEzZhQRUw9PGT3Oivss2beJaTTbDw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:55838 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbdJZPtQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Oct 2017 11:49:16 -0400
Received: by mail-yw0-f177.google.com with SMTP id t11so3278299ywg.12
        for <ceph-devel@vger.kernel.org>; Thu, 26 Oct 2017 08:49:16 -0700 (PDT)
In-Reply-To: <CAKOnarnJp_BVx2ykWz2EsQEzZhQRUw9PGT3Oivss2beJaTTbDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjami@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Xie Xingguo <xie.xingguo@zte.com.cn>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 26, 2017 at 11:35 AM, Matt Benjamin <mbenjami@redhat.com> wrote:
> I had the understanding that RGW's use of class methods, which is also
> extensive, would be compatible with this approach.  Is there reason to
> doubt that?

I don't see any "cls_cxx_read" calls in RGW's class methods. Like I
said, assuming the omap class object calls remain synchronous on an
EC-backed pool, omap won't be an issue for RBD but reads will be an
issue (v1 directory, RBD image id objects, and the object map).

> Matt
>
> On Thu, Oct 26, 2017 at 11:08 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>> On Thu, Oct 26, 2017 at 10:26 AM, Sage Weil <sweil@redhat.com> wrote:
>>> On Thu, 26 Oct 2017, Gregory Farnum wrote:
>>>> On Wed, Oct 25, 2017 at 8:57 PM, Josh Durgin <jdurgin@redhat.com> wrote:
>>>> > On 10/25/2017 05:16 AM, Sage Weil wrote:
>>>> >>
>>>> >> Hi Xingguo,
>>>> >>
>>>> >> On Wed, 25 Oct 2017, xie.xingguo@zte.com.cn wrote:
>>>> >>>
>>>> >>>        I wonder why erasure-pools can not support omap currently.
>>>> >>>
>>>> >>>        The simplest way for erasure-pools to support omap I can figure
>>>> >>> out would be duplicating omap on every shard.
>>>> >>>
>>>> >>>        It is because it consumes too much space when k + m gets bigger?
>>>> >>
>>>> >>
>>>> >> Right.  There isn't a nontrivial way to actually erasure code it, and
>>>> >> duplicating on every shard is inefficient.
>>>> >>
>>>> >> One reasonableish approach would be to replicate the omap data on m+1
>>>> >> shards.  But it's a bit of work to implement and nobody has done it.
>>>> >>
>>>> >> I can't remember if there were concerns with this approach or it was just
>>>> >> a matter of time/resources... Josh? Greg?
>>>> >
>>>> >
>>>> > It restricts us to erasure codes like reed-solomon where a subset of shards
>>>> > are always updated. I think this is a reasonable trade-off though, it's just
>>>> > a matter of implementing it. We haven't written
>>>> > up the required peering changes, but they did not seem too difficult to
>>>> > implement.
>>>> >
>>>> > Some notes on the approach are here - just think of 'replicating omap'
>>>> > as a partial write to m+1 shards:
>>>> >
>>>> > http://pad.ceph.com/p/ec-partial-writes
>>>>
>>>> Yeah. To expand a bit on why this only works for Reed-Solomon,
>>>> consider the minimum and appropriate number of copies — and the actual
>>>> shard placement — for local recovery codes. :/ We were unable to
>>>> generalize for that (or indeed for SHEC, IIRC) when whiteboarding.
>>>>
>>>> I'm also still nervous that this might do weird things to our recovery
>>>> and availability patterns in more complex failure cases, but I don't
>>>> have any concrete issues.
>>>
>>> It seems like the minimum-viable variation of this is that we don't change
>>> any of the peering or logging behavior at all, but just send the omap
>>> writes to all shards (like any other write), but only the annointed shards
>>> persist.
>>>
>>> That leaves lots of room for improvement, but it makes the feature work
>>> without many changes, and means we can drop the specialness around rbd
>>> images in EC pools.
>>
>> Potentially negative since RBD relies heavily on class methods.
>> Assuming the cls_cxx_map_XYZ operations will never require async work,
>> there is still the issue with methods that perform straight read/write
>> calls.
>>
>>> Then we can make CephFS and RGW issue warnings (or even refuse) to use EC
>>> pools for their metadata or index pools since it's strictly less efficient
>>> than replicated to avoid user mistakes.
>>>
>>> ?
>>>
>>> sage
>>
>>
>>
>> --
>> Jason
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
>
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-821-5101
> fax.  734-769-8938
> cel.  734-216-5309



-- 
Jason
