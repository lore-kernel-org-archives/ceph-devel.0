From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: libvirt: Removing RBD volumes with snapshots, auto purge or not?
Date: Tue, 20 Aug 2013 19:43:20 +0400
Message-ID: <CABYiri-Z_9sW155BpOzHsSOAfaBmdzW=1DetXVD3-Mz5ESbPdw@mail.gmail.com>
References: <52138CEF.8010109@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:40247 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab3HTPnl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Aug 2013 11:43:41 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so877359obc.12
        for <ceph-devel@vger.kernel.org>; Tue, 20 Aug 2013 08:43:40 -0700 (PDT)
In-Reply-To: <52138CEF.8010109@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Aug 20, 2013 at 7:36 PM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> The current [0] libvirt storage pool code simply calls "rbd_remove" without
> anything else.
>
> As far as I know rbd_remove will fail if the image still has snapshots, you
> have to remove those snapshots first before you can remove the image.
>
> The problem is that libvirt's storage pools do not support listing
> snapshots, so we can't integrate that.
>
> Libvirt however has a flag you can pass down to tell you want the device to
> be zeroed.
>
> The normal procedure is that the device is filled with zeros before actually
> removing it.
>
> I was thinking about "abusing" this flag to use it as a snap purge for RBD.
>
> So a regular volume removal will call only rbd_remove, but when the flag
> VIR_STORAGE_VOL_DELETE_ZEROED is passed it will purge all snapshots prior to
> calling rbd_remove.
>
> Another way would be to always purge snapshots, but I'm afraid that could
> make somebody very unhappy at some point.
>
> Currently "virsh" doesn't support flags, but that could be fixed in a
> different patch.
>
> Does my idea sound sane?
>
> [0]:
> http://libvirt.org/git/?p=libvirt.git;a=blob;f=src/storage/storage_backend_rbd.c;h=e3340f63f412c22d025f615beb7cfed25f00107b;hb=master#l407
>
> --
> Wido den Hollander
> 42on B.V.

Hi Wido,


You had mentioned not so long ago the same idea as I had about a year
and half ago about placing memory dumps along with the regular
snapshot in Ceph using libvirt mechanisms. That sounds pretty nice
since we`ll have something other than qcow2 with same snapshot
functionality but your current proposal does not extend to this.
Placing custom side hook seems much more expandable than putting snap
purge into specific flag.

>
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
