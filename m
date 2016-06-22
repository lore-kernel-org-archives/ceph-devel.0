From: Samuel Just <sjust@redhat.com>
Subject: Re: http://tracker.ceph.com/issues/16416
Date: Wed, 22 Jun 2016 11:24:27 -0700
Message-ID: <CAN=+7FXTcW4Qc7DjhcKyB_guUsRTFgkZxRhzoM96X-rvCRhzCw@mail.gmail.com>
References: <CAN=+7FXx6YMjeGUPuHgRGP+YMbwr19HD+A49SniDOHBNy-HNhQ@mail.gmail.com>
 <CAN=+7FWZ+Lr3VsgqBJbeVKOFqF67jQ1N5nFX9xCWDEvQAcZ8dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33505 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbcFVSY3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 14:24:29 -0400
Received: by mail-qk0-f171.google.com with SMTP id a186so76752563qkf.0
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 11:24:28 -0700 (PDT)
In-Reply-To: <CAN=+7FWZ+Lr3VsgqBJbeVKOFqF67jQ1N5nFX9xCWDEvQAcZ8dA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Haomai" <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I just reverted back to simple by default on master.  Once we get a
cleaner run with async, we can put it back (hopefully soon).
-Sam

On Wed, Jun 22, 2016 at 10:31 AM, Samuel Just <sjust@redhat.com> wrote:
> http://tracker.ceph.com/issues/16418 also, I think.
> -Sam
>
> On Wed, Jun 22, 2016 at 9:45 AM, Samuel Just <sjust@redhat.com> wrote:
>> I think this may be due to an async messenger thing, can you take a look?
>> -sam
