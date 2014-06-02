From: Gregory Farnum <greg@inktank.com>
Subject: Re: Librbd licensing
Date: Mon, 2 Jun 2014 11:21:31 -0700
Message-ID: <CAPYLRzi9Gd8V8y2cjA4Fxu+OxRLC74W8oTmv_s55HQCGHSDRAQ@mail.gmail.com>
References: <loom.20140530T192820-478@post.gmane.org>
	<alpine.DEB.2.00.1405301042200.11044@cobra.newdream.net>
	<CADXiVcpM8GJcCbDkdOPWzXPoJrDdyiQn0-q4nDH6o0zpg_u8gg@mail.gmail.com>
	<538CAE14.4060602@dachary.org>
	<CADXiVcrSf4WgMUJ1d6FRSFqUOEeeGVDTTw5VvY6gSdDsQObJZQ@mail.gmail.com>
	<alpine.DEB.2.00.1406021021080.19902@cobra.newdream.net>
	<538CBBC9.5070600@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:40230 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbaFBSVd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jun 2014 14:21:33 -0400
Received: by mail-qg0-f51.google.com with SMTP id q107so11195775qgd.38
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jun 2014 11:21:31 -0700 (PDT)
In-Reply-To: <538CBBC9.5070600@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Steve Taylor <steveftaylor@gmail.com>, Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jun 2, 2014 at 11:00 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 06/02/2014 10:22 AM, Sage Weil wrote:
>>
>> Ideally the change comes from Josh, who originally put the notice there,
>> but I think it shouldn't matter.  We relicensed rbd.cc as LGPL2 a while
>> back (it was GPL due to a header we used?) and got confirmations from all
>> authors.  It might be worth doing a quick check to make sure there aren't
>> committers for the affected headers that we didn't contact earlier.
>
>
> There's one.
>
> Greg, could you confirm that you consent to licensing your changes to
> librbd.h and librbd.hpp under LGPL2.1?

Definitely not a problem.
-Greg

>
> I think it's a good idea to fix the typo so it doesn't cause this
> confusion again.
>
> Josh
