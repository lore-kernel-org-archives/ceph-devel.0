From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH] ceph_common.sh: Do not sudo to root unless needed
Date: Mon, 19 Sep 2011 11:12:54 -0600
Message-ID: <4E777816.3080206@sandia.gov>
References: <1316012977-13675-1-git-send-email-jaschut@sandia.gov>
 <CAORUGqDgHS0z40=_Szp-N5ToLLdR3TT2Gdhm=WSN8Cr7-=jxyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:35159 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab1ISRNi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2011 13:13:38 -0400
In-Reply-To: <CAORUGqDgHS0z40=_Szp-N5ToLLdR3TT2Gdhm=WSN8Cr7-=jxyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Tommi Virtanen wrote:
> On Wed, Sep 14, 2011 at 08:09, Jim Schutt <jaschut@sandia.gov> wrote:
>> Using do_root_cmd() doesn't really need to sudo to root
>> if you're already root.
>>
>> Commit 71dc75bdafe62a098c0493ad62f2d0d2a6ca7946 causes a regression:
>> when system "foo" has a sudoers config that requires a tty,
>> init-ceph now fails like this:
>>  sudo: sorry, you must have a tty to run sudo
>>
>> when it is invoked by root with something like this:
>>   ssh foo /etc/init.d/init-ceph start
>>
>> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> 
> Applied as d64237a6a555944d6d35676490bc4fb7c7db965d, thank you.
> 
> (It seems I screwed up the author field in the commit, sorry about
> that. I don't want to force push just to fix that; Signed-off-by gives
> you credit anyway.)
> 
> 

No problem - thanks for taking a look.

-- Jim


