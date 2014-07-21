From: Daniel Hofmann <daniel@trvx.org>
Subject: Forcing Ceph into mapping all objects to a single PG
Date: Tue, 22 Jul 2014 00:27:00 +0200
Message-ID: <53CD93B4.6020500@trvx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trvx.org ([46.38.250.125]:34869 "EHLO mail.trvx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbaGUWeJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 21 Jul 2014 18:34:09 -0400
Received: from [192.168.1.115] (HSI-KBW-046-005-197-128.hsi8.kabel-badenwuerttemberg.de [46.5.197.128])
	by mail.trvx.org (Postfix) with ESMTPSA id 307541A253CC
	for <ceph-devel@vger.kernel.org>; Tue, 22 Jul 2014 00:27:08 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Preamble: you might want to read the decent formatted version of this
mail at:
> https://gist.github.com/daniel-j-h/2daae2237bb21596c97d


Motivation
----------

Recently I was wondering how Ceph (i.e. Rados in particular) maps object
to Placement Groups (PGs).

It basically works like the following:

    pg = hash(object)
    osd = crush(pg)

By hashing the object's name (not the content!) Ceph determines the PG.
For assigning PGs to OSDs, the CRUSH algorithm is used.

But what happens if the hash function always returns the same value,
i.e. what happens on hash collisions?
Does Ceph really map objects to the same PG then?

I asked this on the IRC Channel and was a bit surprised as I got the
response, that if Ceph really maps all objects to a single PG I'm simply
out of luck:

> with enough PG and enough objects of reasonable sizes, it should yield
a decent data distribution

Confirming, that the hash function is indeed responsible for the
distribution of objects to PGs.

So, what could possibly go wrong? Let's try this!


Setting up the environment
--------------------------

I modified the librados usage example
(src/examples/librados/hello_world.cc) to write a objects with specific
names:

    std::string object_name("\x41\x5b\xd2\xc2\xc3");  // bear with me here
    //std::string object_name("\x41\x1e\xf8\x5e\x22");
    //std::string object_name("\x01\x01\x01\x17\x2e");

After setting up a local cluster via the vstart.sh tool and writing
those three objects, executing

    ./ceph pg dump | less -S

indeed shows our three **objects getting mapped to the same PG**!


Collisions
----------

How is it possible to come up with such colliding names? It's actually
quite simple:

Ceph defines two hash functions (src/common/ceph_hash.cc) from which the
so called rjenkins hash function is used by default.

(Note: src/crush/hash.c actually implements the rjenkins function again
-- why?)

The hash function's implementation is deterministic in the sense that
the output only depends on it's input.
No random or setup-specific seed is used.

What implications does this have?

Once we compute collisions, we're able to force the object mapping on
**every rados object store out there**.
And because the hash function's output is only 32 bits wide, collisions
are not that hard to find at all!

Here are a few if you're following along and want to test your setup:

| hash (u32) |byte sequence (hex) |
| -----------|--------------------|
| 381933444  | 41 5b d2 c2 c3     |
| 381933444  | 41 1e f8 5e 22     |
| 381933444  | 1 1 1 17 2e        |
| 381933444  | 1 a4 34 f6 c0      |
| 381933444  | 42 ca 78 4f 47     |
| 381933444  | 82 e8 ea fe 16     |


Implications
-------------

I did this as a proof-of-concept in a few hours but I'm still not sure
about the full implications.
I'm able to force object mappings. Can this be used as a DOS attack
vector? Maybe.

I looked through the RadosGW source, in order to find out how object
names are generated there.
I only found the second hash function implementation getting used -- but
I'm not familiar with the source to say more about it at this time.


Open questions
--------------

I'd like to know more about what an impact this could have. In particular:

* How do higher-level API's (e.g. RadosGW) determine the object's name?
Can this be influenced or set by the user?
* Is it possible to introduce some randomness, in order to mitigate the
explained scenario? Maybe on a per-cluster basis or deduced from some
internal state. (Note: SipHash is doing something similar)


Summary
-------

Ceph's object mapping depends on the rjenkins hash function.
It's possible to force Ceph into mapping all objects to a single PG.

Please discuss!

Thanks,
Daniel J. Hofmann
