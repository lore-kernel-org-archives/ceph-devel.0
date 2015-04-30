From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Hitting tcmalloc bug even with patch applied
Date: Thu, 30 Apr 2015 10:36:35 -0700
Message-ID: <CAC6JEv-tfCiWpHZLOX=mLxfQfAVtUvy1WtETOus7KON82stxNg@mail.gmail.com>
References: <615356748.699601184.1430136382697.JavaMail.zimbra@oxygem.tv>
	<553E9B11.8040906@adfin.com>
	<553E9D02.70606@redhat.com>
	<9E914F5BD7F48A4782456CEB550A422824E76364@SACMBXIP02.sdcorp.global.sandisk.com>
	<CANP1eJHo43HtxMJnyHu2GGGZt8bvMgAoU9qK4cpbXya0bM8hXQ@mail.gmail.com>
	<085BC98701B92B4C86AE7696562D284D18B9ABAC@SACMBXIP02.sdcorp.global.sandisk.com>
	<CACJqLya3b9wH9id8KVYf2Otpim6Y1mu+y9w3QAAuonPwrR1dnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34960 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbbD3Rgg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Apr 2015 13:36:36 -0400
Received: by igbyr2 with SMTP id yr2so20325642igb.0
        for <ceph-devel@vger.kernel.org>; Thu, 30 Apr 2015 10:36:36 -0700 (PDT)
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com. [209.85.213.173])
        by mx.google.com with ESMTPSA id r4sm1397424igw.12.2015.04.30.10.36.35
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 10:36:35 -0700 (PDT)
Received: by igblo3 with SMTP id lo3so20146321igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 30 Apr 2015 10:36:35 -0700 (PDT)
In-Reply-To: <CACJqLya3b9wH9id8KVYf2Otpim6Y1mu+y9w3QAAuonPwrR1dnQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Vijayendra Shamanna <Vijayendra.Shamanna@sandisk.com>, Milosz Tanski <milosz@adfin.com>, Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, Mark Nelson <mnelson@redhat.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Somnath Roy <Somnath.Roy@sandisk.com>

On Wed, Apr 29, 2015 at 11:15 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
> Hmm, I think we need to pay a lot attention to this problem especially
> for fast storage device backend.
>
> I think the way to solve this problem rely to ceph itself instead of
> tcmalloc or jemalloc optimization.
>
> I'm not sure the most consuming memory is used by which part,
> frequently-used object like ObjectContext/OpTracker or buffers in
> bufferlist.

We've talked very briefly about using pools for ObjectContext and
OpTracker objects which might help, but the bulk of the memory
allocation is usually going to be for the message bufferlists, which
are variable-length. :(
(Strictly speaking so are a lot of the others which include string
renditions of the object name, but that can be worked around at least
a bit more than the actual message contents can.)

> Could tcmalloc or jemalloc provide with malloc/free usage
> statistic infos which contain callstack, so we may see the memory
> bottleneck from it?

You can do this with tcmalloc, and it's even integrated into Ceph with
the various heap commands. :)

>
> On the other hand, maybe ceph need to consider to do memory management
> itself for the main or frequent memory users.
