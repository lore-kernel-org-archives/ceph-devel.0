From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: About in_seq, out_seq in Messenger
Date: Tue, 24 Feb 2015 23:18:08 +0800
Message-ID: <CACJqLyagOUrOe3Ch6s-bskL6s1SDd5aB_eWk0hhYhtURicNq=A@mail.gmail.com>
References: <CACJqLyY_UoHO-JxNHcQcZFLpJT8awXb+aAtCG-dj26SdTZ-RgQ@mail.gmail.com>
	<425811556.75315.1423234030246.JavaMail.zimbra@redhat.com>
	<CACJqLyZu_-34QVNDrckHNW391qWhphN1cSz4dCACL0hZGng4vQ@mail.gmail.com>
	<1516374406.1826859.1423497655916.JavaMail.zimbra@redhat.com>
	<CACJqLyakyGpWVqZnzs4_poQLEX3rfiuimM+tfzVyB=TrDx6Mdw@mail.gmail.com>
	<AC814495-3C6B-492A-9E34-D45657FF7844@redhat.com>
	<CACJqLyb=mEfnJmuC=yjkxozKaFtrEYtGiEdD+wTnyeOHxdPNXg@mail.gmail.com>
	<AF011BF6-7D9F-4DF7-9D4F-8005101014CA@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43579 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbbBXPSJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 10:18:09 -0500
Received: by paceu11 with SMTP id eu11so36644322pac.10
        for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2015 07:18:08 -0800 (PST)
In-Reply-To: <AF011BF6-7D9F-4DF7-9D4F-8005101014CA@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Feb 24, 2015 at 12:04 AM, Greg Farnum <gfarnum@redhat.com> wrot=
e:
> On Feb 12, 2015, at 9:17 PM, Haomai Wang <haomaiwang@gmail.com> wrote=
:
>>
>> On Fri, Feb 13, 2015 at 1:26 AM, Greg Farnum <gfarnum@redhat.com> wr=
ote:
>>> Sorry for the delayed response.
>>>
>>>> On Feb 11, 2015, at 3:48 AM, Haomai Wang <haomaiwang@gmail.com> wr=
ote:
>>>>
>>>> Hmm, I got it.
>>>>
>>>> There exists another problem I'm not sure whether captured by uppe=
r layer:
>>>>
>>>> two monitor node(A,B) connected with lossless_peer_reuse policy,
>>>> 1. lots of messages has been transmitted....
>>>> 2. markdown A
>>>
>>> I don=E2=80=99t think monitors ever mark each other down?
>>>
>>>> 3. restart A and call send_message(message will be in out_q)
>>>
>>> oh, maybe you just mean rebooting it, not an interface thing, okay.=
=2E.
>>>
>>>> 4. network error injected and A failed to build a *session* with B
>>>> 5. because of policy and in_queue() =3D=3D true, we will reconnect=
 in "writer()"
>>>> 6. connect_seq++ and try to reconnect
>>>
>>> I think you=E2=80=99re wrong about this step. The messenger won=E2=80=
=99t increment connect_seq directly in writer() because it will be in S=
TATE_CONNECTING, so it just calls connect() directly.
>>> connect() doesn=E2=80=99t increment the connect_seq unless it succe=
ssfully finishes a session negotiation.
>>
>> Hmm, sorry. I checked log again. Actually A doesn't have any message
>> in queue. So it will enter standby state and increase connect_seq. I=
t
>> will not be *STATE_CONNECTING*.
>>
>
> Urgh, that case does seem broken, yes. I take it this is something yo=
u=E2=80=99ve actually run across?
>
> It looks like that connect_seq++ was added by https://github.com/ceph=
/ceph/commit/0fc47e267b6f8dcd4511d887d5ad37d460374c25. Which makes me t=
hink we might just be able to increment the connect_seq appropriately i=
n the connect() function if we need to do so (on replacement, I assume)=
=2E Would you like to look at that and how this change might impact the=
 peer with regards to the referenced assert failure?
