From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: Forcing Ceph into mapping all objects to a single PG
Date: Tue, 22 Jul 2014 15:44:16 -0700
Message-ID: <lqmpg2$chu$1@ger.gmane.org>
References: <53CD93B4.6020500@trvx.org> <CAPYLRzj4tzBCSrGPCsaLvy1+7ac4=Um1EHDeZhLsCpuZZy7miA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56078 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932980AbaGVWoa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jul 2014 18:44:30 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1X9inM-0003Ty-7C
	for ceph-devel@vger.kernel.org; Wed, 23 Jul 2014 00:44:28 +0200
Received: from 50.245.141.77 ([50.245.141.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jul 2014 00:44:28 +0200
Received: from eternaleye by 50.245.141.77 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jul 2014 00:44:28 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Gregory Farnum wrote:

> On Mon, Jul 21, 2014 at 3:27 PM, Daniel Hofmann <daniel@trvx.org> wrote:
>> Preamble: you might want to read the decent formatted version of this
>> mail at:
>>> https://gist.github.com/daniel-j-h/2daae2237bb21596c97d
<snip aggressively>
>> -------
>>
>> Ceph's object mapping depends on the rjenkins hash function.
>> It's possible to force Ceph into mapping all objects to a single PG.
>>
>> Please discuss!
> 
> Yes, this is an attack vector. It functions against...well, any system
> using hash-based placement.

Sort of. How well it functions is a function (heh) of how easy it is to find 
a preimage against the hash (collision only allows a pair, you need 
preimages to get beyond that).

With fletcher4, preimages aren't particularly difficult to find. By using a 
more robust hash[1], then preimages become more computationally expensive 
since you need to brute-force for each value rather than taking advantage of 
a weakness in the algorithm.

This doesn't buy a huge amount since the bruteforce effort per iteration is 
still bounded by the number of PGs, but it does help - and it means that as 
PGs are split, resistance to the attack increases as well.

> RGW mangles names on its own, although the mangling is deterministic
> enough that an attacker could perhaps manipulate it into mangling them
> onto the same PG. (Within the constraints, though, it'd be pretty
> difficult.)
> RBD names objects in a way that users can't really control, so I guess
> it's safe, sort of? (But users of rbd will still have write permission
> to some class of objects in which they may be able to find an attack.)
> 
> The real issue though, is that any user with permission to write to
> *any* set of objects directly in the cluster will be able to exploit
> this regardless of what barriers we erect. Deterministic placement, in
> that anybody directly accessing the cluster can compute data
> locations, is central to Ceph's design. We could add "salts" or
> something to try and prevent attackers from *outside* the direct set
> (eg, users of RGW) exploiting it directly, but anybody who can read or
> write from the cluster would need to be able to read the salt in order
> to compute locations themselves.

Actually, doing (say) per-pool salts does help in a notable way: even 
someone who can write to two pools can't reuse the computation of colliding 
values across pools. It forces them to expend the work factor for each pool 
they attack, rather than being able to amortize.

> So I'm pretty sure this attack vector
> is:
> 1) Inherent to all hash-placement systems,
> 2) not something we can reasonably defend against *anyway*.

I'd agree that in the absolute sense it's inherent and insoluble, but that 
doesn't imply that _mitigations_ are worthless.

A more drastic option would be to look at how the sfq network scheduler 
handles it - it hashes flows onto a fixed number of queues, and gets around 
collisions by periodically perturbing the salt (resulting in a _stochastic_ 
avoidance of clumping). It'd definitely require some research to find a way 
to do this such that it doesn't cause huge data movement, but it might be 
worth thinking about for the longer term.

[1] I'm thinking along the lines of SipHash, not any heavy-weight 
cryptographic hash; however with network latencies on the table those might 
not be too bad regardless

