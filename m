From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: blueprint: consistency groups
Date: Thu, 28 Apr 2016 11:06:07 -0700
Message-ID: <CA+hcxJT4DWgt8K8hc27KbkJK=DRePM18Zh=GPxtfR5afoxVP1w@mail.gmail.com>
References: <CA+hcxJQqbi_oCMF+0=fgQ6-=W1k-KPw6Y_3pZZnXKe01=Z-dhQ@mail.gmail.com>
	<CAJ4mKGYHno0u4z8PkUz0gL9voeBPQCPP+TSroEQRy2+26H+WHQ@mail.gmail.com>
	<20160325071933.GA14634@gmail.com>
	<CAJ4mKGZHd1Bm558woz=2Agd-x7sDkQmarwQfZUkwSWAcmOb8ew@mail.gmail.com>
	<CA+hcxJS+-HsTKpbASkWqr-gR8N6zF1k-pyWh8eQZCCC7sHCiLg@mail.gmail.com>
	<CA+aFP1CnKvVJrWDmKhpziu5otOV73HC5gnUsgZ8+oDW+708Rag@mail.gmail.com>
	<CA+hcxJSnUg1grhdBgOQPRcPK57VyW2Nyg9Rv6whZ3rj1ZoGU_Q@mail.gmail.com>
	<CA+aFP1CPc-aExqfNL671Zr6ectLH9aUEScmKveBn8rPCmJDLtA@mail.gmail.com>
	<CA+hcxJTsPnVyF5Jvic+hDGgR=9CRZNzcwA6sAZzNxnm5x1J=kg@mail.gmail.com>
	<CA+aFP1C7me+-dbXVrMgU0Qs9fX8_4ocC9v5orzy+c8tK30y08A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34526 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbcD1SGJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2016 14:06:09 -0400
Received: by mail-yw0-f169.google.com with SMTP id j74so118313849ywg.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 11:06:08 -0700 (PDT)
In-Reply-To: <CA+aFP1C7me+-dbXVrMgU0Qs9fX8_4ocC9v5orzy+c8tK30y08A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

I created a pull request for preliminary review:
https://github.com/ceph/ceph/pull/8816
Please leave your comments if you have any. Currently it only has the
following operations implemented:

- create consistency group
- remove consistency group
- add image to consistency group
- remove image from consistency group
- list consistency groups


On Wed, Apr 27, 2016 at 10:50 AM, Jason Dillaman <jdillama@redhat.com> wrote:
> On Tue, Apr 26, 2016 at 6:33 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>> One quick question: is image id unique across all pools? I'm
>> referencing image using 'image_<image id>' key and then keeping pool
>> id in the omap value.
>> Is it safe?
>
>
> No -- the image id is only guaranteed to be unique within the pool
> that owns the image.  You can use the pool id in combination with the
> image id to form a unique key.
>
> --
> Jason
