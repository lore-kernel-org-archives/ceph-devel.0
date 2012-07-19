From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Poor read performance in KVM
Date: Thu, 19 Jul 2012 13:15:31 -0500
Message-ID: <50084EC3.60003@inktank.com>
References: <5002C215.108@bashkirtsev.com>	<5003B1CC.4060909@inktank.com>	<50064DCD.8040904@bashkirtsev.com>	<5006D5FB.8030700@inktank.com>	<5007FB6E.1080307@bashkirtsev.com>	<CADvuQRGaivtgho4R=rk3c_B6eJ2GfG=tZFGNy9knoKyh2CR-zg@mail.gmail.com> <CADxhoDT8rimSwP+Y75tGVo3Nd5WYw8xHyDxBAMV8tb5no0OP4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:43070 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab2GSSPy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 14:15:54 -0400
Received: by gglu4 with SMTP id u4so3089193ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 11:15:53 -0700 (PDT)
In-Reply-To: <CADxhoDT8rimSwP+Y75tGVo3Nd5WYw8xHyDxBAMV8tb5no0OP4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Calvin Morrow <calvin.morrow@gmail.com>
Cc: Tommi Virtanen <tv@inktank.com>, Vladimir Bashkirtsev <vladimir@bashkirtsev.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On 07/19/2012 01:06 PM, Calvin Morrow wrote:
> On Thu, Jul 19, 2012 at 9:52 AM, Tommi Virtanen<tv@inktank.com>  wrote:
>>
>> On Thu, Jul 19, 2012 at 5:19 AM, Vladimir Bashkirtsev
>> <vladimir@bashkirtsev.com>  wrote:
>>> Look like that osd.0 performs with low latency but osd.1 latency is way
>>> too
>>> high and on average it appears as 200ms. osd is backed by btrfs over
>>> LVM2.
>>> May be issue lie in backing fs selection? All four osds running similar
>>
>> Our typical experience with btrfs right now seems to be that it works
>> fast when the filesystem is fresh, but as it ages, it starts to have
>> higher and higher delays on syncing writes. This does not seem to be
>> completely deterministic, that is, if you run many btrfs'es, the
>> symptoms start to appear at different times on different instances.
>
> Is Inktank seeing the slowdown on btrfs volumes with large metadata
> (32k / 64k) node/leaf sizes as well, or only on default (4k) sizes?
>
> Vladmir,
>
> What node/leaf size are you using on your btrfs volume?

Hi Vladmir,

We are seeing degradation at 64k node/leaf sizes as well.  So far the 
degradation is most obvious with small writes.  it affects XFS as well, 
though not as severely.  We are vigorously looking into it. :)

Mark

>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Mark Nelson
Performance Engineer
Inktank
