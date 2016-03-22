From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Tue, 22 Mar 2016 12:00:12 +0100
Message-ID: <CAOi1vP-g9kj6B-Fmv7cBzjfrnoSrnGuVZyB+b0K-CmpLPd6xbw@mail.gmail.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com>
	<1454742006-85706-3-git-send-email-zyan@redhat.com>
	<CAOi1vP8SrL71Q34W4b_ZDUkTNyi-UtDstgrTjnjq9fGE=VMa_g@mail.gmail.com>
	<4C995660-CB5D-4E26-9947-988D65BEAA3A@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34753 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758785AbcCVLAO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 07:00:14 -0400
Received: by mail-lb0-f195.google.com with SMTP id vk4so14181459lbb.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Mar 2016 04:00:13 -0700 (PDT)
In-Reply-To: <4C995660-CB5D-4E26-9947-988D65BEAA3A@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Tue, Mar 22, 2016 at 10:17 AM, Yan, Zheng <zyan@redhat.com> wrote:
>
>> On Mar 22, 2016, at 14:05, Ilya Dryomov <idryomov@gmail.com> wrote:

[ snip ]

>> Hi Zheng,
>>
>> A one and a half line commit message and an equally short cover letter
>> for a series such as this isn't enough.  I *happen* to know that the
>> basic use case for namespaces in cephfs is going to be restricting
>> users to different parts of the directory tree, with the enforcement
>> happening in ceph on the server side, as opposed to in ceph on the
>> client side, but I would appreciate some details on what the actual
>> namespace names are going to be, whether it's user input or not,
>> whether there are plans to use namespaces for anything else, etc.
>>
>
> The namespace restriction you mentioned is for cephfs metadata. This
> namespace is restricting users to different namespaces in cephfs data
> pool. (At present, the only way to restrict data access is, creating
> multiple cephfs data pools, restrict users to different data pool.
> Creating lost of pools is not efficient for the cluster)

What about the namespace names, who is generating them, how long are
they going to be?  Please describe in detail how this is going to work
for both data and metadata pools.

>
>
>> I don't like the idea of sharing namespace name strings between libceph
>> and ceph modules, especially with the strings themselves hosted in
>> libceph.  rbd has no use for namespaces, so libceph can live with
>> namespace names embedded into ceph_osd_request by value or with
>> a simple non-owning pointer, leaving reference counting to the outside
>> modules, if one of the use cases is "one namespace with a long name for
>> the entire directory tree" or something close to it.
>>
>> I think the sharing infrastructure should be moved into cephfs, and
>> probably changed to share entire file layouts along the way.  I don't
>> know this code well enough to be sure, but it seems that by sharing
>> file layouts and making ci->i_layout an owning pointer you might be
>> able to piggy back on i_ceph_lock and considerably simplify the whole
>> thing by dropping RCU and eliminating numerous get/put calls.
>
> RBD may use namespace later.
> http://tracker.ceph.com/projects/ceph/wiki/Rbd_-_namespace_support

Well, compared to cephfs, it's hard to call that "using" - in that
case, there will only ever be one namespace per image.  My point is
it's never going to use the string sharing infrastructure and is fine
with a non-owning pointer to a string in the file layout field of the
in-memory rbd image header.

>
> The reason I use RCU here is that ci->i_layout.pool_ns can change at
> any time. For the same reason, using non-owning pointer for namespace
> or entire layout is unfeasible. Using embedded namespace is not
> elegant either. When allocating ceph_osd_request, cephfs needs to
> lock i_ceph_lock, copy namespace to a temporary buffer, unlock
> i_ceph_lock, pass ci->i_layout and the temporary buffer to the
> ceph_osdc_xxx_request().

Hmm, RCU doesn't protect you from pool_ns or other file layout fields
changing while the OSD request is in flight.  As used above, it allows
ceph_try_get_string() to not take any locks and that's it.

Why exactly can't file layouts be shared?  ci->i_layout would become
reference counted and you would give libceph a pointer to the pool_ns
string (or entire layout) after bumping it.  It doesn't matter if
pool_ns or the rest of the layout changes due to a cap grant or revoke
while libceph is servicing the OSD request: you would unlink it from
the tree but the bumped reference will keep the layout around, to be
put in the OSD request completion callback or so.  Layout lookup would
have to happen in exactly two places: when newing an inode and handling
cap grant/revoke, in other places you would simply bump the count on
the basis of already holding a valid pointer.  You wouldn't have to
unlink in the destructor, so no hassle with kref_get_unless_zero() and
no need for RCU, with i_ceph_lock providing the exclusion around the
tree.

Like I said, I'm not familiar with the code in question at the
necessary level of detail, so feel free to destroy this, but I don't
see a problem.

Thanks,

                Ilya
