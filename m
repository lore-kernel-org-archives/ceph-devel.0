From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: blueprint: consistency groups
Date: Tue, 26 Apr 2016 16:33:48 -0700
Message-ID: <CA+hcxJTsPnVyF5Jvic+hDGgR=9CRZNzcwA6sAZzNxnm5x1J=kg@mail.gmail.com>
References: <CA+hcxJQqbi_oCMF+0=fgQ6-=W1k-KPw6Y_3pZZnXKe01=Z-dhQ@mail.gmail.com>
	<CAJ4mKGYHno0u4z8PkUz0gL9voeBPQCPP+TSroEQRy2+26H+WHQ@mail.gmail.com>
	<20160325071933.GA14634@gmail.com>
	<CAJ4mKGZHd1Bm558woz=2Agd-x7sDkQmarwQfZUkwSWAcmOb8ew@mail.gmail.com>
	<CA+hcxJS+-HsTKpbASkWqr-gR8N6zF1k-pyWh8eQZCCC7sHCiLg@mail.gmail.com>
	<CA+aFP1CnKvVJrWDmKhpziu5otOV73HC5gnUsgZ8+oDW+708Rag@mail.gmail.com>
	<CA+hcxJSnUg1grhdBgOQPRcPK57VyW2Nyg9Rv6whZ3rj1ZoGU_Q@mail.gmail.com>
	<CA+aFP1CPc-aExqfNL671Zr6ectLH9aUEScmKveBn8rPCmJDLtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35651 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbcDZXdt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Apr 2016 19:33:49 -0400
Received: by mail-yw0-f182.google.com with SMTP id g133so40071583ywb.2
        for <ceph-devel@vger.kernel.org>; Tue, 26 Apr 2016 16:33:49 -0700 (PDT)
In-Reply-To: <CA+aFP1CPc-aExqfNL671Zr6ectLH9aUEScmKveBn8rPCmJDLtA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

I understand. I can do it.
One quick question: is image id unique across all pools? I'm
referencing image using 'image_<image id>' key and then keeping pool
id in the omap value.
Is it safe?

On Tue, Apr 26, 2016 at 9:09 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>> The problem that I see with this approach is: let's say we start
>> adding an image to a cg and the cg is in adding image state.
>> It either means that somebody is already adding an image to this cg or
>> somebody died while adding this image.
>> And we can't really understand it.
>
> The metadata link from CG -> image should be in the "adding" state,
> not the entire CG.  There shouldn't be anything preventing
> concurrently adding two different images to a CG.
>
>>
>> So, my suggestion is: normally the command fails if it finds the cg in
>> an unexpected state.
>> If the user adds flag --force then it picks up this unfinished
>> operation and completes it and then adds the new image.
>> How does that sound?
>
> My concern w/ adding a "--force" command for this is that it can be
> abused.  Personally, I'd rather see that the API is robust enough to
> handle these partial states.  If an "add" fails, I should be able to
> repeat the "add" and have it work or run "remove" to have it clean up
> any intermediate state.
>
>
> --
> Jason
