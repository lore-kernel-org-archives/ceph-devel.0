From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: blueprint: consistency groups
Date: Tue, 26 Apr 2016 11:09:01 -0500
Message-ID: <CA+aFP1CPc-aExqfNL671Zr6ectLH9aUEScmKveBn8rPCmJDLtA@mail.gmail.com>
References: <CA+hcxJQqbi_oCMF+0=fgQ6-=W1k-KPw6Y_3pZZnXKe01=Z-dhQ@mail.gmail.com>
	<CAJ4mKGYHno0u4z8PkUz0gL9voeBPQCPP+TSroEQRy2+26H+WHQ@mail.gmail.com>
	<20160325071933.GA14634@gmail.com>
	<CAJ4mKGZHd1Bm558woz=2Agd-x7sDkQmarwQfZUkwSWAcmOb8ew@mail.gmail.com>
	<CA+hcxJS+-HsTKpbASkWqr-gR8N6zF1k-pyWh8eQZCCC7sHCiLg@mail.gmail.com>
	<CA+aFP1CnKvVJrWDmKhpziu5otOV73HC5gnUsgZ8+oDW+708Rag@mail.gmail.com>
	<CA+hcxJSnUg1grhdBgOQPRcPK57VyW2Nyg9Rv6whZ3rj1ZoGU_Q@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35257 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbcDZQJD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Apr 2016 12:09:03 -0400
Received: by mail-qg0-f48.google.com with SMTP id f74so6903902qge.2
        for <ceph-devel@vger.kernel.org>; Tue, 26 Apr 2016 09:09:02 -0700 (PDT)
In-Reply-To: <CA+hcxJSnUg1grhdBgOQPRcPK57VyW2Nyg9Rv6whZ3rj1ZoGU_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Denisov <vdenisov@mirantis.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

> The problem that I see with this approach is: let's say we start
> adding an image to a cg and the cg is in adding image state.
> It either means that somebody is already adding an image to this cg or
> somebody died while adding this image.
> And we can't really understand it.

The metadata link from CG -> image should be in the "adding" state,
not the entire CG.  There shouldn't be anything preventing
concurrently adding two different images to a CG.

>
> So, my suggestion is: normally the command fails if it finds the cg in
> an unexpected state.
> If the user adds flag --force then it picks up this unfinished
> operation and completes it and then adds the new image.
> How does that sound?

My concern w/ adding a "--force" command for this is that it can be
abused.  Personally, I'd rather see that the API is robust enough to
handle these partial states.  If an "add" fails, I should be able to
repeat the "add" and have it work or run "remove" to have it clean up
any intermediate state.


-- 
Jason
