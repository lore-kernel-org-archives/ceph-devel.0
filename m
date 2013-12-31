From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: feedback on supporting libc++
Date: Tue, 31 Dec 2013 08:59:20 -0800
Message-ID: <CA+Hcz5-Gs03049M-o1uEgd1SoTnrkMZfrAVYhLJHD8g+AcRu5Q@mail.gmail.com>
References: <CA+Hcz5-8k3rnCaJJj3htb0F63V+fitoBtofCkGzJZ4a_j29K8Q@mail.gmail.com>
	<527157C0.40802@inktank.com>
	<CA+Hcz5_pOdrHyYq9xbn=09S6jFh9enRWq1uKxHSQKS3u2qiXQw@mail.gmail.com>
	<52C21B98.40109@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:47911 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab3LaQ7V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Dec 2013 11:59:21 -0500
Received: by mail-qc0-f178.google.com with SMTP id i17so11969490qcy.37
        for <ceph-devel@vger.kernel.org>; Tue, 31 Dec 2013 08:59:20 -0800 (PST)
In-Reply-To: <52C21B98.40109@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>, Gregory Farnum <gregory.farnum@inktank.com>

Thanks for testing that Josh. Before cleaning up this patch set, I
have a few questions.

I'm still not clear on how to handle the "std::tr1::shared_ptr <
ObjListCtx > ctx;" in librados.hpp. If we change this to
ceph::shared_ptr, then we'll also need to some how ship with the
translations here:

  https://github.com/ceph/ceph/blob/port/libc%2B%2B/src/include/memory.h

It's also not clear that ceph::shared_ptr should be exposed publically
if there is a thought we might start switching out implementations of
ceph::shared_ptr via memory.h (e.g. by using boost implementation).

On Mon, Dec 30, 2013 at 5:19 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 12/27/2013 03:34 PM, Noah Watkins wrote:
>>
>> On Wed, Oct 30, 2013 at 2:02 PM, Josh Durgin <josh.durgin@inktank.com>
>> wrote:
>>>
>>> On 10/29/2013 03:51 PM, Noah Watkins wrote:
>>>
>>> unsafe to me. Could you check whether you can run 'rados ls' compiled
>>> against an old librados, but dynamically loading librados from this
>>> branch compiled in c++98 mode?
>>
>>
>> I'm still working on this, but my understanding so far from libc++
>> documentation is that libc++ and libstdc++ are API but not ABI
>> compatible, so there shouldn't be an expectation that librados binary
>> library built against libstc++ will work if dynamically linked against
>> libc++.
>
>
> I meant if it was compiled against libstdc++ both times, I was curious
> whether changing std::tr1::shared_ptr to ceph::shared_ptr would result
> in any incompatibility.
>
> I just tried this, and it worked fine (I think because it does not
> actually create a new c++ type, but acts like a typedef and just
> creates an alias), so I've got no issues with this approach.
>
> Josh