>
> -A very slow-to-reply and apologetic Greg

Thanks to Greg!

I looked at commit(https://github.com/ceph/ceph/commit/0fc47e267b6f8dcd=
4511d887d5ad37d460374c25#diff-500cebf3665775f2e77db1ff88255b9bR1553)
and think it's useless now.

When accepting and "connect.connect_seq =3D=3D existing->connect_seq",
existing->state maybe STATE_OPEN, STATE_STANDBY or STANDY_CONNECTING.
This commit only fix partial problem and want to assert
"(existing->state =3D=3D STATE_CONNECTING)". So later we added codes to
catch "(existing->state =3D=3D STATE_OPEN || existing->state =3D=3D
STATE_STANDBY)" before asserting.

So from my point, this commit is unnecessary now and we can drop this c=
ommit.

@sage, what do you think? Any other corner point this commit considered=
?

>
>>
>> 2015-02-13 06:19:22.240788 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D-1 :0 s=3D1 pgs=3D0 cs=3D0=
 l=3D0
>> c=3D0x3ed2060).writer: state =3D connecting policy.server=3D0
>> 2015-02-13 06:19:22.240801 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D-1 :0 s=3D1 pgs=3D0 cs=3D0=
 l=3D0
>> c=3D0x3ed2060).connect 0
>> 2015-02-13 06:19:22.240821 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :0 s=3D1 pgs=3D0 cs=3D0=
 l=3D0
