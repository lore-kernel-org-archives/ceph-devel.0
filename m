From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: librados3
Date: Wed, 25 Oct 2017 17:32:23 -0700 (PDT)
Message-ID: <alpine.LSU.2.21.1710251728300.25633@smaug>
References: <CAJE9aOPhPFJdV2BQ4-9LhpzN5gucc4BOuU=0C27geK_d0P4r=A@mail.gmail.com> <CALe9h7fSc5QoNn49o9MewuLqKc1fST8dR2iq9c3LAPkTij6DJA@mail.gmail.com> <CA+aFP1B5TLKDkMEOE9AOLkuNoOq=_mD4jy_MUTo7x2CKXz9LYw@mail.gmail.com> <alpine.DEB.2.11.1710191212390.24806@piezo.us.to>
 <CAOtMX2h7r4H0YRr7d-7HWWU9eY7zqQtjW+AtZpHndrG7gwaNkQ@mail.gmail.com> <CAF-wwdHpVomqNtJkxaQJm05M17WN=5zJi5owxOOQw3_bgh3zKA@mail.gmail.com> <CAJE9aOOdYpepu3O+WUxLv_0kZHc6EB8_gSBTqeunXLRxY1RFQg@mail.gmail.com> <72ed7ce0-4656-7671-8c54-b78b5db0a347@redhat.com>
 <alpine.LSU.2.21.1710251321150.25633@smaug> <327d9be0-545f-f563-2b5e-fc36058c30af@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932194AbdJZAcR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Oct 2017 20:32:17 -0400
In-Reply-To: <327d9be0-545f-f563-2b5e-fc36058c30af@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, Brad Hubbard <bhubbard@redhat.com>, Alan Somers <asomers@freebsd.org>, Sage Weil <sweil@redhat.com>, Jason Dillaman <dillaman@redhat.com>, John Spray <jspray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 25 Oct 2017, Josh Durgin wrote:

> It's not meant to be a publicly exposed type, it's just there as a
> convenience for internal ceph stuff using librados that needs to pass
> configuration that's already in a CephContext.

Ok, so no particular objections to making it something that can be put on 
the stack? It's been making my life difficult in trying to decouple some 
parts of librados (in particular, exactly configuration, etc.). :-)

Thanks,

-Jesse
