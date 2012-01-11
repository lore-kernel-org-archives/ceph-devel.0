From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: towards a user-mode diagnostic log mechanism
Date: Tue, 10 Jan 2012 17:06:55 -0800
Message-ID: <4F0CE0AF.6090702@cs.ucsc.edu>
References: <4EEFF614.8040207@dreamhost.com> <CA+qbEUNvLL0pui+XOr5W2m6dmBCxg8d4ZobrAnXV=wTQ=7YCFw@mail.gmail.com> <CAORUGqDCBaOA_N2+Lw+tyhDc3wjGBjEnnBYZO-=aMaNoRycoPw@mail.gmail.com> <4F0CDA9A.4070500@cs.ucsc.edu> <CAORUGqDmT86qdvpba1EYo6_D7KjAm7eHa_hReRgnw0uOU=8HQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:38545 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211Ab2AKBG2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2012 20:06:28 -0500
In-Reply-To: <CAORUGqDmT86qdvpba1EYo6_D7KjAm7eHa_hReRgnw0uOU=8HQQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, Colin McCabe <cmccabe@alumni.cmu.edu>, Mark Kampe <mark.kampe@dreamhost.com>, ceph-devel@vger.kernel.org

On 1/10/12 5:04 PM, Tommi Virtanen wrote:
> On Tue, Jan 10, 2012 at 16:40, Noah Watkins<jayhawk@cs.ucsc.edu>  wrote:
>>
>> Older Linux kernels force a thread into the kernel when calling gettimeofday
>> adding enormous overhead relative to the newer vsyscall implementations that
>> evaluate gettimeofday within userspace.
>
> So turning debug to full blast on older kernels will be painful. I'm
> personally ok with that, especially when the alternative is
> implementing all of the TSC logic myself. This is really complex code,
> and somebody went through the effort of solving the hard problems for

Yeh, that was just a bit of fyi noise.

> us -- let's use their code!

I definitely agree :)