>> c=3D0x3ed2060).connecting to 127.0.0.1:16800/22032
>> 2015-02-13 06:19:22.398009 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=
=3D0 l=3D0
>> c=3D0x3ed2060).connect read peer addr 127.0.0.1:16800/22032 on socke=
t 91
>> 2015-02-13 06:19:22.398026 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=
=3D0 l=3D0
>> c=3D0x3ed2060).connect peer addr for me is 127.0.0.1:36265/0
>> 2015-02-13 06:19:22.398066 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=
=3D0 l=3D0
>> c=3D0x3ed2060).connect sent my addr 127.0.0.1:16813/22045
>> 2015-02-13 06:19:22.398089 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=
=3D0 l=3D0
>> c=3D0x3ed2060).connect sending gseq=3D8 cseq=3D0 proto=3D24
>> 2015-02-13 06:19:22.398115 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=
=3D0 l=3D0
>> c=3D0x3ed2060).connect wrote (self +) cseq, waiting for reply
>> 2015-02-13 06:19:22.398137 7fdd147c7700  2 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=
=3D0 l=3D0
>> c=3D0x3ed2060).connect read reply (0) Success
>> 2015-02-13 06:19:22.398155 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=
=3D0 l=3D0
>> c=3D0x3ed2060). sleep for 0.1
>> 2015-02-13 06:19:22.498243 7fdd147c7700  2 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=
=3D0 l=3D0
>> c=3D0x3ed2060).fault (0) Success
>> 2015-02-13 06:19:22.498275 7fdd147c7700  0 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=
=3D0 l=3D0
>> c=3D0x3ed2060).fault with nothing to send, going to standby
>> 2015-02-13 06:19:22.498290 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D3 pgs=3D0 cs=
=3D0 l=3D0
>> c=3D0x3ed2060).writer: state =3D standby policy.server=3D0
>> 2015-02-13 06:19:22.498301 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D3 pgs=3D0 cs=
=3D0 l=3D0
>> c=3D0x3ed2060).writer sleeping
>> 2015-02-13 06:19:22.526116 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D3 pgs=3D0 cs=
=3D0 l=3D0
>> c=3D0x3ed2060).writer: state =3D standby policy.server=3D0
>> 2015-02-13 06:19:22.526132 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D91 :36265 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect 1
>> 2015-02-13 06:19:22.526158 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36265 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connecting to 127.0.0.1:16800/22032
>> 2015-02-13 06:19:22.526318 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect read peer addr 127.0.0.1:16800/22032 on socke=
t 47
>> 2015-02-13 06:19:22.526334 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect peer addr for me is 127.0.0.1:36296/0
>> 2015-02-13 06:19:22.526372 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect sent my addr 127.0.0.1:16813/22045
>> 2015-02-13 06:19:22.526388 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect sending gseq=3D9 cseq=3D1 proto=3D24
>> 2015-02-13 06:19:22.526400 7fdd147c7700  1 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).do_sendmsg error (32) Broken pipe
>> 2015-02-13 06:19:22.526417 7fdd147c7700  2 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect couldn't write gseq, cseq, (32) Broken pipe
>> 2015-02-13 06:19:22.526433 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060). sleep for 0.1
>> 2015-02-13 06:19:22.626511 7fdd147c7700  2 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).fault (32) Broken pipe
>> 2015-02-13 06:19:22.626550 7fdd147c7700  0 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).fault
>> 2015-02-13 06:19:22.626569 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).writer: state =3D connecting policy.server=3D0
>> 2015-02-13 06:19:22.626583 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect 1
>> 2015-02-13 06:19:22.626613 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36296 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connecting to 127.0.0.1:16800/22032
>> 2015-02-13 06:19:22.626810 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect read peer addr 127.0.0.1:16800/22032 on socke=
t 47
>> 2015-02-13 06:19:22.626831 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect peer addr for me is 127.0.0.1:36306/0
>> 2015-02-13 06:19:22.626874 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect sent my addr 127.0.0.1:16813/22045
>> 2015-02-13 06:19:22.626893 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect sending gseq=3D11 cseq=3D1 proto=3D24
>> 2015-02-13 06:19:22.626907 7fdd147c7700  1 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).do_sendmsg error (32) Broken pipe
>> 2015-02-13 06:19:22.626927 7fdd147c7700  2 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect couldn't write gseq, cseq, (32) Broken pipe
>> 2015-02-13 06:19:22.626946 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060). sleep for 0.1
>> 2015-02-13 06:19:22.727021 7fdd147c7700  2 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).fault (32) Broken pipe
>> 2015-02-13 06:19:22.727043 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).fault waiting 0.200000
>> 2015-02-13 06:19:22.741935 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).fault done waiting or woke up
>> 2015-02-13 06:19:22.745101 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).writer: state =3D connecting policy.server=3D0
>> 2015-02-13 06:19:22.745123 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect 1
>> 2015-02-13 06:19:22.745172 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36306 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connecting to 127.0.0.1:16800/22032
>> 2015-02-13 06:19:22.836254 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect read peer addr 127.0.0.1:16800/22032 on socke=
t 47
>> 2015-02-13 06:19:22.836273 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect peer addr for me is 127.0.0.1:36321/0
>> 2015-02-13 06:19:22.836304 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect sent my addr 127.0.0.1:16813/22045
>> 2015-02-13 06:19:22.836320 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect sending gseq=3D12 cseq=3D1 proto=3D24
>> 2015-02-13 06:19:22.836339 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect wrote (self +) cseq, waiting for reply
>> 2015-02-13 06:19:22.836444 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect got reply tag 4 connect_seq 2 global_seq 0 pr=
oto
>> 24 flags 0 features 1125899906842623
>> 2015-02-13 06:19:22.836458 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060). sleep for 0.1
>> 2015-02-13 06:19:22.936533 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D1 l=3D0
>> c=3D0x3ed2060).connect got RETRY_SESSION 1 -> 2
>> 2015-02-13 06:19:22.936558 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D2 l=3D0
>> c=3D0x3ed2060).connect sending gseq=3D12 cseq=3D2 proto=3D24
>> 2015-02-13 06:19:22.936591 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D2 l=3D0
>> c=3D0x3ed2060).connect wrote (self +) cseq, waiting for reply
>> 2015-02-13 06:19:23.036975 7fdd147c7700 20 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D2 l=3D0
>> c=3D0x3ed2060).connect got reply tag 13 connect_seq 3 global_seq 61
>> proto 24 flags 0 features 1125899906842623
>> 2015-02-13 06:19:23.036995 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D2 l=3D0
>> c=3D0x3ed2060). sleep for 0.1
>> 2015-02-13 06:19:23.137083 7fdd147c7700 10 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D2 l=3D0
>> c=3D0x3ed2060).got CEPH_MSGR_TAG_SEQ, reading acked_seq and writing
>> in_seq
>> 2015-02-13 06:19:23.137112 7fdd147c7700  2 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D2 l=3D0
>> c=3D0x3ed2060). got newly_acked_seq 4 vs out_seq 0
>> 2015-02-13 06:19:23.137128 7fdd147c7700  2 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D2 l=3D0
>> c=3D0x3ed2060). discarding previously sent 0 ping magic: 0 v1
>> 2015-02-13 06:19:23.137148 7fdd147c7700  2 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D2 l=3D0
>> c=3D0x3ed2060). discarding previously sent 0 ping magic: 0 v1
>> 2015-02-13 06:19:23.137167 7fdd147c7700  2 -- 127.0.0.1:16813/22045 =
>>
>> 127.0.0.1:16800/22032 pipe(0x3f82020 sd=3D47 :36321 s=3D1 pgs=3D0 cs=
=3D2 l=3D0
>> c=3D0x3ed2060). discarding previously sent 0 ping magic: 0 v1
>>
>>>
>>> Unless I=E2=80=99m missing something? :)
>>> -Greg
>>>
>>>> 7. because of connect_seq !=3D 0, B can't detect remote reset and
>>>> in_seq(a large value) will be exchange and cause A
>>>> crashed(Pipe.cc:1154)
>>>>
>>>> So I guess we can't increase connect_seq when reconnecting? We nee=
d to
>>>> let peer side detect remote reset via connect_seq =3D=3D 0.
>>>>
>>>>
>>>>
>>>> On Tue, Feb 10, 2015 at 12:00 AM, Gregory Farnum <gfarnum@redhat.c=
om> wrote:
>>>>> ----- Original Message -----
>>>>>> From: "Haomai Wang" <haomaiwang@gmail.com>
>>>>>> To: "Gregory Farnum" <gfarnum@redhat.com>
>>>>>> Cc: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org
>>>>>> Sent: Friday, February 6, 2015 8:16:42 AM
>>>>>> Subject: Re: About in_seq, out_seq in Messenger
>>>>>>
>>>>>> On Fri, Feb 6, 2015 at 10:47 PM, Gregory Farnum <gfarnum@redhat.=
com> wrote:
>>>>>>> ----- Original Message -----
>>>>>>>> From: "Haomai Wang" <haomaiwang@gmail.com>
>>>>>>>> To: "Sage Weil" <sweil@redhat.com>, "Gregory Farnum" <greg@ink=
tank.com>
>>>>>>>> Cc: ceph-devel@vger.kernel.org
>>>>>>>> Sent: Friday, February 6, 2015 12:26:18 AM
>>>>>>>> Subject: About in_seq, out_seq in Messenger
>>>>>>>>
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> Recently we enable a async messenger test job in test
>>>>>>>> lab(http://pulpito.ceph.com/sage-2015-02-03_01:15:10-rados-mas=
ter-distro-basic-multi/#).
>>>>>>>> We hit many failed assert mostly are:
>>>>>>>>             assert(0 =3D=3D "old msgs despite reconnect_seq fe=
ature");
>>>>>>>>
>>>>>>>> And assert connection all are cluster messenger which mean it'=
s OSD
>>>>>>>> internal connection. The policy associated this connection is
>>>>>>>> Messenger::Policy::lossless_peer.
>>>>>>>>
>>>>>>>> So when I dive into this problem, I find something confusing a=
bout
>>>>>>>> this. Suppose these steps:
>>>>>>>> 1. "lossless_peer" policy is used by both two side connections=
=2E
>>>>>>>> 2. markdown one side(anyway), peer connection will try to reco=
nnect
>>>>>>>> 3. then we restart failed side, a new connection is built but
>>>>>>>> initiator will think it's a old connection so sending in_seq(1=
0)
>>>>>>>> 4. new started connection has no message in queue and it will =
receive
>>>>>>>> peer connection's in_seq(10) and call discard_requeued_up_to(1=
0). But
>>>>>>>> because no message in queue, it won't modify anything
>>>>>>>> 5. now any side issue a message, it will trigger "assert(0 =3D=
=3D "old
>>>>>>>> msgs despite reconnect_seq feature");"
>>>>>>>>
>>>>>>>> I can replay these steps in unittest and actually it's hit in =
test lab
>>>>>>>> for async messenger which follows simple messenger's design.
>>>>>>>>
>>>>>>>> Besides, if we enable reset_check here, "was_session_reset" wi=
ll be
>>>>>>>> called and it will random out_seq, so it will certainly hit "a=
ssert(0
>>>>>>>> =3D=3D "skipped incoming seq")".
>>>>>>>>
>>>>>>>> Anything wrong above?
>>>>>>>
>>>>>>> Sage covered most of this. I'll just add that the last time I c=
hecked it, I
>>>>>>> came to the conclusion that the code to use a random out_seq on=
 initial
