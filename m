From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: blueprint: consistency groups
Date: Wed, 11 May 2016 11:44:56 -0700
Message-ID: <CA+hcxJS9mBZL5wu0A2L_-3bAyvMb90qBaYo+cosqphUn0Dj9kQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36500 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbcEKSo5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 14:44:57 -0400
Received: by mail-yw0-f169.google.com with SMTP id o66so57721314ywc.3
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2016 11:44:56 -0700 (PDT)
In-Reply-To: <CA+aFP1CfOCy9pL=NWka=j=otb7rwO7W=ds-ggBMz0hVY=zj3-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

Thanks, Jason. At the first glance at create_image and remove_image I
frankly wasn't sure it would be able to recover from a mid-operation
failure.
Now, I tested it and reread the code - it works like a charm. If we
remove a partially added image then all artifacts will be clean up.
I just need to make consistency groups behave the same way.

One more question. I see that remove operation for images can report
progress. Is it necessary for consistency groups?


On Wed, May 11, 2016 at 8:12 AM, Jason Dillaman <jdillama@redhat.com> wrote:
> On Tue, May 10, 2016 at 12:25 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>> I was writing unit tests for create_cg function when I realized that
>> it wouldn't recover if we lost connection between
>> cls_client::dir_add_cg and create_cg object. If create_cg doesn't
>> happen then we are unable to repeat dir_add_cg.
>> However since I implemented create_cg operation after create_image
>> operation. create_image operation has the same issue.
>
> Correct - the recovery is to remove the image and re-create if you
> have a failure creating the image.  I think that is a valid solution
> to the consistency groups as well.
>
>> So, my question is. Should I reimplement create_cg so that it can
>> recover from connection loss to the cluster or should I keep it the
>> same way create_image is implemented?
>
> There will not be an issue if the connection is lost -- there will
> only be an issue if the rbd CLI (or whatever else is using the librbd
> API) crashes / is stopped mid-operation.  I am fine with matching the
> create_image behavior because there is a recovery path.
>
>> Also, what is more preferable big pull request for all components of
>> the feature - CRUD for consistency groups and snapshots, or split it
>> into smaller pull requests - first merge CRUD operations then
>> implement snapshots?
>
> Smaller patchsets are easier to review, test, and merge (especially as
> review comments are addressed).
>
> --
> Jason
