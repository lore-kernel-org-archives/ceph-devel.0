From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: Need some help with the RBD Java bindings
Date: Thu, 15 Aug 2013 09:57:02 -0700
Message-ID: <CA+Hcz59PTw9u6s8J3pZpbPgyMdh78zd3qzkBmb_+S+w4_JjMOg@mail.gmail.com>
References: <520CF90B.2070106@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:59653 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757992Ab3HOQ5E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Aug 2013 12:57:04 -0400
Received: by mail-vc0-f172.google.com with SMTP id m17so664635vca.3
        for <ceph-devel@vger.kernel.org>; Thu, 15 Aug 2013 09:57:03 -0700 (PDT)
In-Reply-To: <520CF90B.2070106@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 15, 2013 at 8:51 AM, Wido den Hollander <wido@42on.com> wrote:
>
> public List<RbdSnapInfo> snapList() throws RbdException {
>     IntByReference numSnaps = new IntByReference(16);
>     PointerByReference snaps = new PointerByReference();
>     List<RbdSnapInfo> list = new ArrayList<RbdSnapInfo>();
>     RbdSnapInfo snapInfo, snapInfos[];
>
>     while (true) {
>         int r = rbd.rbd_snap_list(this.getPointer(), snaps, numSnaps);

I think you need to allocate the memory for `snaps` yourself. Here is
the RBD wrapper for Python which does that:

  self.snaps = (rbd_snap_info_t * num_snaps.value)()
  ret = self.librbd.rbd_snap_list(image.image, byref(self.snaps),
                       byref(num_snaps))

- Noah
