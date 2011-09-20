From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: radosgw question
Date: Tue, 20 Sep 2011 06:48:47 -0700
Message-ID: <CAC-hyiGS=gJzipxYhUp+wbdC+Et0F5TexL76futvCa-3ybMNrg@mail.gmail.com>
References: <CANExM-Mfy4braUiwMp1GC29d4fAeH933X_oLhJ2hd+AigukbFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63154 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab1ITNst (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2011 09:48:49 -0400
Received: by bkbzt4 with SMTP id zt4so480831bkb.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2011 06:48:47 -0700 (PDT)
In-Reply-To: <CANExM-Mfy4braUiwMp1GC29d4fAeH933X_oLhJ2hd+AigukbFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 20, 2011 at 1:36 AM, Henry C Chang <henry.cy.chang@gmail.com> wrote:
> Hi,
>
> I have a question about the radosgw.
>
> The radosgw uses an object to record the buckets owned by one user
> account. However, suppose that the user account is shared by multiple
> users, and these users connect to the radosgw concurrently. If, say,
> user A creates bucket B1 and user B deletes bucket B2 at the same
> time, they will both update the object. Since it seems radosgw has no
> lock mechanism for object update, the problems would occurs - either
> the created bucket will be lost or the deleted bucket can still be
> listed but dne actually.
>
> I know it may be a rare case, just wondering if there is away to
> handle this situation.
>

The RADOS gateway uses RADOS tmap atomic operations for modifying this
object. The tmap operations allows it to either add, remove, or modify
entries in this object without the need for locking and without
possible race conditions.

Yehuda
