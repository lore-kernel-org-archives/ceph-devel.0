From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Build Warnings: spotting them, and cleaning them up
Date: Wed, 16 Nov 2016 14:33:43 -0800
Message-ID: <CAJ4mKGZdmR++4PDKGOnyS7kHf9PUzKms_gVaChtjEbhoj+EO0Q@mail.gmail.com>
References: <CAJ4mKGa6ECp6Qdy9jU2fF_NWONKZp=hviTyN68LXvw94J9Fd9w@mail.gmail.com>
 <20161116221018.GA8507@ultraspiritum.eng.arb.redhat.com> <CAJ4mKGbUhfi5SA5UKNN_rZbPZ=eHHLohjzJeiy4qr+0sDg=7Eg@mail.gmail.com>
 <20161116222935.GB8507@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:33095 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754227AbcKPWdp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2016 17:33:45 -0500
Received: by mail-it0-f42.google.com with SMTP id c20so38666292itb.0
        for <ceph-devel@vger.kernel.org>; Wed, 16 Nov 2016 14:33:44 -0800 (PST)
In-Reply-To: <20161116222935.GB8507@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, Nov 16, 2016 at 2:29 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 16/11/2016, Gregory Farnum wrote:
>> Is that branch going to merge imminently? If not maybe we could pull
>> out this and the BlueStore fixes for fast merging. :)
>
> It is in wip-sage-testing at the moment.
>
>> Is this different from the boost changes you mentioned you already
>> have? :)
>
> Yes and no. The boost changes fix everything in external dependencies
> I know about. I was just pointing out that we shouldn't have trouble
> addressing future problems if they crop up.

Okay, so once your stuff is in we ought to be able to add -Werr to the
build flags. Hurray!
