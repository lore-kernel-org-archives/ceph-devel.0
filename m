From: Loic Dachary <loic@dachary.org>
Subject: Re: Paxos vs Raft
Date: Sat, 14 Sep 2013 23:42:41 +0200
Message-ID: <5234D851.3050500@dachary.org>
References: <5234049D.1080800@dachary.org> <CA+Hcz5-i0pUoZZ8t4kK-chc-y7gAp8Y87NL15BHv81=-58UkyA@mail.gmail.com> <CAPYLRzjWaXoQb_2F2xS042vUn76guR=_i+yEfC9Kk2P18R3D3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig18A828A0A001706628829599"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34900 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782Ab3INVmq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Sep 2013 17:42:46 -0400
In-Reply-To: <CAPYLRzjWaXoQb_2F2xS042vUn76guR=_i+yEfC9Kk2P18R3D3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig18A828A0A001706628829599
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

While reading the Raft paper today and remembering the Paxos implementati=
on in Ceph, I was amazed that it looked so similar. Thanks to your explan=
ation I now understand why ;-)

On 14/09/2013 18:48, Gregory Farnum wrote:
> On Fri, Sep 13, 2013 at 11:39 PM, Loic Dachary <loic@dachary.org> wrote=
:
>> Hi,
>>
>> Ceph ( http://ceph.com/ ) relies on a custom implementation of Paxos t=
o provide exabyte scale distributed storage. Like most people recently ex=
posed to Paxos, I struggle to understand it ... but will keep studying un=
til I get it :-) When a friend mentionned Raft (  http://en.wikipedia.org=
/wiki/Raft_%28computer_science%29 ), it looked like an easy way out. But =
it's very recent and I would very much appreciate your opinion. Do you th=
ink it is a viable alternative to Paxos ?
>=20
> Raft *is* the Paxos people use for all intents and purposes. The
> original Paxos paper and the follow-on "Paxos Made Simple" are very
> much mathematical algorithm papers which describe the necessary
> constraints on a system with Paxos' properties, then define a very
> general system which solves them, then describe a somewhat more
> practical leader-based system. Every implementation I've seen in the
> wild takes that leader system and then applies some of the
> simplifications/enhancements which Lamport suggests in the end of his
> original paper and that Raft has more precisely specified: you elect a
> single leader (using what you might consider to be the full paxos
> system, with very low commit rates!) who is the only one able to
> propose values, then that leader proposes a stream of values which are
> accepted by followers and applied to a shared state (eg, our leveldb
> instance), and recovery happens by electing a new leader who gathers
> the log off of all the other nodes in order to learn what's been
> committed and what can be committed.
> The reason people are enjoying Raft is that it's targeted at system
> implementors instead of theoreticians, so the logical components are
> called out a little more clearly and the phases are separated the way
> you would split them when implementing the algorithms. That said, I'm
> not sure it's *actually* more understandable (even their own test
> results don't really support that assertion); I think you should just
> read both papers and then use whichever one is more understandable as
> the basis for further discussion until you really grok these
> consistency algorithms.
>=20
> On Sat, Sep 14, 2013 at 8:16 AM, Noah Watkins <noah.watkins@inktank.com=
> wrote:
>> I'm curious about what exactly the consensus requirement and
>> assumptions are for the monitors. For instance, in the discussion
>> between Loic and Joao, this statement:
>>
>>   Joao: : the recovery logic in our implementation tries to aleviate
>> the burden of recovering multiple versions at the same time. We
>> propose a version, let the peons accept it, then move on to the next
>> version. On ceph, we only provide one value at a time.
>>
>> seems to indicate that the leader is proposing changes sequentially.
>> However, that makes Ceph's use of paxos sound a lot like the reason
>> for the development of the Zab protocol used in Zookeeper:
>>
>>   https://cwiki.apache.org/confluence/display/ZOOKEEPER/Zab+vs.+Paxos
>=20
> Yes. Our throughput expectations/requirements are significantly lower
> than Zookeeper's. We could extend them to create a pipeline if we
> really wanted to; the one-at-a-time isn't fundamental to the
> algorithms we're using that I can recall. (I am somewhat irked by the
> claim that Zab is a significantly different algorithm from Paxos. It
> certainly fits into the Paxos family of algorithms, although it might
> not be explicitly called out as a variation implementers could use in
> the original paper like most others are.)
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig18A828A0A001706628829599
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlI02FEACgkQ8dLMyEl6F203CACfS9QvwAZekav660/dnx5A5aLu
VkMAn07v17cfwzObzvTMQfOmu9NMf3vl
=Ylig
-----END PGP SIGNATURE-----

--------------enig18A828A0A001706628829599--
