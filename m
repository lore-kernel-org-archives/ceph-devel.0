From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: librados aio completion
Date: Mon, 16 Apr 2012 14:32:17 -0700
Message-ID: <CAC-hyiGhHr+Pqf2z53ONZsuUfr-RKUedWU-GyteB8hB8Zgzobw@mail.gmail.com>
References: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
	<CAC-hyiFiL=a6dRaE-UkJ-egj1hJTSWQD-6GUitcmRiXvNrEUEA@mail.gmail.com>
	<Pine.LNX.4.64.1204161157440.10153@cobra.newdream.net>
	<CAC-hyiEFKkohqWhYRgrc0zvbhrZeca=YCrW00JTSqe-0v5DEpQ@mail.gmail.com>
	<D763974EEA9A43E08946E03484894631@dreamhost.com>
	<Pine.LNX.4.64.1204161405580.31853@cobra.newdream.net>
	<59070F5B091941E0934A1175E82717B7@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33260 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab2DPVcS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 17:32:18 -0400
Received: by bkcik5 with SMTP id ik5so4039122bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Apr 2012 14:32:17 -0700 (PDT)
In-Reply-To: <59070F5B091941E0934A1175E82717B7@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Mon, Apr 16, 2012 at 2:20 PM, Greg Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Monday, April 16, 2012 at 2:07 PM, Sage Weil wrote:
>> On Mon, 16 Apr 2012, Greg Farnum wrote:
>> > Or set the bool to true, then do the callback, then signal?
>>
>>
>> That's sort of what I was getting at with
>> wait_for_complete_and_callback_returned(). We could make
>> wait_for_complete() do that, although it should be a second bool because
>> cond.Wait() can wake up nondeterministically (because of a signal or
>> something). For example I could clear the callback pointer after it
>> returns, and make the wait loop check for the bool and callback_ptr ==
>> NULL.
>>
>> It just means the wait_for_complete() does not actually wait for
>> is_complete(), but is_complete() && did callback.
>
>
> Okay. I'm just thinking that we need "wait_for_complete()" to be the stronger variant, since that's how it previously behaved. (Whereas I believe that previously is_complete() and is_safe() functioned correctly inside callbacks, correct? So we need to preserve that behavior as well.)
> If we want the weaker guarantee for some reason, we can add a wait_for_complete_response() or similar.
>

wait_for_ack() : got ack or safe response, entails is_ack()
wait_for_safe(): got safe response, entails is_safe(), is_ack()
wait_for_complete(): done with the request, callback returned, entails
is_complete(), is_safe(), is_ack()
