From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: divergent datastructure changes
Date: Thu, 25 Aug 2016 14:41:22 -0700
Message-ID: <CAJ4mKGbHFSquU54yUjB3y99z5XXV6db+vXBkaKBqN4xqHq91WA@mail.gmail.com>
References: <CADRKj5R=dnq6xxGvizTB-_jqfPWaCXnkFCkMsz4_ePppyo8HCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35945 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756199AbcHYVlY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2016 17:41:24 -0400
Received: by mail-ua0-f176.google.com with SMTP id m60so66962600uam.3
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2016 14:41:23 -0700 (PDT)
In-Reply-To: <CADRKj5R=dnq6xxGvizTB-_jqfPWaCXnkFCkMsz4_ePppyo8HCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 25, 2016 at 2:10 PM, Yehuda Sadeh-Weinraub
<yehuda@redhat.com> wrote:
> The encode/decode functionality that we use for [de]marshalling is
> fine, as long as we always move forward. Here's a typical example
> (redacted for simplicity).
>
>   void encode(bufferlist& bl) const {
>     ENCODE_START(8, 1, bl);
>     ::encode(domain_root, bl);
>     ::encode(control_pool, bl);
>     ::encode(gc_pool, bl);
>     ::encode(log_pool, bl);
>     ::encode(intent_log_pool, bl);
>     ::encode(usage_log_pool, bl);
>     ::encode(user_keys_pool, bl);
>     ::encode(user_email_pool, bl);
>     ::encode(user_swift_pool, bl);
>     ::encode(user_uid_pool, bl);
> ...
>     ::encode(system_key, bl);
>     ::encode(placement_pools, bl);
>     ::encode(metadata_heap, bl);
>     ::encode(realm_id, bl);
> ...
>     ENCODE_FINISH(bl);
>   }
>
>   void decode(bufferlist::iterator& bl) {
>     DECODE_START(8, bl);
>     ::decode(domain_root, bl);
>     ::decode(control_pool, bl);
>     ::decode(gc_pool, bl);
>     ::decode(log_pool, bl);
>     ::decode(intent_log_pool, bl);
>     ::decode(usage_log_pool, bl);
>     ::decode(user_keys_pool, bl);
>     ::decode(user_email_pool, bl);
>     ::decode(user_swift_pool, bl);
>     ::decode(user_uid_pool, bl);
> ...
>     if (struct_v >= 3)
>       ::decode(system_key, bl);
>     if (struct_v >= 4)
>       ::decode(placement_pools, bl);
>     if (struct_v >= 5)
>       ::decode(metadata_heap, bl);
>     if (struct_v >= 6) {
>       ::decode(realm_id, bl);
>     }
> ...
>     DECODE_FINISH(bl);
>   }
>
> So the idea is that whenever we add a field, we bump up the encoded
> version, add the field at the end. Decoding is done in order, and we
> test struct_v to determine whether we need to decode the next param.
>
> The main issue I'm having trouble with right now is what to do when we
> need to backport a change that needs a datastructure change. For
> example. in the above example, let's say that we need to backport the
> realm_id field to an older version that was only up to V3.
>
> One solution would be to make sure that when backporting such a
> change, we need to drag with us all the other fields that lead up to
> to the one that we need (e.g., we want realm_id, but we need to bring
> with us also placement_pools, and metadata_heap). This might not be so
> sustainable. The above example might be trivial, but what if
> metadata_heap was not a string, but rather a complex data type that in
> order to build correctly, we need to backport another feature (and
> bring with it the same issues).
>
> It seems to me that for issues like that we might want to consider
> adding a more sophisticated encoding scheme that will be more feature
> oriented, rather than just blindly putting everything one after the
> other.
>
> E.g., some kind of a bit field with offsets into the data, along the
> following lines:
>
> feature.encode(0, system_key);
> feature.encode(1, placement_pools);
> feature.encode(2, metadata_heap);
> ::encode(features, bl);
>
> and on the decoding side:
>
> ::decode(features, bl);
> features.decode(0, system_key);
> features.decode(1, placement_pools);
> features.decode(2, metadata_heap);
>
> In the above example, if we only need metadata_heap, then we can just do this:
>
> ::decode(features, bl);
> features.decode(2, metadata_heap);
>
> The indexes to the fields should be defined appropriately obviously,
> and will be consistent across versions. That should be relatively
> easier to maintain than making sure we keep the data structures
> consistent when having divergent branches I think.
>
> Any thoughts?

This kind of scheme looks like it makes the encoding way fatter in
terms of metadata overhead (adding an offset for every new member,
many of which are offset-sized and repeated constantly in the FS
code), which I'm not comfortable with. I'm not sure if I've run into
this specific problem or not, but generally we've been able to just
blindly encode default values into the backport, or else used feature
bit/CompatSet info to supplement the raw data structure encoding in
determining what to do.
-Greg
