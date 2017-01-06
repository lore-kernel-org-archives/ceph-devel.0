From: John Spray <jspray@redhat.com>
Subject: Re: Safe maximum number of RADOS namespaces
Date: Fri, 6 Jan 2017 15:37:00 +0000
Message-ID: <CALe9h7dgsbZiwww87DUtDUsy29LHNbwGxxNGygRhsQyz97U6dg@mail.gmail.com>
References: <592054113.6138.1483710244101@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33371 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdAFPhW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2017 10:37:22 -0500
Received: by mail-oi0-f46.google.com with SMTP id 128so424221971oig.0
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jan 2017 07:37:21 -0800 (PST)
In-Reply-To: <592054113.6138.1483710244101@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jan 6, 2017 at 1:44 PM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> Together with a customer we are looking in to writing a application which will store a few PB of data using raw RADOS (librados C) and we are looking into using the RADOS namespaces to separate data.
>
> For each 'section' we want to use a namespace in RADOS, but that would mean we would start off with 30M namespaces and this number might grow to 50M within a few years.
>
> Is the a limitation for RADOS/FileStore/BlueStore for the amount of namespaces it can handle? (In a single pool?)

I don't think we currently track a list of namespaces anywhere, so
there shouldn't be any limit.  The namespace effectively acts a
special prefix to the object name.  This could possibly change if we
ever added per-namespace statistics anywhere though.

John

> I want to test this, but writing a minimal of 30M objects takes a bit of time, so I figured I'd ask first.
>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
