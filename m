From: Samuel Just <sam.just@inktank.com>
Subject: Re: Rados consistency model
Date: Tue, 18 Dec 2012 14:22:30 -0800
Message-ID: <CA+4uBUYSTksNfFHHGC_4AjWs-_RB45bHiSt2GizO3TgbXTtw=A@mail.gmail.com>
References: <kapapl$ud5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:44542 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab2LRWqA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Dec 2012 17:46:00 -0500
Received: by mail-ee0-f52.google.com with SMTP id d17so657102eek.11
        for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 14:45:59 -0800 (PST)
In-Reply-To: <kapapl$ud5$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

You can expect read-after-write on any object.  That is, once the
write is complete, any subsequent reader will see the result.
-Sam

On Tue, Dec 18, 2012 at 12:51 AM, Rutger ter Borg <rutger@terborg.net> wrote:
>
> Dear list,
>
> I have a question regarding concurrency guarantees of Rados. Suppose I have
> two nodes, say A and B, both running a process, and both using the same
> rados storage pool, maybe connected through different OSDs. Suppose node A
> updates an object in the storage pool, and after completion immediately
> notifies B (through its own messaging layer) that that specific object has
> been updated. Then, can I assume that, if B re-reads that object, it will
> always get the updated one? If not, what would be the recommended way of
> notifying B?
>
> IOW, what kind of consistency model should I assume?
>
> Thanks,
>
> Rutger
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
