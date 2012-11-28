From: Samuel Just <sam.just@inktank.com>
Subject: Re: OSD and MON memory usage
Date: Wed, 28 Nov 2012 13:00:17 -0800
Message-ID: <CA+4uBUYv49DmX0EC5QovOtpgR5=TFM1xK4LPjp0M-8bM9B_0iA@mail.gmail.com>
References: <20121116172401.ef3e5e52.ctpm@ist.utl.pt>
	<50AFA848.4050109@inktank.com>
	<20121127172350.b6d21634.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52229 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344Ab2K1VAS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Nov 2012 16:00:18 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so10627673vcm.19
        for <ceph-devel@vger.kernel.org>; Wed, 28 Nov 2012 13:00:17 -0800 (PST)
In-Reply-To: <20121127172350.b6d21634.ctpm@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Cl=E1udio_Martins?= <ctpm@ist.utl.pt>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

What replication level are you using?
-Sam

On Tue, Nov 27, 2012 at 9:23 AM, Cl=E1udio Martins <ctpm@ist.utl.pt> wr=
ote:
>
> On Fri, 23 Nov 2012 16:46:00 +0000 Joao Eduardo Luis <joao.luis@inkta=
nk.com> wrote:
>> On 11/16/2012 05:24 PM, Cl=E1udio Martins wrote:
>> >  As for the monitor daemon on this cluster (running on a dedicated
>> > machine), it is currently using 3.2GB of memory, and it got to tha=
t
>> > point again in a matter of minutes after being restarted. Would it=
 be
>> > good if we tested with the changes from the wip-mon-leaks-fix bran=
ch?
>>
>> Following up on this, wip-mon-leaks-fix was merged into master a cou=
ple
>> of days ago. If you have the chance to check if that fixes your memo=
ry
>> consumption issues on the monitor, it would be much appreciated!
>>
>
>  Hi Jo=E3o,
>
>  I've had a chance to test it and it does indeed seem to make a big
> difference on mon memory usage.
>
>  As for the OSD memory usage issue, it's still looking really bad. I'=
m
> preparing to do more testing and send more info about this, but a lot
> of unrelated stuff crept up this week and things are going slowly on
> this front. I hope to talk more about this before the weekend.
>
> Thanks!
>
> Cl=E1udio
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
