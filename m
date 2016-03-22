From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Tue, 22 Mar 2016 11:46:02 -0700
Message-ID: <CAJ4mKGZ+c8PTcqnUiAa1f4jCnrk=pw81QU4j8M__hy0qR477Fg@mail.gmail.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com>
	<1454742006-85706-3-git-send-email-zyan@redhat.com>
	<CAOi1vP8SrL71Q34W4b_ZDUkTNyi-UtDstgrTjnjq9fGE=VMa_g@mail.gmail.com>
	<4C995660-CB5D-4E26-9947-988D65BEAA3A@redhat.com>
	<CAOi1vP-g9kj6B-Fmv7cBzjfrnoSrnGuVZyB+b0K-CmpLPd6xbw@mail.gmail.com>
	<040FA762-A7C8-47FE-A72B-03419C79C782@redhat.com>
	<CAOi1vP_v=iev1vQQrxGFYU2y7uTV1_imV5MkwqMgBQUCf2GnEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36073 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbcCVSqD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 14:46:03 -0400
Received: by mail-vk0-f53.google.com with SMTP id z68so31511432vkg.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Mar 2016 11:46:02 -0700 (PDT)
In-Reply-To: <CAOi1vP_v=iev1vQQrxGFYU2y7uTV1_imV5MkwqMgBQUCf2GnEg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Tue, Mar 22, 2016 at 9:13 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Tue, Mar 22, 2016 at 2:57 PM, Yan, Zheng <zyan@redhat.com> wrote:
>>>>> I don't like the idea of sharing namespace name strings between libceph
>>>>> and ceph modules, especially with the strings themselves hosted in
>>>>> libceph.  rbd has no use for namespaces, so libceph can live with
>>>>> namespace names embedded into ceph_osd_request by value or with
>>>>> a simple non-owning pointer, leaving reference counting to the outside
>>>>> modules, if one of the use cases is "one namespace with a long name for
>>>>> the entire directory tree" or something close to it.
>>>>>
>>>>> I think the sharing infrastructure should be moved into cephfs, and
>>>>> probably changed to share entire file layouts along the way.  I don't
>>>>> know this code well enough to be sure, but it seems that by sharing
>>>>> file layouts and making ci->i_layout an owning pointer you might be
>>>>> able to piggy back on i_ceph_lock and considerably simplify the whole
>>>>> thing by dropping RCU and eliminating numerous get/put calls.
>>>>
>>>> RBD may use namespace later.
>>>> http://tracker.ceph.com/projects/ceph/wiki/Rbd_-_namespace_support
>>>
>>> Well, compared to cephfs, it's hard to call that "using" - in that
>>> case, there will only ever be one namespace per image.  My point is
>>> it's never going to use the string sharing infrastructure and is fine
>>> with a non-owning pointer to a string in the file layout field of the
>>> in-memory rbd image header.
>>>
>>>>
>>>> The reason I use RCU here is that ci->i_layout.pool_ns can change at
>>>> any time. For the same reason, using non-owning pointer for namespace
>>>> or entire layout is unfeasible. Using embedded namespace is not
>>>> elegant either. When allocating ceph_osd_request, cephfs needs to
>>>> lock i_ceph_lock, copy namespace to a temporary buffer, unlock
>>>> i_ceph_lock, pass ci->i_layout and the temporary buffer to the
>>>> ceph_osdc_xxx_request().
>>>
>>> Hmm, RCU doesn't protect you from pool_ns or other file layout fields
>>> changing while the OSD request is in flight.  As used above, it allows
>>> ceph_try_get_string() to not take any locks and that's it.
>>
>> Yes.  But not taking lock simplify the code a lot.  we don't need to
>> lock/unlock i_ceph_lock each time i_layout is used.
>
> I wouldn't call a bunch of rcu_dereference_* variants sprinkled around
> the code base a simplification, but, more importantly, is keeping the
> pool_ns pointer valid really all you need?  Shouldn't there be some
> kind of synchronization around "OK, I'm switching to a new layout for
> this inode"?  As it is, pool_ns is grabbed in ceph_osdc_new_request(),
> with two successive calls to ceph_osdc_new_request() potentially ending
> up with two different namespaces, e.g. ceph_uninline_data().

I haven't looked at the code at all, but this part is really confusing
me. Namespaces can't be changed arbitrarily, but when they are, a
subsequent write really needs to use the updated namespace! It needs
an atomic switch, not a lazy update. Is there some point at which
out-of-date users get updated prior to actually sending off OSD ops?
-Greg
