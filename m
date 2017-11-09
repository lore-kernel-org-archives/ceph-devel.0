From: Wei Jin <wjin.cn@gmail.com>
Subject: Re: Osd failure detection
Date: Thu, 9 Nov 2017 20:13:57 +0800
Message-ID: <CAPpSHbUNw5xosaywDM6SVR3oAd7tVP_T+17QCj-296bj8+kYOg@mail.gmail.com>
References: <A80E9066-6266-49E2-9BD7-137E8136D6B9@gmail.com> <20171109120318.1946caf2@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:43905 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754241AbdKIMN6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Nov 2017 07:13:58 -0500
Received: by mail-wr0-f171.google.com with SMTP id 4so5410722wrt.0
        for <ceph-devel@vger.kernel.org>; Thu, 09 Nov 2017 04:13:58 -0800 (PST)
In-Reply-To: <20171109120318.1946caf2@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 9, 2017 at 7:03 PM, David Disseldorp <ddiss@suse.de> wrote:
> On Thu, 9 Nov 2017 17:43:04 +0800, Wei Jin wrote:
>
>> Hi, List,
>>
>> From Luminous release, I noticed following information:
>>
>>  "Some OSD failures are now detected almost immediately, whereas previou=
sly the heartbeat timeout (which defaults to 20 seconds) had to expire.  Th=
is prevents IO from blocking for an extended period for failures where the =
host remains up but the ceph-osd process is no longer running."
>
> I assume you're referring to the ECONNREFUSED-fast-fail functionality
> added by Piotr Da=C5=82ek.
>

Exactly.

>> This is critical and we have no plan to upgrade to Luminous so far.
>> Is there any plan to back port it Jewel? Or anybody know the related pr =
or patches? Maybe I could do it by myself.
>
> It was backported to Jewel, alongside a bunch of other async messenger
> fixes, and submitted via https://github.com/ceph/ceph/pull/13212 . IIRC,
> there's still a small async messenger leak blocking the PR.
>

Yeah. It is still open and marked as DNM.
And there are some issues with async messenger. As async is not the
default one, why not just make it available for simple messenger?

> Cheers, David
