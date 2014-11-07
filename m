From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: =?UTF-8?B?zpluc3RydW1lbnRpbmcgUkFET1Mgd2l0aCBaaXBraW4gKyBMVFQ=?=
 =?UTF-8?B?bmc=?=
Date: Fri, 07 Nov 2014 08:18:42 -0600
Message-ID: <545CD4C2.5030408@redhat.com>
References: <20141030184938.GA10197@radon.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:54349 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbaKGOSo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Nov 2014 09:18:44 -0500
Received: by mail-ig0-f171.google.com with SMTP id hl2so12763548igb.4
        for <ceph-devel@vger.kernel.org>; Fri, 07 Nov 2014 06:18:43 -0800 (PST)
In-Reply-To: <20141030184938.GA10197@radon.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Shewmaker <agshew@gmail.com>, ceph-devel@vger.kernel.org

On 10/30/2014 01:49 PM, Andrew Shewmaker wrote:
> Hi everyone,
>
> I'm Andrew, a new Ceph intern, and I'll be working to get Marios'
> Zipkin + LTTng repo into a merge-able state, as Sam asked about
> (http://www.spinics.net/lists/ceph-devel/msg20024.html).
>
> I've exchanged email with Marios, and he is interested in
> helping me with it in his spare time. One of the important
> things he mentioned is that his blkin library only works
> with LTTng 2.4. Other versions experience deadlocks, and
> he'll work to resolve them in 2.5.
>
> I'm still working on getting a ceph development environment
> set up, so I haven't tested the tracepoints Marios added.
> I have built an RPM spec file for blkin, tested it against
> lttng-ust 2.3 and 2.4, and built (but not tested) Marios'
> ceph branch.
>
> Should I put effort into adding a "--with-blkin" or "--with-zipkin"
> option to autoconf?
>
> I've made a first attempt at dividing the changes into
> logically grouped patches: common blkin infrastructure,
> osd, and rados. Does that sound reasonable? Or should
> I not bother separating osd and rados changes?
>
> I saw a couple instances of extraneous whitespace/newlines
> I'll clean up. What other issues should I look for?
>
> After they're cleaned up, would it be best for me to submit these
> patches to the list, or just point to a github repo?
>
> Thanks,
>
> Andrew Shewmaker

Just wanted to say I'm really looking forward to this. :)

Mark

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

