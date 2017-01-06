From: Wido den Hollander <wido@42on.com>
Subject: Re: Safe maximum number of RADOS namespaces
Date: Fri, 6 Jan 2017 17:42:22 +0100 (CET)
Message-ID: <308159841.6179.1483720942271@ox.pcextreme.nl>
References: <592054113.6138.1483710244101@ox.pcextreme.nl>
 <CALe9h7dgsbZiwww87DUtDUsy29LHNbwGxxNGygRhsQyz97U6dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:33326 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753574AbdAFQmZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2017 11:42:25 -0500
In-Reply-To: <CALe9h7dgsbZiwww87DUtDUsy29LHNbwGxxNGygRhsQyz97U6dg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 6 januari 2017 om 16:37 schreef John Spray <jspray@redhat.com>:
> 
> 
> On Fri, Jan 6, 2017 at 1:44 PM, Wido den Hollander <wido@42on.com> wrote:
> > Hi,
> >
> > Together with a customer we are looking in to writing a application which will store a few PB of data using raw RADOS (librados C) and we are looking into using the RADOS namespaces to separate data.
> >
> > For each 'section' we want to use a namespace in RADOS, but that would mean we would start off with 30M namespaces and this number might grow to 50M within a few years.
> >
> > Is the a limitation for RADOS/FileStore/BlueStore for the amount of namespaces it can handle? (In a single pool?)
> 
> I don't think we currently track a list of namespaces anywhere, so
> there shouldn't be any limit.  The namespace effectively acts a
> special prefix to the object name.  This could possibly change if we
> ever added per-namespace statistics anywhere though.

Understood. I expected this, but I wanted to double-check anyway. We will run tests with this in the future so we will know more then.

Wido

> 
> John
> 
> > I want to test this, but writing a minimal of 30M objects takes a bit of time, so I figured I'd ask first.
> >
> > Wido
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
