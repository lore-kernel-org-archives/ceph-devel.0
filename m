From: kefu chai <tchaikov@gmail.com>
Subject: Re: librados3
Date: Thu, 26 Oct 2017 17:22:01 +0800
Message-ID: <CAJE9aON16w47xcJN+7DkDpSUNS7hjUsc0Wqr6ctGHVpxC-b1iA@mail.gmail.com>
References: <CAJE9aOPhPFJdV2BQ4-9LhpzN5gucc4BOuU=0C27geK_d0P4r=A@mail.gmail.com>
 <CALe9h7fSc5QoNn49o9MewuLqKc1fST8dR2iq9c3LAPkTij6DJA@mail.gmail.com>
 <CA+aFP1B5TLKDkMEOE9AOLkuNoOq=_mD4jy_MUTo7x2CKXz9LYw@mail.gmail.com>
 <alpine.DEB.2.11.1710191212390.24806@piezo.us.to> <CAOtMX2h7r4H0YRr7d-7HWWU9eY7zqQtjW+AtZpHndrG7gwaNkQ@mail.gmail.com>
 <CAF-wwdHpVomqNtJkxaQJm05M17WN=5zJi5owxOOQw3_bgh3zKA@mail.gmail.com>
 <CAJE9aOOdYpepu3O+WUxLv_0kZHc6EB8_gSBTqeunXLRxY1RFQg@mail.gmail.com> <72ed7ce0-4656-7671-8c54-b78b5db0a347@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:54287 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdJZJWC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Oct 2017 05:22:02 -0400
Received: by mail-oi0-f48.google.com with SMTP id a132so4504729oih.11
        for <ceph-devel@vger.kernel.org>; Thu, 26 Oct 2017 02:22:02 -0700 (PDT)
In-Reply-To: <72ed7ce0-4656-7671-8c54-b78b5db0a347@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Alan Somers <asomers@freebsd.org>, Sage Weil <sweil@redhat.com>, Jason Dillaman <dillaman@redhat.com>, John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Oct 26, 2017 at 3:06 AM, Josh Durgin <jdurgin@redhat.com> wrote:
>
>
> The most common culprit for ABI issues is bufferlist since we expose the
> internal ceph type directly. This has caused problems with almost every
> release lately.
>
> At this point it it seems worth finally separating the internal and
> external types there, without doing a full new version of librados.

i don't think we can do this without doing a new version of librados.
the legacy librados clients are still expecting the internal types at
some degree, that's how we noticed the problem
(http://tracker.ceph.com/issues/21573), where the librados client was
compiled with an old librados header, and inlined the old constructor
in its binary. and some APIs force us to do so, for example,
"ObjectReadOperation::getxattrs(std::map<std::string, bufferlist>
*pattrs, int *prval)" requires a complete type definition of
ceph::bufferlist. in other words, the buffer.h exposing the innards of
ceph::buffer types was shipped with librados2, and the librados client
is using them, we can hardly fix this w/o bumping the so version.

>
> It may be possible to do this without introducing a new type, by freezing
> the existing bufferlist as the external type for librados and librbd, and
> making a conversion if necessary. We could add a true pimpl wrapper as a new
> type to avoid the overhead of conversion if it is a problem.

yeah, probably by introducing a bufferlist2, which is a pimpl wrapper,
and start to deprecate APIs like getxattrs() with the ones using
bufferlist2. and convert bufferlist to the actual bufferlist in the
legacy APIs. feasible, but a pains-taking plan..

i still like librados3. =)


-- 
Regards
Kefu Chai
