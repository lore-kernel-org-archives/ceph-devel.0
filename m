From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: My favorite question
Date: Tue, 26 Jul 2011 15:24:14 -0700
Message-ID: <CAF3hT9CtaCi8S56+hGpU0mn-tH1WJob081J4Bb0_Z7asPZcXdA@mail.gmail.com>
References: <4E25646C.4000909@ufm.su>
	<Pine.LNX.4.64.1107190728370.5656@cobra.newdream.net>
	<4E2996DD.8040809@ufm.su>
	<CAF3hT9CpsEE5bnyaPiS6hv-Y+4VbwP-1uQ2CWVePXFcSKphkYA@mail.gmail.com>
	<4E2DDD1D.2040003@ufm.su>
	<CAF3hT9CZZAn7+bV02TNtSunj4zDTvfwpMkDc-NyRJMXAh85hJg@mail.gmail.com>
	<4E2E04C2.2050000@ufm.su>
	<CAF3hT9AMrbtu051uQaBAAMnfnUWrSFdBHix9FFYgzLrg42YV5g@mail.gmail.com>
	<4E2F0981.50504@ufm.su>
	<CAF3hT9AD+f6gEbzihUpNFKSfhALvMoPpudHDXxnmL5PRyOPZ0Q@mail.gmail.com>
	<4E2F135C.5010306@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44219 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab1GZWYQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2011 18:24:16 -0400
Received: by gxk21 with SMTP id 21so646211gxk.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jul 2011 15:24:15 -0700 (PDT)
In-Reply-To: <4E2F135C.5010306@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Hmm, I'm afraid I can't see anything useful in these logs right now --
just confusion!

The only thing I can think of that might provide useful information
now is to turn off osd5, update its config file to have heavy
debugging information (debug osd =3D 20, at a minimum), and then start
the OSD back up again. Then we can see if pg 0.256 is still having any
issues (it is in the logs you sent me).

If not I'll have to mark this as "Can't reproduce" and hope we see it
again from somebody with higher log levels on. :(
-Greg

On Tue, Jul 26, 2011 at 12:19 PM, Fyodor Ustinov <ufm@ufm.su> wrote:
> On 07/26/2011 09:40 PM, Gregory Farnum wrote:
>>
>> On Tue, Jul 26, 2011 at 11:37 AM, Fyodor Ustinov<ufm@ufm.su> =A0wrot=
e:
>>>
>>> On 07/26/2011 09:07 PM, Gregory Farnum wrote:
>>>>
>>>> The log is giving me some very strange information. Can you attach=
 all
>>>> the logs that you have to tracker issue #1340?
>>>> (http://tracker.newdream.net/issues/1340)
>>>> Thanks!
>>>> -Greg
>>>>
>>> "All" - all available? Or only osd5?
>>
>> osd5 for now. Maybe the other daemon logs later. :)
>
> Done!
>
> WBR,
> =A0 =A0Fyodor.
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
