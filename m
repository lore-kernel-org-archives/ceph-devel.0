From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Sparse file info in filestore not propagated to other OSDs
Date: Thu, 6 Apr 2017 10:52:48 -0700
Message-ID: <d3c24475-f513-dddc-107e-494095b892a5@redhat.com>
References: <beaf4408-2322-b0f1-3265-0d9e411c5bf9@corp.ovh.com>
 <alpine.DEB.2.11.1704061322330.2999@piezo.novalocal>
 <db761315-61b5-bcac-e9ae-519ae8f769dc@corp.ovh.com>
 <alpine.DEB.2.11.1704061353070.2999@piezo.novalocal>
 <b7d71b5e-ebd6-23c1-962c-59375038ce5b@corp.ovh.com>
 <alpine.DEB.2.11.1704061426480.2999@piezo.novalocal>
 <CA+aFP1AtPUyxX9e6-gQGfO-FbGPTndFkWTq8ypmUotyGw=nfOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbdDFRwv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Apr 2017 13:52:51 -0400
In-Reply-To: <CA+aFP1AtPUyxX9e6-gQGfO-FbGPTndFkWTq8ypmUotyGw=nfOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com, Sage Weil <sage@newdream.net>
Cc: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 04/06/2017 08:50 AM, Jason Dillaman wrote:
> I don't recall a configuration option, but librbd always uses sparse
> reads when the cache is disabled and never uses sparse reads for
> cache-based reads. I'm pretty sure there wasn't a rationale for the
> split -- instead, I've always assumed it was an oversight when that
> feature was added years ago.

It was turned off on the osd side (with the 'filestore fiemap' option)
due to (at the time) buggy kernel behavior with fiemap.

I think I didn't bother implementing it in the cache because of this -
it wouldn't have been safe to use it at the time, and it would have
required more work in the cache to support sparse data at that point
too.

Nowadays seek_data/hole should be reliable (there have been xfstests
for it for a few years) so it's worth looking into for the
recovery case. The rbd cache could be pretty easily modified to support
sparse reads at this point too, which would help the keep the
copy-on-write case sparse.

Josh
