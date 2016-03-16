From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Bumping my jenkins builds to the wall in radable.sh
Date: Wed, 16 Mar 2016 12:34:56 -0700
Message-ID: <CAJ4mKGY0ev0Du5JXj1JJTCX5hgp=mui1VN+egBV_XUZYTdGy8A@mail.gmail.com>
References: <56E9A585.9000309@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35557 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbcCPTfA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 15:35:00 -0400
Received: by mail-vk0-f50.google.com with SMTP id e6so75240633vkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2016 12:34:59 -0700 (PDT)
In-Reply-To: <56E9A585.9000309@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>

On Wed, Mar 16, 2016 at 11:27 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>
> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketEnt
>
> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketInfo
> error: buffer::end_of_buffer
> **** failed to decode
> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketInfo/25f5ff183bba6da708243a0bbbe40a2e
> ****
> error: buffer::end_of_buffer
> **** failed to decode
> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/RGWBucketInfo/54f53e3e301071f48247d59272b27b53
> ****
>
> ../ceph-object-corpus/archive/0.61.4-60-g24c59be/objects/rgw_bucket_pending_info
>
> "Just" a matter of rebase?
> Or does it need more tinkering.

Well, ceph-object-corpus is a bunch of old encoded versions of our
objects, and it's validating that current code is still capable of
decoding them. 0.61.4 is pretty old but I *think* should still work
(maybe check that your submodules are all up to date; maybe some of
them got dropped?). Assuming that still works on Linux, it's not a
rebase problem; I would guess maybe these types just never worked
because it wasn't BSD cross-compatible until more recently. You might
want to explore how they're failing exactly; obviously it's running
out of data to decode but the *why* is interesting.
-Greg
