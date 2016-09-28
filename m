From: Elita Lobo <loboelita@gmail.com>
Subject: Fwd: Detect memory leaks in ceph
Date: Wed, 28 Sep 2016 12:35:54 +0530
Message-ID: <CAA8xDw2khY4in5HGNrPuSnOX-cB0uFDO1bfV3uDOEygzjA7D-w@mail.gmail.com>
References: <CAA8xDw295OV5LoR4wwGixofoNmrTfgOsjbpw1RzyKMGRmqk=ag@mail.gmail.com>
 <CAJ4mKGaHG8fnTRNN+WWHy=Ag5KwQbXRdKXCgoLLoBC+svTcM1g@mail.gmail.com> <CAA8xDw3pf5nw294TUaH-3w-AiA+w16AwrLLorq341Z7U40nR8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35317 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750804AbcI1HFz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2016 03:05:55 -0400
Received: by mail-ua0-f176.google.com with SMTP id q42so30345427uaq.2
        for <ceph-devel@vger.kernel.org>; Wed, 28 Sep 2016 00:05:55 -0700 (PDT)
In-Reply-To: <CAA8xDw3pf5nw294TUaH-3w-AiA+w16AwrLLorq341Z7U40nR8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com

Hi,

@Varada , Abioy : Thanks a lot, will check it out. :)

@gregory Farnum,Trying to store 10k 64MB objects on 30 PGs. Reed
solomon technique does not crash so I am guessing there is some memory
leak happening in the code my team wrote.


Thanks and Regards,
Elita lobo

On Wed, Sep 28, 2016 at 12:21 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>
> On Tue, Sep 27, 2016 at 10:21 PM, Elita Lobo <loboelita@gmail.com> wrote:
> > Hi,
> >
> > I am using ceph for a research project and was trying to implement a
> > new jerasure plugin. The code works perfectly when I try to put small
> > objects ( 16Mb files) in a single pg but breaks when I am trying to
> > put some really large object in a cluster having multiple pgs. I am
> > pretty sure its a memory leak but not sure how to detect it.
>
> How big are these "really large object"s? Erasure coding can handle
> much bigger objects than replication does, but there are still limits
> beyond which stuff will go poorly.
> -Greg
>
> >
> > Can someone please suggest some tools that would help me  detect
> > memory leaks in ceph?
> >
> > Thanking you,
> > Yours sincerely,
> > Elita Lobo
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