>>>>>>> connect was non-functional. So there definitely may be issues t=
here.
>>>>>>>
>>>>>>> In fact, we've fixed a couple (several?) bugs in this area sinc=
e Firefly
>>>>>>> was initially released, so if you go over the point release
>>>>>>> SimpleMessenger patches you might gain some insight. :)
>>>>>>> -Greg
>>>>>>
>>>>>> If we want to make random out_seq functional, I think we need to
>>>>>> exchange "out_seq" when handshaking too. Otherwise, we need to g=
ive it
>>>>>> up.
>>>>>
>>>>> Possibly. Or maybe we just need to weaken our asserts to infer it=
 on initial messages?
>>>>>
>>>>>>
>>>>>> Another question, do you think "reset_check=3Dtrue" is always go=
od for
>>>>>> osd internal connection?
>>>>>
>>>>> Huh? resetcheck is false for lossless peer connections.
>>>>>
>>>>>>
>>>>>> Let Messenger rely on upper layer may not a good idea, so maybe =
we can
>>>>>> enhance "in_seq" exchange process(ensure each side
>>>>>> in_seq+sent.size()=3D=3Dout_seq). From the current handshake imp=
l, it's
>>>>>> not easy to insert more action to "in_seq" exchange process, bec=
ause
>>>>>> this session has been built regardless of the result of "in_seq"
>>>>>> process.
>>>>>>
>>>>>> If enable "reset_check=3Dtrue", it looks we can solve most of in=
correct
>>>>>> seq out-of-sync problem?
>>>>>
>>>>> Oh, I see what you mean.
>>>>> Yeah, the problem here is a bit of a mismatch in the interfaces. =
OSDs are "lossless peers" with each other, they should not miss any mes=
sages, and they don't ever go away. Except of course sometimes they do =
go away, if one of them dies. This is supposed to be handled by marking=
 it down, but it turns out the race conditions around that are a little=
 larger than we'd realized. Changing that abstraction in the other dire=
ction by enabling reset is also difficult, as witnessed by our vacillat=
ing around how to handle resets in the messenger code base. :/
>>>>>
>>>>> Anyway, you may not have seen http://tracker.ceph.com/issues/9555=
, which fixes the bug you're seeing here. It will be in the next Firefl=
y point release. :)
>>>>> -Greg
>>>>
>>>>
>>>>
>>>> --
>>>> Best Regards,
>>>>
>>>> Wheat
>>>
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
