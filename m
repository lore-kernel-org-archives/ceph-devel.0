From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: snapshot of rbd
Date: Sun, 12 Jun 2011 10:17:41 -0700
Message-ID: <BANLkTikF2rO2Ot8wV6pRNsMLHcJ3NucfTg@mail.gmail.com>
References: <BANLkTimpfh-oMyhVJLj6Pry74kFEKJG7nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51428 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab1FLRRn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Jun 2011 13:17:43 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 822A9C798
	for <ceph-devel@vger.kernel.org>; Sun, 12 Jun 2011 10:17:43 -0700 (PDT)
Received: from mail-bw0-f46.google.com (mail-bw0-f46.google.com [209.85.214.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2A3E0C794
	for <ceph-devel@vger.kernel.org>; Sun, 12 Jun 2011 10:17:43 -0700 (PDT)
Received: by bwz15 with SMTP id 15so3223397bwz.19
        for <ceph-devel@vger.kernel.org>; Sun, 12 Jun 2011 10:17:41 -0700 (PDT)
In-Reply-To: <BANLkTimpfh-oMyhVJLj6Pry74kFEKJG7nA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Jun 12, 2011 at 7:02 AM, Simon Tian <aixt2006@gmail.com> wrote:
>
> hi guys,
>
> =A0 =A0I have some questions about librbd snapshot:
>
> =A0int snap_create(const char *snapname);
> =A0int snap_remove(const char *snapname);
> =A0int snap_rollback(const char *snap_name);
> =A0int snap_set(const char *snap_name);
>
> =A0int copy(IoCtx& src_io_ctx, const char *srcname, IoCtx& dest_io_ct=
x,
> const char *destname);
>
> If I create a snapshot S1, and then write 10GB data, and then I want
> to create a snapshot S2. About how long time will the "snap_create"
> take? =A0May take just several seconds?

Yes. It updates the header, and sends notifications (through the osd)
to the other clients.

> And how long will it task when remove S2?

Same as creating it.


> How long when rollback to S1?

Rollback is (currently) is in the order of the number of object of
that image. It needs to go through all the objects and execute an
explicit request of each. For very large images it can be quite long.

> How long when set to S1?

Setting the snapshot context is instantaneous, client-side only operati=
on.

>
> When I open snapshot S2 as an io_ctx, and copy it with the copy
> interface, how long time will it spent?
>

Should be similar to rollback.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
