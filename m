From: Gregory Farnum <greg@inktank.com>
Subject: Re: Forcing Ceph into mapping all objects to a single PG
Date: Mon, 21 Jul 2014 15:50:02 -0700
Message-ID: <CAPYLRzj4tzBCSrGPCsaLvy1+7ac4=Um1EHDeZhLsCpuZZy7miA@mail.gmail.com>
References: <53CD93B4.6020500@trvx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53209 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaGUWuF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jul 2014 18:50:05 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so4974031wiv.5
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jul 2014 15:50:03 -0700 (PDT)
In-Reply-To: <53CD93B4.6020500@trvx.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Hofmann <daniel@trvx.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jul 21, 2014 at 3:27 PM, Daniel Hofmann <daniel@trvx.org> wrote:
> Preamble: you might want to read the decent formatted version of this
> mail at:
>> https://gist.github.com/daniel-j-h/2daae2237bb21596c97d
>
>
> Motivation
> ----------
>
> Recently I was wondering how Ceph (i.e. Rados in particular) maps object
> to Placement Groups (PGs).
>
> It basically works like the following:
>
>     pg = hash(object)
>     osd = crush(pg)
>
> By hashing the object's name (not the content!) Ceph determines the PG.
> For assigning PGs to OSDs, the CRUSH algorithm is used.
>
> But what happens if the hash function always returns the same value,
> i.e. what happens on hash collisions?
> Does Ceph really map objects to the same PG then?
>
> I asked this on the IRC Channel and was a bit surprised as I got the
> response, that if Ceph really maps all objects to a single PG I'm simply
> out of luck:
>
>> with enough PG and enough objects of reasonable sizes, it should yield
> a decent data distribution
>
> Confirming, that the hash function is indeed responsible for the
> distribution of objects to PGs.
>
> So, what could possibly go wrong? Let's try this!
>
>
> Setting up the environment
> --------------------------
>
> I modified the librados usage example
> (src/examples/librados/hello_world.cc) to write a objects with specific
> names:
>
>     std::string object_name("\x41\x5b\xd2\xc2\xc3");  // bear with me here
>     //std::string object_name("\x41\x1e\xf8\x5e\x22");
>     //std::string object_name("\x01\x01\x01\x17\x2e");
>
> After setting up a local cluster via the vstart.sh tool and writing
> those three objects, executing
>
>     ./ceph pg dump | less -S
>
> indeed shows our three **objects getting mapped to the same PG**!
>
>
> Collisions
> ----------
>
> How is it possible to come up with such colliding names? It's actually
> quite simple:
>
> Ceph defines two hash functions (src/common/ceph_hash.cc) from which the
> so called rjenkins hash function is used by default.
>
> (Note: src/crush/hash.c actually implements the rjenkins function again
> -- why?)
>
> The hash function's implementation is deterministic in the sense that
> the output only depends on it's input.
> No random or setup-specific seed is used.
>
> What implications does this have?
>
> Once we compute collisions, we're able to force the object mapping on
> **every rados object store out there**.
> And because the hash function's output is only 32 bits wide, collisions
> are not that hard to find at all!
>
> Here are a few if you're following along and want to test your setup:
>
> | hash (u32) |byte sequence (hex) |
> | -----------|--------------------|
> | 381933444  | 41 5b d2 c2 c3     |
> | 381933444  | 41 1e f8 5e 22     |
> | 381933444  | 1 1 1 17 2e        |
> | 381933444  | 1 a4 34 f6 c0      |
> | 381933444  | 42 ca 78 4f 47     |
> | 381933444  | 82 e8 ea fe 16     |
>
>
> Implications
> -------------
>
> I did this as a proof-of-concept in a few hours but I'm still not sure
> about the full implications.
> I'm able to force object mappings. Can this be used as a DOS attack
> vector? Maybe.
>
> I looked through the RadosGW source, in order to find out how object
> names are generated there.
> I only found the second hash function implementation getting used -- but
> I'm not familiar with the source to say more about it at this time.
>
>
> Open questions
> --------------
>
> I'd like to know more about what an impact this could have. In particular:
>
> * How do higher-level API's (e.g. RadosGW) determine the object's name?
> Can this be influenced or set by the user?
> * Is it possible to introduce some randomness, in order to mitigate the
> explained scenario? Maybe on a per-cluster basis or deduced from some
> internal state. (Note: SipHash is doing something similar)
>
>
> Summary
> -------
>
> Ceph's object mapping depends on the rjenkins hash function.
> It's possible to force Ceph into mapping all objects to a single PG.
>
> Please discuss!

Yes, this is an attack vector. It functions against...well, any system
using hash-based placement.
RGW mangles names on its own, although the mangling is deterministic
enough that an attacker could perhaps manipulate it into mangling them
onto the same PG. (Within the constraints, though, it'd be pretty
difficult.)
RBD names objects in a way that users can't really control, so I guess
it's safe, sort of? (But users of rbd will still have write permission
to some class of objects in which they may be able to find an attack.)

The real issue though, is that any user with permission to write to
*any* set of objects directly in the cluster will be able to exploit
this regardless of what barriers we erect. Deterministic placement, in
that anybody directly accessing the cluster can compute data
locations, is central to Ceph's design. We could add "salts" or
something to try and prevent attackers from *outside* the direct set
(eg, users of RGW) exploiting it directly, but anybody who can read or
write from the cluster would need to be able to read the salt in order
to compute locations themselves. So I'm pretty sure this attack vector
is:
1) Inherent to all hash-placement systems,
2) not something we can reasonably defend against *anyway*.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
