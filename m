From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: blueprint: consistency groups
Date: Wed, 11 May 2016 16:24:04 -0400
Message-ID: <CA+aFP1AchQD6b-gm7Z4zijQfW8OMZJrrE8S2nLde2CE+VUjZew@mail.gmail.com>
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
	<CA+hcxJT4DWgt8K8hc27KbkJK=DRePM18Zh=GPxtfR5afoxVP1w@mail.gmail.com>
	<CA+hcxJQGcDy96o0f9sEY8HwLXng9YzxsoKAhaaCuCDDhVbN76A@mail.gmail.com>
	<CA+aFP1AQzo7bO=e-Gd_sAtBWSYFgvji8isxuXFKDejaHAA+FuA@mail.gmail.com>
	<CA+hcxJRMcJFxYdscdwyvowjw_dNF6xoNzCHT1=oaznwGqY-4Rw@mail.gmail.com>
	<CA+aFP1Awk0YZnW16JxOgfDeJFsuKPoN4jdrpr8dCdqUjhhD_Mw@mail.gmail.com>
	<CA+hcxJTWZWUAUGr1gAZwEqLrGY9eJpzrF3+0H3wqaSjiY6-Faw@mail.gmail.com>
	<CA+aFP1CfOCy9pL=NWka=j=otb7rwO7W=ds-ggBMz0hVY=zj3-Q@mail.gmail.com>
	<CA+hcxJS9mBZL5wu0A2L_-3bAyvMb90qBaYo+cosqphUn0Dj9kQ@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33503 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbcEKUYF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 16:24:05 -0400
Received: by mail-pa0-f51.google.com with SMTP id xk12so21345459pac.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2016 13:24:04 -0700 (PDT)
In-Reply-To: <CA+hcxJS9mBZL5wu0A2L_-3bAyvMb90qBaYo+cosqphUn0Dj9kQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Denisov <vdenisov@mirantis.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

On Wed, May 11, 2016 at 2:44 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
> One more question. I see that remove operation for images can report
> progress. Is it necessary for consistency groups?

It shouldn't be necessary for consistency groups.  The rationale for
the progress callback for images is because it might require deleting
tens of thousands of backing objects.  When you remove a consistency
groups, we should ensure that all associated images have already been
removed -- so it should be a quick (algorithmically speaking)
operation.

-- 
Jason
