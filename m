From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: Ceph Full-SSD Performance Improvement
Date: Wed, 22 Oct 2014 11:35:29 +0800
Message-ID: <CAMm-wc+yr4hBrKCD-fwyxUA+pkdewiDjS6R7hv=y5F5PaZhKvg@mail.gmail.com>
References: <CACJqLyZ3-3UOkmGLw973_JCJ9=32K7NvbJks72+8Zs-j1LtwOA@mail.gmail.com>
	<alpine.DEB.2.00.1410210836410.13498@cobra.newdream.net>
	<CACJqLyY94fGhtKfHkwn3qMv1s_sWC-qGofxG7ZjY48QJSH3NzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:42010 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbaJVDfa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Oct 2014 23:35:30 -0400
Received: by mail-vc0-f178.google.com with SMTP id hq12so1401297vcb.9
        for <ceph-devel@vger.kernel.org>; Tue, 21 Oct 2014 20:35:29 -0700 (PDT)
In-Reply-To: <CACJqLyY94fGhtKfHkwn3qMv1s_sWC-qGofxG7ZjY48QJSH3NzQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Samuel Just <sam.just@inktank.com>, icolle@redhat.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 22 October 2014 11:09, Haomai Wang <haomaiwang@gmail.com> wrote:
> [cc to ceph-devel]
>
>
>
> On Tue, Oct 21, 2014 at 11:51 PM, Sage Weil <sage@newdream.net> wrote:
>> Hi Haomai,
>>
>> You and your team have been doing great work and I'm very happy that you
>> are working with Ceph!  The performance gains you've seen are very
>> encouraging.
>>
>>> 1. Use AsyncMessenger for both client and OSD
>>
>> I would like to get this into the tree.  I made a few cosmetic changes and
>> pushed a wip-msgr into ceph.git to make sure it builds okay.  Once giant
>> is out we can mix this into the QA.
>>
>>> 2. Use ObjectContext Cache
>>
>> I saw an earlier version of this that didn't break things down per-PG;
>> have Sam's comments been addressed?  IIRC the most recent issue was that
>> the cache was reset in PG::start_peering_interval.
>>
>> This should make a big difference.  +1 :)

I pull the new version of this feature last week, see #2664.

>>
>>> 3. Avoid extra calculates for pg layers
>>
>> I haven't seen this one?

see #2667, #2579. 10us+ reduced

And "Keep osd opwq worker wake for following op #2727" make OpWQ
latency less in some cases.


>>
>>> I hope ceph can make complete with commercial storage system, so how
>>> to make ceph shorter latency is my main concern.
>>>
>>> Over the year, I dive into the full ceph IO stacks from librbd down to
>>> FileStore. Besides the attempts mentioned above, I think the main
>>> throttle will be encode/decode which is existed in Messenger and
>>> ObjectStore transactions.
>>>
>>> At first FileStore will directly accept inputs without bufferlist
>>> encode/decodes. Now I try to send MOSDOP's payload directly to
>>> replicate PG and avoid overall ObjectStore::Transaction which is used
>>> by replicated pg. Replicated PG maybe need calculate again but as we
>>> performed the main consuming time in PG layer is transaction
>>> encode/decode. KeyValueStore and FileStore will both happy  to adopt
>>> it. Then main IO logic such as read/write ops won't need
>>> encode/decode.
>>
>> Can you send a message to ceph-devel with a bit more detail?  We used to
>> do this, actually (prepare the transaction on the replicas instead of
>> encoding the one from the primary) but it was a bit less flexible when it
>> came to the object classes (which might not be deterministic).
>>
>> I agree that encode/decode is a serious issue, but before
>> avoiding it for transations I'd like to see what Matt Benjamin
>> is able to accomplish with his changes, or look at ways to
>> make transaction encoding in particular more efficient (e.g.
>> with fixed size structures).  Also, you might be interested in
>>
>>         https://wiki.ceph.com/Planning/Blueprints/Hammer/osd%3A_update_Transaction_encoding
>
> Hmm, I try to understand the meaning. Is this BP want to make
> ObjectStore::Transaction more flexible and make ObjectStore's
> successors can easily aware of the data layout in transaction. I try
> to summary the performance optimization for this bp:
>
> 1. FileStore/KeyValueStore can aware of the size of write data and do
> something special for it, it would be nice for large file
> 2. A complexity transaction which contains several ops for one object,
>  the redundancy lookups will be reduced
>
> But the actual consuming time component I think is transaction
> encode/decode. Especially encode/decode for ghobject_t and collection
> structure.
>
> Combine with Message encode/decode, as I performed encode/decode
> logics plays a important role for the latency of op. I want to explain
> what I want to do:
>
> All Messages will be restructured and have a common header. All
> members in Message will be fixed. I know some critical member such as
> ghobject_t or anything else will be hard to decisive. So on the
> Messenger side, ghobject_t or other flexible structure will have
> separated structure, like ghobject_t will be translated to
> Message::object which will packed into a fixed size memory. So
> Messenger can directly pick up structures in messages without memory
> copy and parsing. And on the side of PG layer,
> ObjectStore::Transaction will be refactored to a simple class. A list
> of ops will describe the sequences and all data will be referenced
> directly which is used in PG layer. It maybe let ObjectStore's
> successors less flexible but it's still has space to modify. For
> subop, the raw message from client will be validated in primary pg and
> add some infos necessary inser into the fixed position of the message
> and populate to replicate PG.
>
> Plz correct me if exists awful point.
>
>>
>>> Next, I hope we can refactor a new Message protocol. The main pain is
>>> that New Message protocol won't compatible with older. Each message is
>>> expected to have a common header, the memory layout for data in
>>> Message will be forced aligned and used. It's expected to discard
>>> overall message encode/decode which is main throttle in
>>> AsyncMessenger. And with new Messenger, SUBOP can be directly
>>> constructed via common header. So the overall encode/decode logics can
>>> be discard for the new Message layout.
>>
>> I'm also open to changes here, as long as we can make it somewhat
>> transaprent to the user (perhaps only use it on the backend network, or
>> even better, detect/negotiate the protocol for backward compatibility).
>> But I think in general we can probably constrain the problem: it is only
>> the MOSD[Sub]Op[Reply] messages that have a real impact here, so we can
>> probably focus on changing just those message's encoding.  (Is that what
>> you're suggesting?)
>>
>> Thanks!
>> sage
>>
>
>
>
> --
> Best Regards,
>
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Dong Yuan
Email:yuandong1222@gmail.com
