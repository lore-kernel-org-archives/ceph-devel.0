From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: feedback on supporting libc++
Date: Thu, 9 Jan 2014 12:54:58 -0700
Message-ID: <CA+Hcz585SaEdQmy9Eoc_2OS48yqVD6j8u2toLeAp3peCLi5-jA@mail.gmail.com>
References: <CA+Hcz5-8k3rnCaJJj3htb0F63V+fitoBtofCkGzJZ4a_j29K8Q@mail.gmail.com>
	<527157C0.40802@inktank.com>
	<CA+Hcz5_pOdrHyYq9xbn=09S6jFh9enRWq1uKxHSQKS3u2qiXQw@mail.gmail.com>
	<52C21B98.40109@inktank.com>
	<CA+Hcz5-Gs03049M-o1uEgd1SoTnrkMZfrAVYhLJHD8g+AcRu5Q@mail.gmail.com>
	<52C31423.20007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:34002 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbaAITy7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jan 2014 14:54:59 -0500
Received: by mail-qa0-f45.google.com with SMTP id j5so3082918qaq.4
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jan 2014 11:54:58 -0800 (PST)
In-Reply-To: <52C31423.20007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>, Gregory Farnum <gregory.farnum@inktank.com>

I've send up a pull request with an initial run at this patch set:

   https://github.com/ceph/ceph/pull/1064

The only thing that we haven't mentioned as possible solutions is to
only use boost variants, rather than switching between the ones in
std:: (in c++11) and std::tr1::.

On Tue, Dec 31, 2013 at 11:59 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 12/31/2013 08:59 AM, Noah Watkins wrote:
>>
>> Thanks for testing that Josh. Before cleaning up this patch set, I
>> have a few questions.
>>
>> I'm still not clear on how to handle the "std::tr1::shared_ptr <
>> ObjListCtx > ctx;" in librados.hpp. If we change this to
>> ceph::shared_ptr, then we'll also need to some how ship with the
>> translations here:
>>
>>    https://github.com/ceph/ceph/blob/port/libc%2B%2B/src/include/memory.h
>
>
> I'd suggest treating it like we did buffer.h and associated headers -
> make a symlink to it from include/rados/memory.h, and install a copy of
> it with the librados headers.
>
>
>> It's also not clear that ceph::shared_ptr should be exposed publically
>> if there is a thought we might start switching out implementations of
>> ceph::shared_ptr via memory.h (e.g. by using boost implementation).
>
>
> We can't change the actual type used by librados, since AIUI that's
> part of the ABI, so if we want to use another type internally we can
> make include/rados/memory.h a copy of the original instead of a symlink,
> and then change the internal include/memory.h however we like.
>
> Josh
