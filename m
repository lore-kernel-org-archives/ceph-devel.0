From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [patch RFC] client: return stripe address replicas
Date: Wed, 9 Nov 2011 13:10:21 -0800
Message-ID: <CAF3hT9BGbAVrFhZuXYGw7Qfaed4O_E=TGKOAyX4vQkre_a-XeQ@mail.gmail.com>
References: <1771502131.44602.1320808517281.JavaMail.root@mail-01.cse.ucsc.edu>
	<Pine.LNX.4.64.1111091255150.31435@cobra.newdream.net>
	<CAB2gnbXG0X2NDkhVAHZD0AzU5owp+aPndN0G-y2=+fbFDmqPqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44363 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab1KIVKW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 16:10:22 -0500
Received: by iage36 with SMTP id e36so2144877iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 09 Nov 2011 13:10:22 -0800 (PST)
In-Reply-To: <CAB2gnbXG0X2NDkhVAHZD0AzU5owp+aPndN0G-y2=+fbFDmqPqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: Sage Weil <sage@newdream.net>, Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Nov 9, 2011 at 1:08 PM, Noah Watkins <jayhawk@soe.ucsc.edu> wro=
te:
> On Wed, Nov 9, 2011 at 12:56, Sage Weil <sage@newdream.net> wrote:
>> On Tue, 8 Nov 2011, Noah Watkins wrote:
>>
>> The only issue with this is that, in the event that you don't guess =
a
>> sufficiently large array on the first call, you may need to call aga=
in,
>> and in some cases that may mean multiple MDS requests. =A0Normally t=
hat's
>> not the case. =A0And a smart caller should guess 4 and only pass 0 a=
nd then
>> N if 4 failed. =A0But a naive caller will always make two calls, fir=
st with
>> 0 and then with N, and in some cases that's actually slower.
>
> The code I'm using makes a large guess, and an alternative is for the
> user to cache the replication factor for a file? A similar approach u=
sing
> ERANGE is used by listxattr (well, it communicates ERANGE via errno).
> In any case, even with Tommi's *naddr_out approach, a certain amount
> of precise documentation on it's semantics is needed.

I can't imagine anybody needing location data inside of a fast path,
in any case. So it probably shouldn't matter, and for any bizarre case
where it does we can probably expect a certain level of knowledge!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
