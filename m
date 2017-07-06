From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Note about rbd_aio_write usage
Date: Thu, 6 Jul 2017 10:40:23 -0400
Message-ID: <CA+aFP1Bs4K=eoYn4d1zo7HY8nWufLYOcQHX-r68frZ+ftNBHxQ@mail.gmail.com>
References: <f5062e24-d138-a096-0171-79bc1259db7b@corp.ovh.com>
 <CA+aFP1A5UVZzSDfFvphsVq9Jra9PXbJHUXhaJ9tH8LGx5OKJfA@mail.gmail.com>
 <c81d848d-04f9-bca5-0e8f-6fe1f1814903@corp.ovh.com> <CA+aFP1A_EAMxP+cMKN2SDcZ2C-KE3wadkydK_AGpfBg+p75pcQ@mail.gmail.com>
 <a974656a-2fc4-1fed-6adc-fbb42c54bd7e@corp.ovh.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35664 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdGFOkY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jul 2017 10:40:24 -0400
Received: by mail-yw0-f169.google.com with SMTP id v193so1915691ywg.2
        for <ceph-devel@vger.kernel.org>; Thu, 06 Jul 2017 07:40:24 -0700 (PDT)
In-Reply-To: <a974656a-2fc4-1fed-6adc-fbb42c54bd7e@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On Thu, Jul 6, 2017 at 10:22 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
> So I really see two problems here: lack of API docs and
> backwards-incompatible change in API behavior.

Docs are always in need of update, so any pull requests would be
greatly appreciated.

However, I disagree that the behavior has substantively changed -- it
was always possible for pre-Luminous to (sometimes) copy the buffer
before the "rbd_aio_write" method completed. With Luminous, this
behavior is more consistent -- but in a future release memory may be
zero-copied. If your application can properly conform to the
(unwritten) contract that the buffers should remain unchanged, there
would be no need for the application to pre-copy the buffers.

If the libfuse implementation requires that the memory is not-in-use
by the time you return control to it (i.e. it's a synchronous API and
you are using async methods), you will always need to copy it. The C++
API allows you to control the copying since you need to pass
"bufferlist"s to the API methods and since they utilize a reference
counter, there is no internal copying within librbd / librados.

-- 
Jason
