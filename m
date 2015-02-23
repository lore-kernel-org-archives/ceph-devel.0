From: Greg Farnum <gfarnum@redhat.com>
Subject: Re: About in_seq, out_seq in Messenger
Date: Mon, 23 Feb 2015 08:04:44 -0800
Message-ID: <AF011BF6-7D9F-4DF7-9D4F-8005101014CA@redhat.com>
References: <CACJqLyY_UoHO-JxNHcQcZFLpJT8awXb+aAtCG-dj26SdTZ-RgQ@mail.gmail.com> <425811556.75315.1423234030246.JavaMail.zimbra@redhat.com> <CACJqLyZu_-34QVNDrckHNW391qWhphN1cSz4dCACL0hZGng4vQ@mail.gmail.com> <1516374406.1826859.1423497655916.JavaMail.zimbra@redhat.com> <CACJqLyakyGpWVqZnzs4_poQLEX3rfiuimM+tfzVyB=TrDx6Mdw@mail.gmail.com> <AC814495-3C6B-492A-9E34-D45657FF7844@redhat.com> <CACJqLyb=mEfnJmuC=yjkxozKaFtrEYtGiEdD+wTnyeOHxdPNXg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56274 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186AbbBWQEr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Feb 2015 11:04:47 -0500
In-Reply-To: <CACJqLyb=mEfnJmuC=yjkxozKaFtrEYtGiEdD+wTnyeOHxdPNXg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Feb 12, 2015, at 9:17 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>=20
> On Fri, Feb 13, 2015 at 1:26 AM, Greg Farnum <gfarnum@redhat.com> wro=
te:
>> Sorry for the delayed response.
>>=20
>>> On Feb 11, 2015, at 3:48 AM, Haomai Wang <haomaiwang@gmail.com> wro=
te:
>>>=20
>>> Hmm, I got it.
>>>=20
>>> There exists another problem I'm not sure whether captured by upper=
 layer:
>>>=20
>>> two monitor node(A,B) connected with lossless_peer_reuse policy,
>>> 1. lots of messages has been transmitted....
>>> 2. markdown A
>>=20
>> I don=E2=80=99t think monitors ever mark each other down?
>>=20
>>> 3. restart A and call send_message(message will be in out_q)
>>=20
>> oh, maybe you just mean rebooting it, not an interface thing, okay..=
=2E
>>=20
>>> 4. network error injected and A failed to build a *session* with B
>>> 5. because of policy and in_queue() =3D=3D true, we will reconnect =
in "writer()"
>>> 6. connect_seq++ and try to reconnect
>>=20
>> I think you=E2=80=99re wrong about this step. The messenger won=E2=80=
=99t increment connect_seq directly in writer() because it will be in S=
TATE_CONNECTING, so it just calls connect() directly.
>> connect() doesn=E2=80=99t increment the connect_seq unless it succes=
sfully finishes a session negotiation.
>=20
> Hmm, sorry. I checked log again. Actually A doesn't have any message
> in queue. So it will enter standby state and increase connect_seq. It
> will not be *STATE_CONNECTING*.
>=20

Urgh, that case does seem broken, yes. I take it this is something you=E2=
=80=99ve actually run across?

It looks like that connect_seq++ was added by https://github.com/ceph/c=
eph/commit/0fc47e267b6f8dcd4511d887d5ad37d460374c25. Which makes me thi=
nk we might just be able to increment the connect_seq appropriately in =
the connect() function if we need to do so (on replacement, I assume). =
Would you like to look at that and how this change might impact the pee=
r with regards to the referenced assert failure?

-A very slow-to-reply and apologetic Greg

>=20
> 2015-02-13 06:19:22.240788 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D-1 :0 s=3D1 pgs=3D0 cs=3D0 =
l=3D0
> c=3D0x3ed2060).writer: state =3D connecting policy.server=3D0
> 2015-02-13 06:19:22.240801 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D-1 :0 s=3D1 pgs=3D0 cs=3D0 =
l=3D0
> c=3D0x3ed2060).connect 0
> 2015-02-13 06:19:22.240821 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :0 s=3D1 pgs=3D0 cs=3D0 =
l=3D0
> c=3D0x3ed2060).connecting to 127.0.0.1:16800/22032
> 2015-02-13 06:19:22.398009 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=3D=
0 l=3D0
> c=3D0x3ed2060).connect read peer addr 127.0.0.1:16800/22032 on socket=
 91
