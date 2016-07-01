From: Casey Bodley <cbodley@redhat.com>
Subject: Re: static_ptr - making the factory pattern less costly
Date: Fri, 1 Jul 2016 13:54:16 -0400
Message-ID: <33128da8-93f8-3c54-4b98-440b1737c873@redhat.com>
References: <20160629174256.GA5185@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35080 "EHLO
	mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbcGASAm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jul 2016 14:00:42 -0400
Received: by mail-qt0-f176.google.com with SMTP id f89so61385665qtd.2
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jul 2016 11:00:41 -0700 (PDT)
In-Reply-To: <20160629174256.GA5185@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>, Radoslaw Zarzynski <rzarzynski@mirantis.com>


On 06/29/2016 01:42 PM, Adam C. Emerson wrote:
> On 28/06/2016, Radoslaw Zarzynski wrote:
> [snip]
>> The owning semantic has been taken from std::unique_ptr.
> [snip]
>
> Since moving or copying the static_ptr is the same as moving or
> copying the stored object, I think that should be the guideline.
> The least surprising way to implement things would be:
>
> (1) static_ptr<T> is copyable if T is copyable. It is movable if T is
>      movable. It is nothrow-copyable if T is nothrow-copyable. It is
>      nothrow-movable if T is nothrow-movable.
>
> (2) If S is derived from T, but T is copyable and S is not, attempts
>      to store S in static_ptr<T> should fail. Same for move. If T is
>      nothrow-copyable or nothrow-movable and S is not, storing S in T
>      should fail.
>
> That way code written using static_ptr<T> won't have its expectations
> or exception safety change out from under it.
>

Agreed for the most part. But as a smart pointer, there's the added 
distinction of empty/not-empty.

Moves should be supported if T is movable -or- copyable (i.e. move 
operations are deleted), and should result in the source being empty 
regardless of whether T is moved or copied.

There's also some ambiguity with respect to construction vs. assignment. 
If the destination is empty, then a move-assignment would instead result 
in a move-construct of T. The same goes for copy-assignment. This means 
that the noexcept specifiers will need to require both 
nothrow-constructible and nothrow-assignable.
