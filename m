From: John Spray <jspray@redhat.com>
Subject: Re: [Ceph Doc Conventions] ObjectStore, FileStore, BlueStore x Object
 Store, File Store, Blue Store
Date: Thu, 8 Dec 2016 12:23:58 +0000
Message-ID: <CALe9h7cre-GhZgwzuoNOzK_V=EXaDP6mrau6N=uQxS39r5FZsA@mail.gmail.com>
References: <13e0f1cc-5b25-6b05-65fb-66b961eafe7c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34615 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753113AbcLHMYU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2016 07:24:20 -0500
Received: by mail-qk0-f176.google.com with SMTP id q130so260079777qke.1
        for <ceph-devel@vger.kernel.org>; Thu, 08 Dec 2016 04:24:20 -0800 (PST)
In-Reply-To: <13e0f1cc-5b25-6b05-65fb-66b961eafe7c@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?QsOhcmEgQW7EjWluY292w6E=?= <bara@redhat.com>
Cc: Federico Lucifredi <flucifre@redhat.com>, Neil Levine <nlevine@redhat.com>, ceph-docs <ceph-docs@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 8, 2016 at 11:12 AM, Bára Ančincová <bara@redhat.com> wrote:
> Dear all,
>
> the Ceph documentation team is currently developing Ceph documentation
> conventions and we ran into the following question:
>
> What is the preferred spelling of various stores?
>
> I saw that the Ceph community mainly uses FileStore and BlueStore [1][2].
> However, we have Object Store in our guidelines[3] and we'd prefer to use it
> that way. Based on this logic it should be File Store and Blue Store.
>
> What spelling would you prefer? Is it ok to move from FileStore and
> BlueStore to File Store and Blue Store in the official downstream docs?

I would prefer that these not be re-written because:
 * It creates unnecessary diffs between upstream docs and vendor docs
(more work for you!)
 * It decreases googleability (or at least forces the search engine to
work harder to unify the two spellings)

It's a bit different to Filesystem vs. File System, because that was
an existing term where different people use different forms, whereas
these are our own terms.  To me, writing Blue Store instead of
BlueStore feels a bit like writing Mac Book instead of MacBook.

Regarding Object Store: it depends on the context and whether you're
talking about a generic Object Store (like RGW/S3) or whether you're
talking about the internal Ceph component (which I would always call
ObjectStore).  I store my S3 objects in an object store, but I
configure my OSD to use ObjectStore.

John

> Please feel free to include anyone else who might be interested in this
> topic.
>
> Cheers,
>
> Bara
>
> [1]
> http://www.sebastien-han.fr/blog/2013/12/02/ceph-performance-interesting-things-going-on/
> [2] http://www.sebastien-han.fr/blog/2016/03/21/ceph-a-new-store-is-coming/
> [3]
> https://gitlab.cee.redhat.com/ccs-internal-documentation/glossary-of-terms-and-conventions-for-product-documentation/merge_requests/28/diffs
> (disclaimer - still WIP and many things are missing. Please free to comment
> if you have any feedback. We will definitely share the final version with
> you to get your ack. I personally believe that Ceph docs conventions is
> something that we really need to achieve consistency in our docs and to
> improve them.)
>
> --
> Bara Ancincova
> Technical Writer
> Customer Content Services
> IRC nick: bara
>
> Red Hat Czech, s.r.o.
> Purkynova 99
> 612 45 Brno, Czech Republic
>
