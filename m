From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Review Request
Date: Thu, 17 Sep 2015 12:19:26 -0400
Message-ID: <55FAE80E.8040700@redhat.com>
References: <55F9B061.2090300@redhat.com> <CAJ4mKGbP8K_iMN6AvZW2UwMjjxcEnb0vO2c_k2_3VUWSCWMQKA@mail.gmail.com> <55F9BDC1.20501@redhat.com> <CALe9h7f-O77BB=gPkujUWtyPVtFW-h8OfO8jKCsSWfmPzpQkQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39274 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbbIQQP3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Sep 2015 12:15:29 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 48B1A8E6F0
	for <ceph-devel@vger.kernel.org>; Thu, 17 Sep 2015 16:15:29 +0000 (UTC)
In-Reply-To: <CALe9h7f-O77BB=gPkujUWtyPVtFW-h8OfO8jKCsSWfmPzpQkQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Developers <ceph-devel@vger.kernel.org>

On 09/16/2015 06:15 PM, John Spray wrote:
> This is neat, I had been hankering to lambda-ize various things, but
> hadn't worked through what the allocation would looked like in
> practice.
> 
> Do you know if there's a reason the standard is defined so as to not
> let us override the reserved size of a std::function?  Are we taking
> any kind of hit by doing this?

There are tradeoffs, but I do not believe they burden us.

Small Function Optimization is not actually required by the standard.
It's just that all implementations of std::function I'm familiar with
implement it to at least some degree. In the GNU implementation, the
structure always has space for a pointer to point to heap allocated
stuff. If your 'function' is just a pointer (or something as big as a
pointer) it stores that. Since there aren't really any tradeoffs with
providing at least /some/ form of Small Function Optimization, there's
no reason for an implementation not to write it in. (This is in contrast
to Short String Operation, where it can clash with Copy-on-Write.)

So, the main reason the Standard doesn't allow one to specify the amount
of space reserved for Small Functions is that it doesn't talk about it.

There is a trade-off, however.

  ceph::function<void(int), 4 * sizeof(void*)>

Is a different type than

  ceph::function<void(int), 3 * sizeof(void*)>

This is good, in that it means that in our heap_allocations::forbid
case, we can reject, at compile time anything that the type system can't
guarantee will fit in our reserved space.

The cost is that they differ by type. A reference to one type won't
reference an object of the other type. This means that you'll need to
use a template and universal reference, like:

  template<typename F>
  void do_stuff(F&& f) {
    auto o = new Thing(std::forward<F>(f));
  }

And if you want to overload do_stuff, you'll need to use enable_if to
disambiguate the function from the other stuff. One day we shall have
Concepts. And if they don't give us too broken down and wimpified a
version it should make these problems go away. But for now we need
enable_if. There's a good chance that passing functions by universal
reference and forward right until the point they get stored somewhere is
going to be slightly more efficient at runtime than having the function
take a std::function&/ceph::function& parameter, depending on what the
compiler does (I haven't looked at the assembler for this case but I
suspect it would call the std::function constructor at the point of
function call and the move constructor at the point of storing it into
the data structure), so you might want to do this anyway.

It also means that you can't store pointer/reference to functions with a
different reserved size in the same container. In practice this doesn't
really come up, since if I'm a subsystem with a bunch of OnComplete
functions that I've stored and I want to gather up a list of references
to them I already control what I've stored. Or if you really need to you
can combine a ceph::function with a reserved size of 1 * sizeof(void*)
with std::ref to get a 'universal function reference' at the cost of a
double indirection and two virtual function calls where one would
normally be required.

There is also a potential runtime cost in the move constructor. If our
ceph::function heap allocates its storage and we then use swap, move
assignment, or move construction, we just end up copying a pointer at
each move. If everything fits in reserved space, all these pointer
copies become fairly substantial memcpies. Since Ceph normally stores a
callback function in the structure describing an operation, leaves it
there, and then calls it, this shouldn't hurt us too much. (And is one
of the reasons I recommend using a universal reference and std::forward
above rather than accepting a ceph::function reference and then
std::moving it into its final home.) For cases where we do want to
'move' them around a lot, we can use std::ref and other tricks to turn
the memcpies back into pointer copies.

Thank you!
