From: John Spray <jspray@redhat.com>
Subject: Re: Crashes with new encoding
Date: Thu, 20 Oct 2016 15:04:40 +0100
Message-ID: <CALe9h7dt-7gwMBm3ZQNpGGo_nVkYGy9EO1o9Ai-f=PR54v2OXw@mail.gmail.com>
References: <CALe9h7frgSiSV0YkaP4h0nK0Z2p7R_QXe=xwf9ujvCg01ZusxA@mail.gmail.com>
 <alpine.DEB.2.11.1610201354550.28765@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35374 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbcJTOFD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Oct 2016 10:05:03 -0400
Received: by mail-lf0-f43.google.com with SMTP id l131so80922667lfl.2
        for <ceph-devel@vger.kernel.org>; Thu, 20 Oct 2016 07:05:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610201354550.28765@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Oct 20, 2016 at 2:58 PM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 20 Oct 2016, John Spray wrote:
>> Latest master has the MDS crashing on startup:
>> http://tracker.ceph.com/issues/17636
>> https://github.com/ceph/ceph/pull/11577
>>
>> My patch is kind of dumb, clearly the intent of the original code is
>> to avoid any constructor overhead and it would be nice to do so, but
>> the original code seems to make the assumption that no encode/decode
>> implementations deferences the object they're passed.
>>
>> Good motivation to go and immediately familiarise myself with the new
>> code this morning though :-)
>
> Hmm, what compiler version are you using?  The intent of the code is
> two-fold: avoid the ctor, as you mention, but also trigger a SEGV if the
> implementation of bound_encode for any traits::bounded type actually
> makes use of the (bogus) reference we're passing in.

This is gcc 5.3.1 (fedora 22).

> Which type(s) did it fail on?  My guess is that it is either a malformed
> bound_encode (taking a value instead of a reference) or the implementation
> is broken (value-dependent).

Ah, I see that denc_traits<inodeno_t>::bound_encode was indeed taking
a value instead of a reference.

John

> Or, we are unlucky enough that the compiler is both turning const foo&
> into a pass-by-value and not optimizing it away when the implementation
> doesn't make use of it.  :/  Hopefully not!
>
> sage
>
