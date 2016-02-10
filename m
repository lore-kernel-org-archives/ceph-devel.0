From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH V4 5/5] ceph: scattered page writeback
Date: Wed, 10 Feb 2016 20:39:08 +0800
Message-ID: <6D6CF180-88C2-4D8C-B71D-401DD88FCE49@redhat.com>
References: <1453973811-2018-1-git-send-email-zyan@redhat.com> <CAOi1vP9W1AkQ=G1mFAkdqR84JdFN2Uf2_5usCpsa54GUAc6gQA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52337 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbcBJMjO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 07:39:14 -0500
In-Reply-To: <CAOi1vP9W1AkQ=G1mFAkdqR84JdFN2Uf2_5usCpsa54GUAc6gQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> On Feb 10, 2016, at 19:22, Ilya Dryomov <idryomov@gmail.com> wrote:
> 
> This is not quite what I described and the whole function is still as
> entangled as it was and very hard to validate.  But, with the dynamic
> array logic gone, I won't press it any further.
> 
> The r_inline_ops being unused in the >CEPH_OSD_INITAL_OP case concern
> still stands however.  I pushed wip-alloc-request for that, could you
> see if you can rebase "libceph: add helper that duplicates last extent
> operation" and "ceph: scattered page writeback" on top of it?

I pushed the rebased patches to sip-alloc-request branch. I also updated your patch, adding code to calculate r_request/r_reply messages sizes.

Regards
Yan, Zheng

> 
> Thanks,
> 
>                Ilya

