From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: simplifying compound operations
Date: Tue, 17 Jan 2012 15:28:34 -0800
Message-ID: <CAF3hT9CPa49u3hktnROPbOrQ-_-9KTDDzk1DfNiRC4FiA3EXOA@mail.gmail.com>
References: <Pine.LNX.4.64.1201121628360.18796@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:62804 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755252Ab2AQX2f convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Jan 2012 18:28:35 -0500
Received: by obcva7 with SMTP id va7so6463181obc.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2012 15:28:34 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201121628360.18796@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

I made some line notes on Github about this series, but apart from
those it looks good; the design makes sense.

One other thing, though: we are going to need to rev the librados
version for this, yes? So it should probably wait until our C bindings
are complete.
-Greg

On Thu, Jan 12, 2012 at 4:40 PM, Sage Weil <sage@newdream.net> wrote:
> One of the features of the Ceph OSDs is the ability to do complex com=
pound
> operations atomically. =A0Things like "write object + set xattr" or "=
read
> xattr + read object data" or even "verify xattr foo =3D bar, and if s=
o,
> write object data".
>
> Compound operations are built as a vector<OSDOp>, where each OSDOp ha=
s the
> description of the operation and an input bufferlist. =A0For results,
> however, results accumulate in a single buffer and the caller is
> responsible for picking through the pile for the results of those
> operations. =A0That clearly sucks.
>
> Enter wip-op-data-mux branch,
> =A0 =A0 =A0 =A0https://github.com/NewDreamNetwork/ceph/commits/wip-op=
-data-mux
>
> First, we rename OSDOp::data -> indata, and add an outdata. =A0We als=
o add
> an rval so you can get the result code for individual operations. =A0=
The
> MOSDOpReply message encoding is updated to pass that over the wire to=
 the
> client. =A0(This is upwards and downwards compatible change.)
>
> =A0 =A0 =A0 =A0https://github.com/NewDreamNetwork/ceph/commit/a855828=
4db178cfaf07a20bc475e7366c7903ffd
>
> The OSD is updated to actually put results in those OSDOp fields:
>
> =A0 =A0 =A0 =A0https://github.com/NewDreamNetwork/ceph/commit/ff55d2f=
310312bb5390326dcc35961d39ccad416
>
> Conveniently, that change doesn't actually affect the resulting encod=
ing
> for old clients, except that the OSDOp::op::payload_len is now filled=
 in
> properly--and nobody ever looked at that before. =A0Old (and new) cli=
ents
> will still see the haystack.
>
> Then, we extend the Objecter (client-side) ObjectOperation methods fo=
r
> read operations (read(..), getxattr(..), etc.) to take pointer argume=
nts
> for where the results go:
>
> =A0 =A0 =A0 =A0https://github.com/NewDreamNetwork/ceph/commit/fe07783=
2b915175b8ed7880c1fa285309c642563
>
> and the Objecter will sift through the haystack and fill those guys i=
n
> when the reply comes back.
>
> Finally, the librados ObjectReadOperations are similarly updated:
>
> =A0 =A0 =A0 =A0https://github.com/NewDreamNetwork/ceph/commit/920bd56=
85c195e0a3c1c3c43f124fe904a73c9b3
>
> Currently the arguments are optional, but I'm updating the rgw caller=
s now
> and it makes things _way_ cleaner. =A0It's probably best to make them
> required so that librados users don't need to have internal knowledge=
 of
> how we encoding things over the wire, e.g. for things like stat().
>
> I haven't finished testing this yet. =A0Mainly I want to know if the
> Objecter internal API and librados external API changes make sense.
> And/or if there are any alternative ideas about how this should be
> approached...
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
