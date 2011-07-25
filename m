From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: My favorite question
Date: Mon, 25 Jul 2011 13:54:33 -0700
Message-ID: <CAF3hT9CpsEE5bnyaPiS6hv-Y+4VbwP-1uQ2CWVePXFcSKphkYA@mail.gmail.com>
References: <4E25646C.4000909@ufm.su>
	<Pine.LNX.4.64.1107190728370.5656@cobra.newdream.net>
	<4E2996DD.8040809@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53036 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab1GYUye convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jul 2011 16:54:34 -0400
Received: by gyh3 with SMTP id 3so2492458gyh.19
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jul 2011 13:54:34 -0700 (PDT)
In-Reply-To: <4E2996DD.8040809@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Fri, Jul 22, 2011 at 8:27 AM, Fyodor Ustinov <ufm@ufm.su> wrote:
> On 07/19/2011 05:29 PM, Sage Weil wrote:
>>
>> On Tue, 19 Jul 2011, Fyodor Ustinov wrote:
>>>
>>> Hi!
>>>
>>> 2011-07-19 14:00:39.509391 =A0 log 2011-07-19 14:00:34.185718 osd5
>>> 10.5.51.145:6803/19737 1563 : [ERR] 0.f8 scrub stat mismatch, got
>>> 2074/2074
>>> objects, 0/0 clones, 8624991435/8590119115 bytes, 8422853/8388798 k=
b.
>>> 2011-07-19 14:00:39.509391 =A0 log 2011-07-19 14:00:34.185732 osd5
>>> 10.5.51.145:6803/19737 1564 : [ERR] 0.f8 scrub 1 errors
>>>
>>> How to respond to this message?
>>
>> $ ceph pg repair 0.f8
>>
>> should do the trick!
>>
>> sage
>
> Hmm... But today I seen again:
>
> 2011-07-22 17:26:51.134596 =A0 log 2011-07-22 17:26:51.010146 osd5
> 10.5.51.145:6803/19737 2120 : [ERR] 0.f8 scrub stat mismatch, got 209=
5/2095
> objects, 0/0 clones, 8678199499/8713071819 bytes, 8474814/8508869 kb.
> 2011-07-22 17:26:51.134596 =A0 log 2011-07-22 17:26:51.010159 osd5
> 10.5.51.145:6803/19737 2121 : [ERR] 0.f8 scrub 1 errors
>
> And 'ceph pg repair 0.f8' again fix:
>
> 2011-07-22 18:18:31.158248 =A0 log 2011-07-22 18:18:24.316646 osd5
> 10.5.51.145:6803/19737 2122 : [ERR] 0.f8 repair stat mismatch, got 20=
95/2095
> objects, 0/0 clones, 8678199499/8713071819 bytes, 8474814/8508869 kb.
> 2011-07-22 18:18:31.158248 =A0 log 2011-07-22 18:18:24.316680 osd5
> 10.5.51.145:6803/19737 2123 : [ERR] 0.f8 repair 1 errors, 1 fixed
>
> WBR,
> =A0 =A0Fyodor.

Hmmm, what are you doing with this PG? Have you been doing any snapshot=
s?
I discussed this issue with Sam and it turns out that there's actually
a bug in the scrubbing code because it doesn't handle cloned data
well. That's probably what's happening here; I've created bug
http://tracker.newdream.net/issues/1338 to deal with it.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
