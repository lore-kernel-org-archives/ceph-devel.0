From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: feedback on supporting libc++
Date: Tue, 31 Dec 2013 10:59:47 -0800
Message-ID: <52C31423.20007@inktank.com>
References: <CA+Hcz5-8k3rnCaJJj3htb0F63V+fitoBtofCkGzJZ4a_j29K8Q@mail.gmail.com>	<527157C0.40802@inktank.com>	<CA+Hcz5_pOdrHyYq9xbn=09S6jFh9enRWq1uKxHSQKS3u2qiXQw@mail.gmail.com>	<52C21B98.40109@inktank.com> <CA+Hcz5-Gs03049M-o1uEgd1SoTnrkMZfrAVYhLJHD8g+AcRu5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f170.google.com ([209.85.161.170]:51155 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409Ab3LaS7t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Dec 2013 13:59:49 -0500
Received: by mail-gg0-f170.google.com with SMTP id 24so2580720gge.1
        for <ceph-devel@vger.kernel.org>; Tue, 31 Dec 2013 10:59:48 -0800 (PST)
In-Reply-To: <CA+Hcz5-Gs03049M-o1uEgd1SoTnrkMZfrAVYhLJHD8g+AcRu5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>, Gregory Farnum <gregory.farnum@inktank.com>

On 12/31/2013 08:59 AM, Noah Watkins wrote:
> Thanks for testing that Josh. Before cleaning up this patch set, I
> have a few questions.
>
> I'm still not clear on how to handle the "std::tr1::shared_ptr <
> ObjListCtx > ctx;" in librados.hpp. If we change this to
> ceph::shared_ptr, then we'll also need to some how ship with the
> translations here:
>
>    https://github.com/ceph/ceph/blob/port/libc%2B%2B/src/include/memory.h

I'd suggest treating it like we did buffer.h and associated headers -
make a symlink to it from include/rados/memory.h, and install a copy of
it with the librados headers.

> It's also not clear that ceph::shared_ptr should be exposed publically
> if there is a thought we might start switching out implementations of
> ceph::shared_ptr via memory.h (e.g. by using boost implementation).

We can't change the actual type used by librados, since AIUI that's
part of the ABI, so if we want to use another type internally we can
make include/rados/memory.h a copy of the original instead of a symlink,
and then change the internal include/memory.h however we like.

Josh
