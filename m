From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: blueprint: consistency groups
Date: Tue, 3 May 2016 09:54:36 +0300
Message-ID: <20160503065435.GA2159@gmail.com>
References: <20160325071933.GA14634@gmail.com>
 <CAJ4mKGZHd1Bm558woz=2Agd-x7sDkQmarwQfZUkwSWAcmOb8ew@mail.gmail.com>
 <CA+hcxJS+-HsTKpbASkWqr-gR8N6zF1k-pyWh8eQZCCC7sHCiLg@mail.gmail.com>
 <CA+aFP1CnKvVJrWDmKhpziu5otOV73HC5gnUsgZ8+oDW+708Rag@mail.gmail.com>
 <CA+hcxJSnUg1grhdBgOQPRcPK57VyW2Nyg9Rv6whZ3rj1ZoGU_Q@mail.gmail.com>
 <CA+aFP1CPc-aExqfNL671Zr6ectLH9aUEScmKveBn8rPCmJDLtA@mail.gmail.com>
 <CA+hcxJTsPnVyF5Jvic+hDGgR=9CRZNzcwA6sAZzNxnm5x1J=kg@mail.gmail.com>
 <CA+aFP1C7me+-dbXVrMgU0Qs9fX8_4ocC9v5orzy+c8tK30y08A@mail.gmail.com>
 <CA+hcxJT4DWgt8K8hc27KbkJK=DRePM18Zh=GPxtfR5afoxVP1w@mail.gmail.com>
 <CA+hcxJQGcDy96o0f9sEY8HwLXng9YzxsoKAhaaCuCDDhVbN76A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:32983 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbcECGyl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 02:54:41 -0400
Received: by mail-lf0-f52.google.com with SMTP id y84so11233899lfc.0
        for <ceph-devel@vger.kernel.org>; Mon, 02 May 2016 23:54:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+hcxJQGcDy96o0f9sEY8HwLXng9YzxsoKAhaaCuCDDhVbN76A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Denisov <vdenisov@mirantis.com>
Cc: Jason Dillaman <dillaman@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

On Mon, May 02, 2016 at 05:26:04PM -0700, Victor Denisov wrote:
> I have a question regarding the implementation of list images in a
> consistency group.
> For referencing images I use their ids and pool ids, since image's
> name and pool's name are subject to change.
> In order to list the images in a consistency group I have a function:
> cg_list_images.
> This function only returns ids and pool ids.
> I presume normally users would like to see names instead of ids.
> Everything in rbd class is written the way that it accepts ioctx.
> Which is a handle for accessing pool.
> It means(in my opinion) that everything in rbd class should accept
> ioctx. As such, I can't open another ioctx when I'm already inside rbd
> class.
> It leaves me no choice, but to implement image's name resolution in
> tools/rbd/action/ConsGrp.cc.
> In this case only command line users can have images' names, but not
> other services that use librbd library.
> Is it fine?

You need to add RBD API functions. These functions operate only with
image names (image ID is unknown entity for RBD API). And use these
functions in tools/rbd/action/ConsGrp.cc. See for example the recently
added rbd_mirror_image_status_list(). Internally it uses
cls_client::mirror_image_status_list(), which returns image IDs; the
list is converted to image names, when returning to the user.

-- 
Mykola Golub