> 2015-02-13 06:19:22.398026 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=3D=
0 l=3D0
> c=3D0x3ed2060).connect peer addr for me is 127.0.0.1:36265/0
> 2015-02-13 06:19:22.398066 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=3D=
0 l=3D0
> c=3D0x3ed2060).connect sent my addr 127.0.0.1:16813/22045
> 2015-02-13 06:19:22.398089 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=3D=
0 l=3D0
> c=3D0x3ed2060).connect sending gseq=3D8 cseq=3D0 proto=3D24
> 2015-02-13 06:19:22.398115 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=3D=
0 l=3D0
> c=3D0x3ed2060).connect wrote (self +) cseq, waiting for reply
> 2015-02-13 06:19:22.398137 7fdd147c7700  2 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=3D=
0 l=3D0
> c=3D0x3ed2060).connect read reply (0) Success
> 2015-02-13 06:19:22.398155 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=3D=
0 l=3D0
> c=3D0x3ed2060). sleep for 0.1
> 2015-02-13 06:19:22.498243 7fdd147c7700  2 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=3D=
0 l=3D0
> c=3D0x3ed2060).fault (0) Success
> 2015-02-13 06:19:22.498275 7fdd147c7700  0 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=3D=
0 l=3D0
> c=3D0x3ed2060).fault with nothing to send, going to standby
> 2015-02-13 06:19:22.498290 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D3 pgs=3D0 cs=3D=
0 l=3D0
> c=3D0x3ed2060).writer: state =3D standby policy.server=3D0
> 2015-02-13 06:19:22.498301 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D3 pgs=3D0 cs=3D=
0 l=3D0
> c=3D0x3ed2060).writer sleeping
> 2015-02-13 06:19:22.526116 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D3 pgs=3D0 cs=3D=
0 l=3D0
> c=3D0x3ed2060).writer: state =3D standby policy.server=3D0
> 2015-02-13 06:19:22.526132 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect 1
> 2015-02-13 06:19:22.526158 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36265 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connecting to 127.0.0.1:16800/22032
> 2015-02-13 06:19:22.526318 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect read peer addr 127.0.0.1:16800/22032 on socket=
 47
> 2015-02-13 06:19:22.526334 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect peer addr for me is 127.0.0.1:36296/0
> 2015-02-13 06:19:22.526372 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect sent my addr 127.0.0.1:16813/22045
> 2015-02-13 06:19:22.526388 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect sending gseq=3D9 cseq=3D1 proto=3D24
> 2015-02-13 06:19:22.526400 7fdd147c7700  1 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).do_sendmsg error (32) Broken pipe
> 2015-02-13 06:19:22.526417 7fdd147c7700  2 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect couldn't write gseq, cseq, (32) Broken pipe
> 2015-02-13 06:19:22.526433 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060). sleep for 0.1
> 2015-02-13 06:19:22.626511 7fdd147c7700  2 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).fault (32) Broken pipe
> 2015-02-13 06:19:22.626550 7fdd147c7700  0 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).fault
> 2015-02-13 06:19:22.626569 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).writer: state =3D connecting policy.server=3D0
> 2015-02-13 06:19:22.626583 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect 1
> 2015-02-13 06:19:22.626613 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connecting to 127.0.0.1:16800/22032
> 2015-02-13 06:19:22.626810 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect read peer addr 127.0.0.1:16800/22032 on socket=
 47
> 2015-02-13 06:19:22.626831 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect peer addr for me is 127.0.0.1:36306/0
> 2015-02-13 06:19:22.626874 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect sent my addr 127.0.0.1:16813/22045
> 2015-02-13 06:19:22.626893 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect sending gseq=3D11 cseq=3D1 proto=3D24
> 2015-02-13 06:19:22.626907 7fdd147c7700  1 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).do_sendmsg error (32) Broken pipe
> 2015-02-13 06:19:22.626927 7fdd147c7700  2 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect couldn't write gseq, cseq, (32) Broken pipe
> 2015-02-13 06:19:22.626946 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060). sleep for 0.1
> 2015-02-13 06:19:22.727021 7fdd147c7700  2 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).fault (32) Broken pipe
> 2015-02-13 06:19:22.727043 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).fault waiting 0.200000
> 2015-02-13 06:19:22.741935 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).fault done waiting or woke up
> 2015-02-13 06:19:22.745101 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).writer: state =3D connecting policy.server=3D0
> 2015-02-13 06:19:22.745123 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect 1
> 2015-02-13 06:19:22.745172 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connecting to 127.0.0.1:16800/22032
> 2015-02-13 06:19:22.836254 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect read peer addr 127.0.0.1:16800/22032 on socket=
 47
