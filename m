From: Samuel Just <sjust@redhat.com>
Subject: Re: Need some help fixing an assert
Date: Tue, 16 Feb 2016 14:37:23 -0800
Message-ID: <CAN=+7FXE9Myz2_qnQfw+tFFu794icW6AAgRPnCLeQ8Y8ow_49g@mail.gmail.com>
References: <CAANLjFopvMzfezr=UmJGG1Dzg+VV6bC7cpvuJbGJPxk0AN99WQ@mail.gmail.com>
	<CAANLjFoyBTsLpJHDuOG7=_P8CJipp=Xz9icAFDyeA8PjF7MU4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34134 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123AbcBPWhX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Feb 2016 17:37:23 -0500
Received: by mail-yw0-f174.google.com with SMTP id h129so152426227ywb.1
        for <ceph-devel@vger.kernel.org>; Tue, 16 Feb 2016 14:37:23 -0800 (PST)
In-Reply-To: <CAANLjFoyBTsLpJHDuOG7=_P8CJipp=Xz9icAFDyeA8PjF7MU4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

SubQueue::pop appears to be taking a reference to an object, deleting
that object, and then returning the reference.  That's generally a
no-no.
-Sam

On Tue, Feb 16, 2016 at 1:58 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> What is the lifecycle of the OP through the queue? I'm guessing that a
> reference of the OP is passed into the queue. Maybe when inserting
> that reference into the intrusive data structure it changing the scope
> or something. It looks like pg is falling out of scope between
>
> void PGQueueable::RunVis::operator()(OpRequestRef &op) {
>
> and
>
> void OSD::dequeue_op(
>
> but not when I'm using the standard STL containers. I get (I added
> some more debugging):
>
> Getting data length...
> OpRequest Destroyed.
> Destroyed TrackedOp.
> RunVis: going to dequeue 0x55555ffef000 : 0x55555fdf7c00
> 2016-02-16 21:49:17.612752 7fffd7326700 10 osd.0 240 dequeue_op: Priority = 63
>
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fffd7326700 (LWP 26718)]
> 0x00005555558b0b66 in OSD::dequeue_op (this=0x55555ff4a000, pg=, op=
>    std::shared_ptr (count 3, weak -1) 0x55555fdf7c00, handle=...) at
> osd/OSD.cc:8569
> 8569      unsigned cost = op->get_req()->get_cost();
>
> At least this is the only thing I can come up with. Any ideas?
>
> Thanks,
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.3.5
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWw5tvCRDmVDuy+mK58QAAwTsP/2hmkG7hLYvIgKGGJTyt
> 4E2aQgjXDhtRrKSvtPF3HCGjk9ahdlKAEKxSSLjLfJuWpJf8iM5opRZGv7vG
> Ij4MjZjHVFqlM1ln++bFLO0gZSYn3ieU0l+vopMPyJNJGkJy48Ckk7+1Agh2
> 6TY+3fyuv6bwLcs/IQpCxaQNwo25h0gXYrfz2iyxNaX5ihM9nISZK2lRbdl9
> QtZ2aMvZ8rLKPli6pPXz+viRaYlA92R0vwQuMjzVIos5bbt+Kjtz8PIlBfGo
> Uwj0a6dI0cF1XwmMYhIjabFMLywpGyLTAKElno6wuCAx158x0mSqGEmqqAd3
> NvZ0gHHlyETUt4GEbCP58IClO2MYICWhUt7HnA1mxxjLCGRM6oNMNdG2u6y9
> 3mA8aY0+/GpkIZBVe+CB0VzIvkMfN0lQYQMVaW+QGgQz7/oyiC+tuQgmtEwi
> ZHtPM5D2ve5E9dlWQwUaea8ipMURskijP3Yj7+LFnc0Ik8JD74LilWU60SgQ
> eJ7LnP4M9JRtmF/gQfgu4RD8CWD2lRTnT8ZW5AoZOU9yj0qqpZh/RgNiFENI
> dL2aHW9026u5EI1H7jCOEyR2CmRtf0wTF3nYYPapp/+17oSzqEmSNMH4HZI4
> 1tTJ/XXkFDQtXbj5AWPw5hztFL8/ZAnFs8zALvvpgTnE9XsCOMQaDc7TYt4Y
> ybXt
> =WzP4
> -----END PGP SIGNATURE-----
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
>
> On Mon, Feb 15, 2016 at 11:26 AM, Robert LeBlanc <robert@leblancnet.us> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> I've got https://github.com/ceph/ceph/pull/7654 that I'm working on,
>> but I just can't track down why I'm getting the assert in Mutex::Lock.
>> If you can give me a push in the right direction, it would be very
>> helpful.
>>
>> Thanks,
>> - ----------------
>> Robert LeBlanc
>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> -----BEGIN PGP SIGNATURE-----
>> Version: Mailvelope v1.3.4
>> Comment: https://www.mailvelope.com
>>
>> wsFcBAEBCAAQBQJWwhhBCRDmVDuy+mK58QAAbe0P/1g6raiPu5NipSFS1YF4
>> t2TJOuIlGRkyLhigmb2726VJpYg0ylmaQ7eDyppJ62ek/GIvP084nLLPfgMH
>> ePUnJ+uSQ5tUV2n7qveabqpEPDVWlIUVedcvZDspb9kLJB1/EyhtyXAgacit
>> Ny4yhQOjFQ2QdSS7WH4uz6z7F94UgLc5M+VP+mv6SHjt1Aqo+uIiRtKhUckP
>> 9KbjQjFHk/GaZ9BHdxzINAqv+uTTii9c2cZzWKoKbsMGlcPnSCFgMSZIx/cc
>> /rxXWEZqdb7MnNsR1ZUYhdyAJmhX+PpivWhg+dVQzwTrrQvvlrKo76MgStnW
>> RWa+88JqQkVpZF93aqkhWS7SHqnOv9Yv+aQ6qg6ivVYR/bhyY0TvHI3QqF+7
>> aChuy0YtB4l/imXjpWtfEg5gvT9yVLl+wWeg9TFawpf2OoRlfglFmDBP0daX
>> AnlbwToyKjz5D3TeWxN7EChvk3vPB0tFRt+yRrcnn/4G2UE0PK3k2hX3Tc+2
>> fDVZkeqigTB5vDt1lFuIaUtFpRlgeC407eGgTz2qt6KHOJWmbo1NmztrFuuI
>> gNUp2GuwkHR9177X2iH4Dcg182foaxzJiFHvj1WFvwj9lDNawT8Rdtz12tTv
>> hy7CXKUhvVjxlmq85JYYhmeULX+Z8GZvpAg43/CYGQ8qmBWt72k+LM/7p0NW
>> Om/p
>> =Ml7I
>> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
