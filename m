From: Tommi Virtanen <tv@inktank.com>
Subject: Re: RBD layering design draft
Date: Mon, 18 Jun 2012 10:00:32 -0700
Message-ID: <CADvuQRH0J2y2-G5wWbaUiHy79y_H=wMBLnyW1ZKNdo8J2aSiKw@mail.gmail.com>
References: <4FDB9FBB.9000807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41203 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab2FRRAw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 13:00:52 -0400
Received: by pbbrp8 with SMTP id rp8so8461848pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 10:00:52 -0700 (PDT)
In-Reply-To: <4FDB9FBB.9000807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 15, 2012 at 1:48 PM, Josh Durgin <josh.durgin@inktank.com> =
wrote:
> =C2=A0 =C2=A0$ rbd unpreserve pool/image@snap
> =C2=A0 =C2=A0Error unpreserving: child images rely on this image

UX nit: this should also say what image it found.

rbd: Cannot unpreserve: Still in use by pool2/image2

> =C2=A0 =C2=A0$ rbd list_children pool/image@snap
> =C2=A0 =C2=A0pool2/child1
> =C2=A0 =C2=A0pool2/child2

How about just "rbd children"? Especially the underscore makes me unhap=
py.

> =C2=A0 =C2=A0$ rbd copyup pool2/child1

Does "copyup" make sense to everyone? Every time you say it, my brain
needs to flip the image inside the other way around -- I naturally
imagine a tree with the parent at the top, and children and
grandchildren down from it, but then I can't call that operation
"copyup" without wrecking my mental image.

I also can't seem to google good evidence that the term would be in
widespread use in the enterprisey block storage world, outside of the
unionfs world.. What do people call the un-dedupping, un-thinning of
copy-on-write thin provisioning?

"unshare"?

> In addition to knowing which parent a given image has, we want to be
> able to tell if a preserved image still has children. This is
> accomplished with a new per-pool object, `rbd_children`, which maps
> (parent pool, parent id, parent snapshot id) to a list of child
> image ids.

So the omap value is a list, and you need to support atomic add/remove
on the list members? Are you thinking of using an rbd class method
that does read-modify-write for that?

My instincts would have gone for (parent_pool, parent_id,
parent_snapshot_id, child_id) -> None, to get atomic operations for
free.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
