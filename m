From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: ceph python crash dumps
Date: Tue, 3 Jan 2017 16:22:15 -0800
Message-ID: <c6ee5174-f1af-0416-220e-6400bc475609@redhat.com>
References: <CAGbvivK+Rec86bxhW_Sq6tOR0fJpLRcZqVpkNXAkq_MvTMQipA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966896AbdADAWP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 3 Jan 2017 19:22:15 -0500
In-Reply-To: <CAGbvivK+Rec86bxhW_Sq6tOR0fJpLRcZqVpkNXAkq_MvTMQipA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 01/03/2017 01:39 PM, Wyllys Ingersoll wrote:
> I have a python based WSGI application running inside Apache that uses the
> ceph python bindings to perform some operations.  Recently its been
> throwing exceptions when trying to make ceph connections, but I can't
> figure out what is really causing the issue here.
>
> Running ceph 10.2.5 with latest python-ceph packages.

This looks like http://tracker.ceph.com/issues/14115 - in your case
likely due to a bug in librados.

> Anyone seen this sort of thing before or have any idea how to prevent it?

You might be able to avoid it by using a single Rados instance per
process, to avoid re-initializing crypto_context within librados.

If you have a short script that reproduces it, or can run under
valgrind's memcheck tool we can see if your case would be fixed by

https://github.com/ceph/ceph/pull/12624

or if there are other leaks to fix.

Josh

> The following error appears in the Apache error logs:
>
> common/ceph_crypto.cc: In function 'void ceph::crypto::init(CephContext*)'
> thread 7fb1ca8c4700 time 2017-01-03 16:25:31.334606
> common/ceph_crypto.cc: 77: FAILED assert(crypto_context != __null)
>  ceph version 10.2.5 (c461ee19ecbc0c5c330aca20f7392c9a00730367)
>  1: (()+0x169b7b) [0x7fb1b1b82b7b]
>  2: (()+0x1b88c0) [0x7fb1b1bd18c0]
>  3: (()+0x184615) [0x7fb1b1b9d615]
>  4: (()+0x181800) [0x7fb1b1b9a800]
>  5: (()+0x95f2d) [0x7fb1b1aaef2d]
>  6: (rados_connect()+0x1c) [0x7fb1b1a7dadc]

