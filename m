From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: design a rados-based distributed kv store support scan op
Date: Tue, 30 Sep 2014 21:35:21 +0800
Message-ID: <CAAM7YAn9QXR8tqerwLSELFLJVCY4SrMb3+xVrNR3PbMF4dpW_g@mail.gmail.com>
References: <CAJu7gM0T0nMjFtnPKh1ZT+BjV_-OOWmB6X0zQDUwGkmGfM0uPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:62149 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbaI3NfZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 09:35:25 -0400
Received: by mail-lb0-f173.google.com with SMTP id l4so628733lbv.4
        for <ceph-devel@vger.kernel.org>; Tue, 30 Sep 2014 06:35:23 -0700 (PDT)
In-Reply-To: <CAJu7gM0T0nMjFtnPKh1ZT+BjV_-OOWmB6X0zQDUwGkmGfM0uPA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Plato Zhang <sangongs@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 30, 2014 at 5:23 PM, Plato Zhang <sangongs@gmail.com> wrote:
> Hi all,
>
> We plan to develop a new distributed key-value storage engine, which
> would based on rados and supoort range-scan operation. Besides, it'll
> be open source.
>
> We know rados is already a kv storage engine, and can do pretty well
> if we use KeyValueStore.
> However, it lacks the ability of scanning a key range, since keys are
> hashed into pgs.
>
> In our scenarios, scanning is a common need. We considered the way of
> splitting our key space into fixed number of ranges, mapping each
> range to a rados object, and then storing key/value pairs in rados
> objects. However, there are two main disadvantages:
> 1. We can not adjust the number of ranges as the cluster scales.
> 2. For a good splitting, we must properly predict the distribution of
> keys, or we'll encounter serious load-balance problem.
>
> So we decide to develop a new service based on rados (we want to use
> rados for unifying our storage infrastructure).
>
> Before we start, we want to do some inquiries:
> 1. Is there already any similar system/module(scan-supported &&
> rados-based) existed?

FYI:
directory fragments in MDS satisfy all above requirement.  but the code
is not  general enough to be used outside MDS



> 2. Except for the basic key-value functions, what features are you
> most interested in?
> 3. Other suggestions?
>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
