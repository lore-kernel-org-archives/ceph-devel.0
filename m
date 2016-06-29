From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: static_ptr - making the factory pattern less costly
Date: Wed, 29 Jun 2016 13:42:57 -0400
Message-ID: <20160629174256.GA5185@ultraspiritum.eng.arb.redhat.com>
References: <CA+H5UW36xpQvyopzEgZiH7v2QMm-mbWqJxuLNOSKLRA19Eau3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58982 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbcF2Rnr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jun 2016 13:43:47 -0400
Content-Disposition: inline
In-Reply-To: <CA+H5UW36xpQvyopzEgZiH7v2QMm-mbWqJxuLNOSKLRA19Eau3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>

On 28/06/2016, Radoslaw Zarzynski wrote:
[snip]
> The owning semantic has been taken from std::unique_ptr.
[snip]

Since moving or copying the static_ptr is the same as moving or
copying the stored object, I think that should be the guideline.
>
The least surprising way to implement things would be:

(1) static_ptr<T> is copyable if T is copyable. It is movable if T is
    movable. It is nothrow-copyable if T is nothrow-copyable. It is
    nothrow-movable if T is nothrow-movable.

(2) If S is derived from T, but T is copyable and S is not, attempts
    to store S in static_ptr<T> should fail. Same for move. If T is
    nothrow-copyable or nothrow-movable and S is not, storing S in T
    should fail.

That way code written using static_ptr<T> won't have its expectations
or exception safety change out from under it.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
