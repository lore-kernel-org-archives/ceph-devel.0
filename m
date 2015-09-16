From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Review Request
Date: Wed, 16 Sep 2015 15:06:41 -0400
Message-ID: <55F9BDC1.20501@redhat.com>
References: <55F9B061.2090300@redhat.com> <CAJ4mKGbP8K_iMN6AvZW2UwMjjxcEnb0vO2c_k2_3VUWSCWMQKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35197 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbbIPTCF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Sep 2015 15:02:05 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 922D6C02C030
	for <ceph-devel@vger.kernel.org>; Wed, 16 Sep 2015 19:02:05 +0000 (UTC)
In-Reply-To: <CAJ4mKGbP8K_iMN6AvZW2UwMjjxcEnb0vO2c_k2_3VUWSCWMQKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Developers <ceph-devel@vger.kernel.org>

On 09/16/2015 02:31 PM, Gregory Farnum wrote:
> Can you provide a little background (links or text) for those of us
> who aren't up on C++11x/14x? I looked at them briefly but having only
> the vaguest idea about some of them quickly got lost. :)

Surely, sir.

So, in summary, Context* is the means we have been using to handle
callbacks. It has two big problems:

(1) Every Context is allocated at the point of use and freed when it's
called. So by their nature they make heavy use of the heap. (If you
overload complete there's a few exceptions, but by and large Context is
very heapy.)

(2) Context accepts an int. That's it. You can get around this by
storing other things in it and passing pointers to it and so forth. But
it would be nice to have more variety of type in our callbacks.

C++11 (and following) have a whole pile of things that can be used as
functions. There are function objects (objects with an operator()
defined on them), lambdas with variable capture, function member
pointers, reference wrappers pointing to function objects and the like.
This gives you a good bit of flexibility, allows things like variable
capture, let's you allocate one object once and just pass references to
it, and so forth.

Now, these objects all have different sizes and different types. So you
can't just shove them in an object naively. Because a class one of whose
members is a function pointer is going to be a different type than a
class holding a function object. (Which itself is different to a type
holding a reference to a function object.)

std::function exists as a solution to this problem. It provides a
uniform type that can hold any object satisfying the requirement of
being callable with given argument types and a given return value. So,
for example, if you have some 'stat'-like call, you could specify it as
taking a function taking an error code, a size, and a date. Anything
that can be called with such would be accepted, anything that can't
(wrong argument types, say) would be rejected at compile time. And it
could be uniformly stored in a list of Operations.

The downside is that if the thing you provide is too big, std::function
will allocate. 'too big' depends on your library vendor and there's no
way to find it out what. Thus the purpose of the ceph::function class.
If we have a pretty good idea how large most of the callback function
objects we expect to hold are, we can tell it to statically allocate
that much space. This gives us a tool to get allocations out of our fast
path. (For example, if we preallocate a bunch of classes with a
ceph::function that preallocates enough space to hold likely callbacks,
we can just pick them off and have no allocations, in the usual case.)

If we know /everything/ we'll ever get, we can disable allocations
entirely. This is mostly so we can catch situations where we're trying
to shove something unexpectedly huge somewhere it ought not go. An
internal sanity check.

Now, ceph::function, like std::function, is still an abstraction with a
virtual call in it and because it copies things around it reduces
opportunities for inlining. Thus, if you aren't storing a callback on an
object that's supposed to be in a queue, you shouldn't use it. You
should do something like:

template<typename Fun>
void do_stuff(Fun&& f) {
  ...;
  f(some, values);
};

This allows inlining, and (based on my experiments trying multiple
implementations and looking at the generated assembly) if f is called in
a loop, the code is just as good as if you'd open-coded the loop and
written the body of 'f' in it. Functions like this can have the
potential to use closures (lambda expression) effectively for free.

So, the summary is:

Context* is very heapy. We have less heapy alternatives. This implements
a foundation for one of them. We also get a bit more flexibility.

Thank you.
