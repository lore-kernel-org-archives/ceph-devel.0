From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] include: ceph: Fix encode and decode type conversions
Date: Thu, 18 Feb 2016 17:20:28 +0100
Message-ID: <12201396.FPdHi0skie@wuerfel>
References: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com> <CABeXuvqAgzCYGDh51rZK-MEh88T0gsxO4dRcFZVL-JWYXjtQzg@mail.gmail.com> <CAOi1vP8NycKxd2sp2qMS7AoZxTSnFSGdxOj9_sXU=sykqsR6hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:53760 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946767AbcBRQUf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Feb 2016 11:20:35 -0500
In-Reply-To: <CAOi1vP8NycKxd2sp2qMS7AoZxTSnFSGdxOj9_sXU=sykqsR6hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>

On Thursday 18 February 2016 17:02:25 Ilya Dryomov wrote:
> 
> If we are going to touch this function at all, let's drop all casts and
> just add a comment along the lines of "the lack of cast/sign-extension
> here is intentional, this function has a counterpart on the server side
> which also lacks cast/sign-extension, etc".  To someone who is not up
> on these subtleties, the __u64 cast is going to be more confusing than
> explicit...

We certainly a comment, I was just suggesting to add the cast as well.

Again, it's not the lack of the cast on the server that is important
here, it's whether it gets interpreted as signed or unsigned at the
point where the timestamp is actually used for comparison or
printing. Let me suggest a comment here:

/*
 * ceph timestamps are unsigned 32-bit starting at 1970, which is
 * different from a signed 32-bit or 64-bit time_t. On 64-bit
 * architectures, this gets interpreted as a subset of time_t
 * in the range from 1970 to 2106.
 * Machines with a 32-bit time_t will incorrectly interpret the
 * timestamps with years 2038-2106 as negative numbers in the
 * 1902-1969 range, until both kernel and glibc are change to
 * using 64-bit time_t.
 */

	Arnd
