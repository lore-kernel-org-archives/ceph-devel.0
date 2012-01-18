From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: wip-encoding
Date: Tue, 17 Jan 2012 20:56:58 -0800
Message-ID: <CAF3hT9CMJ1MZmA6Dkzj8ZXKpDtYECk_h3s2rudQjYkZDc-2cQw@mail.gmail.com>
References: <Pine.LNX.4.64.1201161520380.27147@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55530 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757072Ab2ARE47 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2012 23:56:59 -0500
Received: by iagf6 with SMTP id f6so5367987iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2012 20:56:58 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201161520380.27147@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 16, 2012 at 3:46 PM, Sage Weil <sage@newdream.net> wrote:
> When we can't handle a change with a compatible encoding change, we c=
an
> introduce a feature bits and conditionally encode old formats for old
> peers. =A0This is just more work and eats into a more limited feature=
 bit
> space.

I'd like to hear a lot more about this =97 it's the real problem. I
think we've already got one example in the codebase of encoding for
backwards-compatibility, and it's a huge mess.
Could we construct reasonable macros/functions that take in compat
bits from the daemon we're targeting and then select the appropriate
encoder based on those, for instance? It certainly shouldn't be hacked
together on a case-by-case basis because we're going to start running
into a lot more of these things as we start testing for
forwards-and-backwards compatibility.

> There are two things going on in this branch. =A0The first part is a
> 'standard' way of constructing the encode/decode functions to facilit=
ate
> backward and forward compatibility and incompatibility detection. =A0=
The
> basic scheme is:
>
> =A01 byte - version of this encoding
> =A01 byte - incompat version.. the oldest code version we expect to b=
e able
> =A0 =A0 =A0 =A0 =A0 to decode this
> =A04 bytes - length of payload
> =A0... data ...
>
> In general, when we decode, we verify that the incompat version is <=3D=
 our
> (code) version. =A0If not, we throw an exception. =A0Then we decode t=
he
> payload, using the version for any conditionals we need to (e.g. to s=
kip
> newly added fields, etc.). =A0We skip any data at the end.
>
> When we revise an encoding, we should add new fields at the end, and =
in
> general leave old fields in place, ideally with values that won't con=
fuse
> old code.

This sounds good to me!

> To make this painless, there are a few new macros to do the encode/de=
code
> boilerplate. =A0If the encode/decode functions we originally
>
> =A0void pool_snap_info_t::encode(bufferlist& bl) const
> =A0{
> =A0 __u8 struct_v =3D 1;
> =A0 ::encode(struct_v, bl);
> =A0 ::encode(snapid, bl);
> =A0 ::encode(stamp, bl);
> =A0 ::encode(name, bl);
> =A0}
>
> =A0void pool_snap_info_t::decode(bufferlist::iterator& bl)
> =A0{
> =A0 __u8 struct_v;
> =A0 ::decode(struct_v, bl);
> =A0 ::decode(snapid, bl);
> =A0 ::decode(stamp, bl);
> =A0 ::decode(name, bl);
> =A0}
>
> then we would revise them to be
>
> =A0void pool_snap_info_t::encode(bufferlist& bl) const
> =A0{
> =A0 ENCODE_START(2, 2, bl);
>
> New version is 2. =A0v1 code can't decode this, so the second argumen=
t
> (incompat) is also 2.
>
> =A0 ::encode(snapid, bl);
> =A0 ::encode(stamp, bl);
> =A0 ::encode(name, bl);
> =A0 ::encode(new_thing, bl);
> =A0 ENCODE_FINISH();
> =A0}
>
> =A0void pool_snap_info_t::decode(bufferlist::iterator& bl)
> =A0{
> =A0 DECODE_START_LEGACY(2, bl, 2);
>
> We can still decode v1 code, but it doesn't have the (new) length and
> incompat version fields, so use the _LEGACY macro. =A0The second 2 me=
ans we
> started using the new approach with v2.

Is there a DECODE_START (non-legacy) for new structs?

> This requires and initial incompat change to add the length and incom=
pat
> fields, but then we can generally add things without breakage.
Hmm...if we come up with something that talks feature bits we could do
this nicely with a compat bit. :)

> The second question is how to test compatibility between different
> versions of code. =A0There are a few parts to this.
>
> First, a ceph-dencoder tool is compiled for each version of the code =
that
> is able to encode, decode, and dump (in json) whatever structures we
> support. =A0It works something like this:
>
> =A0ceph-dencoder object_info_t -i inputfile decode dump_json
>
> to read in encoded data, decode it, and dump it into json. =A0We can =
do a
> trivial identity check (that decode of encode matches) with
>
> =A0ceph-dencoder object_info_t -i inputfile decode dump_json > /tmp/a
> =A0ceph-dencoder object_info_t -i inputfile decode encode decode dump=
_json > /tmp/b
> =A0cmp /tmp/a tmp/b
>
> Obviously that should always pass. =A0For testing cross-version encod=
ing, we
> need a ceph-dencoder and a corpus of objects encoded for each version=
=2E
> Assuming you have that, you can (a) make sure we can decode anything =
from
> other versions without crashing, (b) compare the dumps between versio=
n and
> whitelist changes (e.g., when fields are added or removed). =A0You ca=
n also
> specify feature bits to test encoding for older versions, and take, s=
ay
> everything for the v0.42 corpus, encode for the v0.40 feature bits, a=
nd
> verify that the 0.40 version of ceph-dencoder can handle it. =A0And
> verify+whitelist diffs.
Awesome!

> How to build the per-version corpus? =A0We can write unit tests that
> explicitly generate interesting object instances. =A0That's tedious a=
nd time
> consuming, but probably best, since the developer knows what corner c=
ases
> are interesting.

If we've got a single tool that can handle all the structs we can
presumably encode each struct from a given version?
Obviously constructing actual state would require more work but just
checking the default constructor version of each struct would go a
long, loooong way toward automating encode/decode checks.

-off to review the actual code,
Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
