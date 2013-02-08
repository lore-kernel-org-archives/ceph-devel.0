From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: cgroups to prevent OSD from taking down a whole machine
Date: Fri, 8 Feb 2013 17:55:18 +0300
Message-ID: <CABYiri8bKon4ucid3J08ys+PTN9pKCqK8BJju2EpKLw2Y82XkA@mail.gmail.com>
References: <51150FCE.7050501@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:47998 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758328Ab3BHOzj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 09:55:39 -0500
Received: by mail-ve0-f178.google.com with SMTP id db10so3377074veb.9
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 06:55:38 -0800 (PST)
In-Reply-To: <51150FCE.7050501@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Feb 8, 2013 at 6:46 PM, Wido den Hollander <wido@widodh.nl> wrote:
> Hi,
>
> Has anybody tried this yet?
>
> Running into the memory leaks during scrubbing[0] I started thinking about a
> way to limit OSDs to a specific amount of memory.
>
> A machine has 32GB of memory, 4 OSDs, so you might want to limit each OSD to
> 8GB so it can't take the whole machine down and would only kill itself.
>
> I think I'll give it a try on a couple of machines, but I just wanted to see
> if anybody has tried this already or sees any downsides to this?
>

Yep, it works fine, although I`d recommend to take a look to an
oom-delay patch to handle oom situations inside cg more nicely. And of
course you`ll pay for memory cg usage by some percents of overall node
performance.

> We use cgroups in the CloudStack project (through libvirt) to prevent that a
> memory leak in one KVM proces can take down a whole hypervisor, it works
> pretty well there.
>
> Suggestions or comments?
>
> Wido
>
> [0]: http://tracker.ceph.com/issues/3883
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
