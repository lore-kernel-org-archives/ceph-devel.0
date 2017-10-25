From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: librados3
Date: Wed, 25 Oct 2017 14:51:51 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1710251321150.25633@smaug>
References: <CAJE9aOPhPFJdV2BQ4-9LhpzN5gucc4BOuU=0C27geK_d0P4r=A@mail.gmail.com> <CALe9h7fSc5QoNn49o9MewuLqKc1fST8dR2iq9c3LAPkTij6DJA@mail.gmail.com> <CA+aFP1B5TLKDkMEOE9AOLkuNoOq=_mD4jy_MUTo7x2CKXz9LYw@mail.gmail.com> <alpine.DEB.2.11.1710191212390.24806@piezo.us.to>
 <CAOtMX2h7r4H0YRr7d-7HWWU9eY7zqQtjW+AtZpHndrG7gwaNkQ@mail.gmail.com> <CAF-wwdHpVomqNtJkxaQJm05M17WN=5zJi5owxOOQw3_bgh3zKA@mail.gmail.com> <CAJE9aOOdYpepu3O+WUxLv_0kZHc6EB8_gSBTqeunXLRxY1RFQg@mail.gmail.com>
 <72ed7ce0-4656-7671-8c54-b78b5db0a347@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45335 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbdJYVvs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Oct 2017 17:51:48 -0400
In-Reply-To: <72ed7ce0-4656-7671-8c54-b78b5db0a347@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, Brad Hubbard <bhubbard@redhat.com>, Alan Somers <asomers@freebsd.org>, Sage Weil <sweil@redhat.com>, Jason Dillaman <dillaman@redhat.com>, John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 25 Oct 2017, Josh Durgin wrote:

> At this point it it seems worth finally separating the internal and
> external types there, without doing a full new version of librados.

+1

Even though it looks like we won't move forward on too many extravagant 
things (as per the etherpad, "http://pad.ceph.com/p/librados3"), I do 
still have one wishlist item I should throw in here:  If we could enable a 
CephContext can live on the stack while we're in here, that would be 
awesome. Does anyone know why it's dtor has been made private?

> It may be possible to do this without introducing a new type, by freezing the 
> existing bufferlist as the external type for librados and librbd, and making 
> a conversion if necessary. We could add a true pimpl wrapper as a new type to 
> avoid the overhead of conversion if it is a problem.

Assuming the doesn't preclude adding other future types, seems like a 
reasonable way to address the situation. The PIMPL will still have some 
overhead from the indirection, but certainly less than forcing 
conversion/copy.

-Jesse

