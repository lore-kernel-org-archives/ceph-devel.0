From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: blueprint: consistency groups
Date: Mon, 16 May 2016 11:48:58 -0400
Message-ID: <CA+aFP1CVs-_KWWUOdnP7=rFbghpNHTrrfuLPkVw9RtX03eAUKw@mail.gmail.com>
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
	<CA+aFP1AchQD6b-gm7Z4zijQfW8OMZJrrE8S2nLde2CE+VUjZew@mail.gmail.com>
	<CA+hcxJQAC7m5mRXhGfL0Fu8erWFb--GstHzOYO-swJNLWXPhHw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34131 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbcEPPs7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2016 11:48:59 -0400
Received: by mail-pa0-f53.google.com with SMTP id qo8so23729648pab.1
        for <ceph-devel@vger.kernel.org>; Mon, 16 May 2016 08:48:58 -0700 (PDT)
In-Reply-To: <CA+hcxJQAC7m5mRXhGfL0Fu8erWFb--GstHzOYO-swJNLWXPhHw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Denisov <vdenisov@mirantis.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

On Thu, May 12, 2016 at 10:45 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
> Jason,
>
> Do you have any opinion regarding deleting images that are in a
> consistency group?
>
> Should we delete them as well as the references in the consistency
> group they belong to or should we prohibit deleting images that are in
> a consistency group?
>
> V.
>

Right now, if an image has a snapshot we required you to remove all
snapshots before removing the image.  Along those lines, if an image
is in a consistency group and the consistency group has snapshots, the
user wouldn't be able to remove the image since it has snapshots nor
should the user be able to remove the snapshots associated with the
consistency group. In this case, the user would be forced to
dissociate the image from the group before attempting to delete it.
Therefore, just to keep the actions consistent, you might as well
force the user to dissociate an image from the consistency group even
if the image doesn't have snapshots.


-- 
Jason
