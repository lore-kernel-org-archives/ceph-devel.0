From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: Need some help with the RBD Java bindings
Date: Tue, 20 Aug 2013 14:26:52 -0700
Message-ID: <CA+Hcz58M-fz_qq6ZgEvxovj3OEGF6zG8TSFtsOOMkKUo-YZznw@mail.gmail.com>
References: <520CF90B.2070106@42on.com>
	<CA+Hcz59PTw9u6s8J3pZpbPgyMdh78zd3qzkBmb_+S+w4_JjMOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:34643 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab3HTV0x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Aug 2013 17:26:53 -0400
Received: by mail-ve0-f179.google.com with SMTP id c13so783806vea.24
        for <ceph-devel@vger.kernel.org>; Tue, 20 Aug 2013 14:26:52 -0700 (PDT)
In-Reply-To: <CA+Hcz59PTw9u6s8J3pZpbPgyMdh78zd3qzkBmb_+S+w4_JjMOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Wido,

I pushed up a patch to

   https://github.com/ceph/rados-java/commit/ca16d82bc5b596620609880e429ec9f4eaa4d5ce

That includes a fix for this problem. The fix is a bit hacky, but the
tests pass now. I included more details about the hack in the code.

On Thu, Aug 15, 2013 at 9:57 AM, Noah Watkins <noah.watkins@inktank.com> wrote:
> On Thu, Aug 15, 2013 at 8:51 AM, Wido den Hollander <wido@42on.com> wrote:
>>
>> public List<RbdSnapInfo> snapList() throws RbdException {
>>     IntByReference numSnaps = new IntByReference(16);
>>     PointerByReference snaps = new PointerByReference();
>>     List<RbdSnapInfo> list = new ArrayList<RbdSnapInfo>();
>>     RbdSnapInfo snapInfo, snapInfos[];
>>
>>     while (true) {
>>         int r = rbd.rbd_snap_list(this.getPointer(), snaps, numSnaps);
>
> I think you need to allocate the memory for `snaps` yourself. Here is
> the RBD wrapper for Python which does that:
>
>   self.snaps = (rbd_snap_info_t * num_snaps.value)()
>   ret = self.librbd.rbd_snap_list(image.image, byref(self.snaps),
>                        byref(num_snaps))
>
> - Noah