> 2015-02-13 06:19:22.836273 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect peer addr for me is 127.0.0.1:36321/0
> 2015-02-13 06:19:22.836304 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect sent my addr 127.0.0.1:16813/22045
> 2015-02-13 06:19:22.836320 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect sending gseq=3D12 cseq=3D1 proto=3D24
> 2015-02-13 06:19:22.836339 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect wrote (self +) cseq, waiting for reply
> 2015-02-13 06:19:22.836444 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect got reply tag 4 connect_seq 2 global_seq 0 pro=
to
> 24 flags 0 features 1125899906842623
> 2015-02-13 06:19:22.836458 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060). sleep for 0.1
> 2015-02-13 06:19:22.936533 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
1 l=3D0
> c=3D0x3ed2060).connect got RETRY_SESSION 1 -> 2
> 2015-02-13 06:19:22.936558 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
2 l=3D0
> c=3D0x3ed2060).connect sending gseq=3D12 cseq=3D2 proto=3D24
> 2015-02-13 06:19:22.936591 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
2 l=3D0
> c=3D0x3ed2060).connect wrote (self +) cseq, waiting for reply
> 2015-02-13 06:19:23.036975 7fdd147c7700 20 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
2 l=3D0
> c=3D0x3ed2060).connect got reply tag 13 connect_seq 3 global_seq 61
> proto 24 flags 0 features 1125899906842623
> 2015-02-13 06:19:23.036995 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
2 l=3D0
> c=3D0x3ed2060). sleep for 0.1
> 2015-02-13 06:19:23.137083 7fdd147c7700 10 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
2 l=3D0
> c=3D0x3ed2060).got CEPH_MSGR_TAG_SEQ, reading acked_seq and writing
> in_seq
> 2015-02-13 06:19:23.137112 7fdd147c7700  2 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
2 l=3D0
> c=3D0x3ed2060). got newly_acked_seq 4 vs out_seq 0
> 2015-02-13 06:19:23.137128 7fdd147c7700  2 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
2 l=3D0
> c=3D0x3ed2060). discarding previously sent 0 ping magic: 0 v1
> 2015-02-13 06:19:23.137148 7fdd147c7700  2 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
2 l=3D0
> c=3D0x3ed2060). discarding previously sent 0 ping magic: 0 v1
> 2015-02-13 06:19:23.137167 7fdd147c7700  2 -- 127.0.0.1:16813/22045 >=
>
> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=3D=
2 l=3D0
> c=3D0x3ed2060). discarding previously sent 0 ping magic: 0 v1
>=20
>>=20
>> Unless I=E2=80=99m missing something? :)
>> -Greg
>>=20
>>> 7. because of connect_seq !=3D 0, B can't detect remote reset and
>>> in_seq(a large value) will be exchange and cause A
>>> crashed(Pipe.cc:1154)
>>>=20
>>> So I guess we can't increase connect_seq when reconnecting? We need=
 to
>>> let peer side detect remote reset via connect_seq =3D=3D 0.
>>>=20
>>>=20
>>>=20
>>> On Tue, Feb 10, 2015 at 12:00 AM, Gregory Farnum <gfarnum@redhat.co=
m> wrote:
>>>> ----- Original Message -----
>>>>> From: "Haomai Wang" <haomaiwang@gmail.com>
>>>>> To: "Gregory Farnum" <gfarnum@redhat.com>
>>>>> Cc: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org
>>>>> Sent: Friday, February 6, 2015 8:16:42 AM
>>>>> Subject: Re: About in_seq, out_seq in Messenger
>>>>>=20
>>>>> On Fri, Feb 6, 2015 at 10:47 PM, Gregory Farnum <gfarnum@redhat.c=
om> wrote:
>>>>>> ----- Original Message -----
>>>>>>> From: "Haomai Wang" <haomaiwang@gmail.com>
>>>>>>> To: "Sage Weil" <sweil@redhat.com>, "Gregory Farnum" <greg@inkt=
ank.com>
>>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>>> Sent: Friday, February 6, 2015 12:26:18 AM
>>>>>>> Subject: About in_seq, out_seq in Messenger
>>>>>>>=20
>>>>>>> Hi all,
>>>>>>>=20
>>>>>>> Recently we enable a async messenger test job in test
>>>>>>> lab(http://pulpito.ceph.com/sage-2015-02-03_01:15:10-rados-mast=
er-distro-basic-multi/#).
>>>>>>> We hit many failed assert mostly are:
>>>>>>>             assert(0 =3D=3D "old msgs despite reconnect_seq fea=
ture");
>>>>>>>=20
>>>>>>> And assert connection all are cluster messenger which mean it's=
 OSD
>>>>>>> internal connection. The policy associated this connection is
>>>>>>> Messenger::Policy::lossless_peer.
>>>>>>>=20
>>>>>>> So when I dive into this problem, I find something confusing ab=
out
>>>>>>> this. Suppose these steps:
>>>>>>> 1. "lossless_peer" policy is used by both two side connections.
>>>>>>> 2. markdown one side(anyway), peer connection will try to recon=
nect
>>>>>>> 3. then we restart failed side, a new connection is built but
>>>>>>> initiator will think it's a old connection so sending in_seq(10=
)
>>>>>>> 4. new started connection has no message in queue and it will r=
eceive
>>>>>>> peer connection's in_seq(10) and call discard_requeued_up_to(10=
). But
>>>>>>> because no message in queue, it won't modify anything
>>>>>>> 5. now any side issue a message, it will trigger "assert(0 =3D=3D=
 "old
