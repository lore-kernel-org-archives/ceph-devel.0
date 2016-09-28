From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Detect memory leaks in ceph
Date: Tue, 27 Sep 2016 23:51:55 -0700
Message-ID: <CAJ4mKGaHG8fnTRNN+WWHy=Ag5KwQbXRdKXCgoLLoBC+svTcM1g@mail.gmail.com>
References: <CAA8xDw295OV5LoR4wwGixofoNmrTfgOsjbpw1RzyKMGRmqk=ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35830 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbcI1Gv4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2016 02:51:56 -0400
Received: by mail-io0-f172.google.com with SMTP id 92so40408753iol.2
        for <ceph-devel@vger.kernel.org>; Tue, 27 Sep 2016 23:51:56 -0700 (PDT)
In-Reply-To: <CAA8xDw295OV5LoR4wwGixofoNmrTfgOsjbpw1RzyKMGRmqk=ag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elita Lobo <loboelita@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 27, 2016 at 10:21 PM, Elita Lobo <loboelita@gmail.com> wrote:
> Hi,
>
> I am using ceph for a research project and was trying to implement a
> new jerasure plugin. The code works perfectly when I try to put small
> objects ( 16Mb files) in a single pg but breaks when I am trying to
> put some really large object in a cluster having multiple pgs. I am
> pretty sure its a memory leak but not sure how to detect it.

How big are these "really large object"s? Erasure coding can handle
much bigger objects than replication does, but there are still limits
beyond which stuff will go poorly.
-Greg

>
> Can someone please suggest some tools that would help me  detect
> memory leaks in ceph?
>
> Thanking you,
> Yours sincerely,
> Elita Lobo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
