From: Sage Weil <sage@inktank.com>
Subject: Re: Assertion failure when radosgw can't authenticate
Date: Mon, 2 Jul 2012 07:53:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207020752350.23342@cobra.newdream.net>
References: <CAPUexz-VFp0i8Q-MDH1TyEsEQRAuLx8JNfq6hxTms=U3zKnf5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33957 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab2GBOxL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 10:53:11 -0400
In-Reply-To: <CAPUexz-VFp0i8Q-MDH1TyEsEQRAuLx8JNfq6hxTms=U3zKnf5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian.haas@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 2 Jul 2012, Florian Haas wrote:
> Hi,
> 
> in cephx enabled clusters (0.47.x), authentication failures from
> radosgw seem to lead to an uncaught assertion failure:
> 
> 2012-07-02 11:26:46.559830 b69c5730  0 librados:
> client.radosgw.charlie authentication error (1) Operation not
> permitted
> 2012-07-02 11:26:46.560093 b69c5730 -1 Couldn't init storage provider (RADOS)
> 2012-07-02 11:26:46.560401 b69c5730 -1 common/Timer.cc: In function
> 'SafeTimer::~SafeTimer()' thread b69c5730 time 2012-07-02
> 11:26:46.5601
> 10
> common/Timer.cc: 57: FAILED assert(thread == __null)
> 
>  ceph version 0.47.3 (commit:c467d9d1b2eac9d3d4706b8e044979aa63b009f8)
>  1: (SafeTimer::~SafeTimer()+0x96) [0x80a5c76]
>  2: (main()+0x56f) [0x809708f]
>  3: (__libc_start_main()+0xe6) [0xb6cefca6]
>  4: /usr/bin/radosgw() [0x807f4a1]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.

I believe this might have been fixed by 
b44092f557a6be869fc1a52e2b93e756626d7cb4 (which is in next/0.48-to-be).  
Do you mind verifying that?

Thanks!
sage


> 
> --- begin dump of recent events ---
>     -2> 2012-07-02 11:26:46.559830 b69c5730  0 librados:
> client.radosgw.charlie authentication error (1) Operation not
> permitted
>     -1> 2012-07-02 11:26:46.560093 b69c5730 -1 Couldn't init storage
> provider (RADOS)
>      0> 2012-07-02 11:26:46.560401 b69c5730 -1 common/Timer.cc: In
> function 'SafeTimer::~SafeTimer()' thread b69c5730 time 2012-07-02
> 11:26
> :46.560110
> common/Timer.cc: 57: FAILED assert(thread == __null)
> 
> Kinda ugly. Maybe this could be fixed in the pending 0.48 release.
> 
> The issue obviously goes away immediately after correcting the auth credentials.
> 
> Cheers,
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