>>>>>>> msgs despite reconnect_seq feature");"
>>>>>>>=20
>>>>>>> I can replay these steps in unittest and actually it's hit in t=
est lab
>>>>>>> for async messenger which follows simple messenger's design.
>>>>>>>=20
>>>>>>> Besides, if we enable reset_check here, "was_session_reset" wil=
l be
>>>>>>> called and it will random out_seq, so it will certainly hit "as=
sert(0
>>>>>>> =3D=3D "skipped incoming seq")".
>>>>>>>=20
>>>>>>> Anything wrong above?
>>>>>>=20
>>>>>> Sage covered most of this. I'll just add that the last time I ch=
ecked it, I
>>>>>> came to the conclusion that the code to use a random out_seq on =
initial
>>>>>> connect was non-functional. So there definitely may be issues th=
ere.
>>>>>>=20
>>>>>> In fact, we've fixed a couple (several?) bugs in this area since=
 Firefly
>>>>>> was initially released, so if you go over the point release
>>>>>> SimpleMessenger patches you might gain some insight. :)
>>>>>> -Greg
>>>>>=20
>>>>> If we want to make random out_seq functional, I think we need to
>>>>> exchange "out_seq" when handshaking too. Otherwise, we need to gi=
ve it
>>>>> up.
>>>>=20
>>>> Possibly. Or maybe we just need to weaken our asserts to infer it =
on initial messages?
>>>>=20
>>>>>=20
>>>>> Another question, do you think "reset_check=3Dtrue" is always goo=
d for
>>>>> osd internal connection?
>>>>=20
>>>> Huh? resetcheck is false for lossless peer connections.
>>>>=20
>>>>>=20
>>>>> Let Messenger rely on upper layer may not a good idea, so maybe w=
e can
>>>>> enhance "in_seq" exchange process(ensure each side
>>>>> in_seq+sent.size()=3D=3Dout_seq). From the current handshake impl=
, it's
>>>>> not easy to insert more action to "in_seq" exchange process, beca=
use
>>>>> this session has been built regardless of the result of "in_seq"
>>>>> process.
>>>>>=20
>>>>> If enable "reset_check=3Dtrue", it looks we can solve most of inc=
orrect
>>>>> seq out-of-sync problem?
>>>>=20
>>>> Oh, I see what you mean.
>>>> Yeah, the problem here is a bit of a mismatch in the interfaces. O=
SDs are "lossless peers" with each other, they should not miss any mess=
ages, and they don't ever go away. Except of course sometimes they do g=
o away, if one of them dies. This is supposed to be handled by marking =
it down, but it turns out the race conditions around that are a little =
larger than we'd realized. Changing that abstraction in the other direc=
tion by enabling reset is also difficult, as witnessed by our vacillati=
ng around how to handle resets in the messenger code base. :/
>>>>=20
>>>> Anyway, you may not have seen http://tracker.ceph.com/issues/9555,=
 which fixes the bug you're seeing here. It will be in the next Firefly=
 point release. :)
>>>> -Greg
>>>=20
>>>=20
>>>=20
>>> --
>>> Best Regards,
>>>=20
>>> Wheat
>>=20
>=20
>=20
>=20
> --=20
> Best Regards,
>=20
> Wheat

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
