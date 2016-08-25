From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: divergent datastructure changes
Date: Thu, 25 Aug 2016 14:59:28 -0700
Message-ID: <CADRKj5Twj_+exCvm+R4eYmSMLFMTYLUxaHGNgtk_6qCQRds0bQ@mail.gmail.com>
References: <CADRKj5R=dnq6xxGvizTB-_jqfPWaCXnkFCkMsz4_ePppyo8HCQ@mail.gmail.com>
 <alpine.DEB.2.11.1608252128560.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36086 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755250AbcHYV7j (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2016 17:59:39 -0400
Received: by mail-ua0-f170.google.com with SMTP id m60so67620770uam.3
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2016 14:59:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608252128560.25681@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 25, 2016 at 2:32 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 25 Aug 2016, Yehuda Sadeh-Weinraub wrote:
>> The encode/decode functionality that we use for [de]marshalling is
>> fine, as long as we always move forward. Here's a typical example
>> (redacted for simplicity).
>>
>>   void encode(bufferlist& bl) const {
>>     ENCODE_START(8, 1, bl);
>>     ::encode(domain_root, bl);
>>     ::encode(control_pool, bl);
>>     ::encode(gc_pool, bl);
>>     ::encode(log_pool, bl);
>>     ::encode(intent_log_pool, bl);
>>     ::encode(usage_log_pool, bl);
>>     ::encode(user_keys_pool, bl);
>>     ::encode(user_email_pool, bl);
>>     ::encode(user_swift_pool, bl);
>>     ::encode(user_uid_pool, bl);
>> ...
>>     ::encode(system_key, bl);
>>     ::encode(placement_pools, bl);
>>     ::encode(metadata_heap, bl);
>>     ::encode(realm_id, bl);
>> ...
>>     ENCODE_FINISH(bl);
>>   }
>>
>>   void decode(bufferlist::iterator& bl) {
>>     DECODE_START(8, bl);
>>     ::decode(domain_root, bl);
>>     ::decode(control_pool, bl);
>>     ::decode(gc_pool, bl);
>>     ::decode(log_pool, bl);
>>     ::decode(intent_log_pool, bl);
>>     ::decode(usage_log_pool, bl);
>>     ::decode(user_keys_pool, bl);
>>     ::decode(user_email_pool, bl);
>>     ::decode(user_swift_pool, bl);
>>     ::decode(user_uid_pool, bl);
>> ...
>>     if (struct_v >= 3)
>>       ::decode(system_key, bl);
>>     if (struct_v >= 4)
>>       ::decode(placement_pools, bl);
>>     if (struct_v >= 5)
>>       ::decode(metadata_heap, bl);
>>     if (struct_v >= 6) {
>>       ::decode(realm_id, bl);
>>     }
>> ...
>>     DECODE_FINISH(bl);
>>   }
>>
>> So the idea is that whenever we add a field, we bump up the encoded
>> version, add the field at the end. Decoding is done in order, and we
>> test struct_v to determine whether we need to decode the next param.
>>
>> The main issue I'm having trouble with right now is what to do when we
>> need to backport a change that needs a datastructure change. For
>> example. in the above example, let's say that we need to backport the
>> realm_id field to an older version that was only up to V3.
>>
>> One solution would be to make sure that when backporting such a
>> change, we need to drag with us all the other fields that lead up to
>> to the one that we need (e.g., we want realm_id, but we need to bring
>> with us also placement_pools, and metadata_heap). This might not be so
>> sustainable. The above example might be trivial, but what if
>> metadata_heap was not a string, but rather a complex data type that in
>> order to build correctly, we need to backport another feature (and
>> bring with it the same issues).
>
> In the past we've just dragged the other fields with us.  I can only
> recall this happening a handful of times.  I try to put any new fields
> into a separate commit with *just* the data structure changes so that
> (among other things) it can be easily backported without dragging anything
> else along with it.

Right. It's a delicate job, and it only gets complicated when dealing
with multiple versions, not necessarily going at the same direction.

>
>> It seems to me that for issues like that we might want to consider
>> adding a more sophisticated encoding scheme that will be more feature
>> oriented, rather than just blindly putting everything one after the
>> other.
>>
>> E.g., some kind of a bit field with offsets into the data, along the
>> following lines:
>>
>> feature.encode(0, system_key);
>> feature.encode(1, placement_pools);
>> feature.encode(2, metadata_heap);
>> ::encode(features, bl);
>>
>> and on the decoding side:
>>
>> ::decode(features, bl);
>> features.decode(0, system_key);
>> features.decode(1, placement_pools);
>> features.decode(2, metadata_heap);
>>
>> In the above example, if we only need metadata_heap, then we can just do this:
>>
>> ::decode(features, bl);
>> features.decode(2, metadata_heap);
>>
>> The indexes to the fields should be defined appropriately obviously,
>> and will be consistent across versions. That should be relatively
>> easier to maintain than making sure we keep the data structures
>> consistent when having divergent branches I think.
>
> This seems useful if we need to backport things out of order, but how
> often does that really happen?  The cost is some CPU time during decoding,
> incurred for every encode/decode for all time, to cover a case that should
> be pretty rare.
>
> Have we need a case where the intervening fields are complex data
> structure(s) and difficult to backport?
>

We managed pretty fine when mainly going forward. However, this limits
our ability to backport complex fixes and/or entire set of features.
As I said earlier, keeping the current scheme is possible, but having
the need to maintain divergent versions it makes our lives much more
complicated.
I'm well aware of the impact on both performance and structure sizes.
We can maybe limit this scheme to just deal with encoding of distinct
set of changes that we know we'd need to backport (we need to know it
in advance anyway here), and continue with the current method as is.

Yehuda
