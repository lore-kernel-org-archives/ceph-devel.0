From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 7/8] rbd: don't call rbd_osd_req_format_read() for
 !img_data requests
Date: Mon, 26 Sep 2016 18:37:14 +0200
Message-ID: <CAOi1vP-hOGzi-Fit2gd42pfuC3EEYzrYLYLG6iZBUzniv=hsSg@mail.gmail.com>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-8-git-send-email-idryomov@gmail.com> <fc625423-0cf5-d836-176a-0337ab8cfddc@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36602 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422737AbcIZQhQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Sep 2016 12:37:16 -0400
Received: by mail-vk0-f68.google.com with SMTP id v205so2936996vke.3
        for <ceph-devel@vger.kernel.org>; Mon, 26 Sep 2016 09:37:15 -0700 (PDT)
In-Reply-To: <fc625423-0cf5-d836-176a-0337ab8cfddc@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@linaro.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Sep 25, 2016 at 6:44 PM, Alex Elder <elder@linaro.org> wrote:
> On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
>> Accessing obj_request->img_request union field is only valid for object
>> requests associated with an image (i.e. if obj_request_img_data_test()
>> returns true).  rbd_osd_req_format_read() used to do more, but now it
>> just sets osd_req->snap_id.  Standalone and stat object requests always
>> go to the HEAD revision and are fine with CEPH_NOSNAP set by libceph,
>> so get around the invalid union field use by simply not calling
>> rbd_osd_req_format_read() in those places.
>
> Since rbd_osd_req_format_{read,write} are now only called
> from rbd_img_obj_request_fill(), and they're really simple,
> maybe they could be eliminated entirely and open-coded
> instead.  We already have the img_request and osd_req pointers
> in the caller's context.
>
> Stat requests go to the HEAD because they are only involved for
> a layered write, which *cannot* be a snapshot.  I suppose that
> is something that could have been (or be) asserted.

The only reason it's working is img_request->snap_id has the same
offset as obj_request->img_request and we end up setting stat snap_id
to a kernel pointer.  A snapshot with an id like 0xffff...  can't
practically exist, so we get the HEAD response from the OSDs.

>
> Is it guaranteed/required that method calls go to the HEAD?
> I'm sure they all do now, but my question is whether there's
> a good reason that it will *always* be true.  Maybe it is.
>
> Similarly, rbd_obj_read_sync() is currently used only for
> standalone object requests.  But it's conceivable it could
> be useful for image objects.  (I'm not too concerned about
> that though...)
>
> Anwyay, this looks fine.  My reservations are all about
> ensuring these assumptions are clear in the code.  Maybe
> a comment or two is warranted.

libceph initializes snap_id to CEPH_NOSNAP - that's the API.  If the
client isn't setting it, the assumption is clear - HEAD.

Thanks,

                Ilya
