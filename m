From: Tommi Virtanen <tv@inktank.com>
Subject: Re: "converting" btrfs osds to xfs?
Date: Tue, 8 May 2012 11:28:05 -0700
Message-ID: <CADvuQRHDkpiDQSn84CvVccHf-pwPzyQZZQcpy34P0TcaWAk-FQ@mail.gmail.com>
References: <CAPud5_6MkeN-6n4rGX=Mew7nGfsmOOAiAtWVgdPArio6z2d_Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34200 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab2EHS20 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 May 2012 14:28:26 -0400
Received: by pbbrp8 with SMTP id rp8so8359032pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 May 2012 11:28:25 -0700 (PDT)
In-Reply-To: <CAPud5_6MkeN-6n4rGX=Mew7nGfsmOOAiAtWVgdPArio6z2d_Fg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Tue, May 8, 2012 at 8:39 AM, Nick Bartos <nick@pistoncloud.com> wrot=
e:
> I am considering converting some OSDs to xfs (currently running btrfs=
)
> for stability reasons. =C2=A0I have a couple of ideas for doing this,=
 and
> was hoping to get some comments:
>
> Method #1:
> 1. =C2=A0Check cluster health and make sure data on a specific OSD is
> replicated elsewhere.
> 2. =C2=A0Bring down the OSD
> 3. =C2=A0Reformat it to xfs
> 4. =C2=A0Restart OSD
> 5. =C2=A0Repeat 1-4 until all btrfs OSDs have been converted.
=2E..
> Obviously #1 seems much more appetizing, but unfortunately I can't
> seem to find out how to verify that data on a specific OSD is
> replicated elsewhere. =C2=A0I could go off general cluster health, bu=
t that
> seems more error prone.

You can set the osd weight in crush to 0 and wait for the files inside
the osd data dir to disappear. If you want to control how much
bandwidth is consumed for this transfer, you can also drop the weight
in e.g. 0.1 decrements. That should give you enough feedback from "du"
or "df" to be comfortable with the fact that your data is actually
moving elsewhere.

I'd recommend completely removing the osd, and creating a new one; you
can even reuse the the osd id. Just don't try to copy the files over
from filesystem to another; the details of the btrfs interaction are
more low-level than what just a tar or cp can capture.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
