From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: feedback on supporting libc++
Date: Mon, 30 Dec 2013 17:19:20 -0800
Message-ID: <52C21B98.40109@inktank.com>
References: <CA+Hcz5-8k3rnCaJJj3htb0F63V+fitoBtofCkGzJZ4a_j29K8Q@mail.gmail.com>	<527157C0.40802@inktank.com> <CA+Hcz5_pOdrHyYq9xbn=09S6jFh9enRWq1uKxHSQKS3u2qiXQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f179.google.com ([209.85.161.179]:40846 "EHLO
	mail-gg0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932365Ab3LaBUK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Dec 2013 20:20:10 -0500
Received: by mail-gg0-f179.google.com with SMTP id l4so2434886ggi.10
        for <ceph-devel@vger.kernel.org>; Mon, 30 Dec 2013 17:20:09 -0800 (PST)
In-Reply-To: <CA+Hcz5_pOdrHyYq9xbn=09S6jFh9enRWq1uKxHSQKS3u2qiXQw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>, Gregory Farnum <gregory.farnum@inktank.com>

On 12/27/2013 03:34 PM, Noah Watkins wrote:
> On Wed, Oct 30, 2013 at 2:02 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
>> On 10/29/2013 03:51 PM, Noah Watkins wrote:
>>
>> unsafe to me. Could you check whether you can run 'rados ls' compiled
>> against an old librados, but dynamically loading librados from this
>> branch compiled in c++98 mode?
>
> I'm still working on this, but my understanding so far from libc++
> documentation is that libc++ and libstdc++ are API but not ABI
> compatible, so there shouldn't be an expectation that librados binary
> library built against libstc++ will work if dynamically linked against
> libc++.

I meant if it was compiled against libstdc++ both times, I was curious
whether changing std::tr1::shared_ptr to ceph::shared_ptr would result
in any incompatibility.

I just tried this, and it worked fine (I think because it does not
actually create a new c++ type, but acts like a typedef and just
creates an alias), so I've got no issues with this approach.

Josh
