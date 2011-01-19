From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: cephfs set_layout on filesystem root?
Date: Wed, 19 Jan 2011 10:00:41 -0800
Message-ID: <AANLkTikrBWrepGjpfkbjJW6V6ycSZUwX4m-mzHw_Yk15@mail.gmail.com>
References: <1295455606.6777.23.camel@sale659.sandia.gov>
	<AANLkTi=LNa0AyiT4UfyrJLQrUCrPDACBocsiQV=yw7GQ@mail.gmail.com>
	<1295457888.6777.33.camel@sale659.sandia.gov>
	<AANLkTimZ_=WxGPJUcAM0LOwxazXj3nVgNvQSCqRFOk9k@mail.gmail.com>
	<1295459756.6777.41.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44329 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab1ASSAn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 13:00:43 -0500
Received: by eye27 with SMTP id 27so610837eye.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jan 2011 10:00:41 -0800 (PST)
In-Reply-To: <1295459756.6777.41.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 19, 2011 at 9:55 AM, Jim Schutt <jaschut@sandia.gov> wrote:
>> > So the sequence of events was:
>> > - create new file system, start, mount
>> > - create a directory, change its object/stripe sizes (to 512 KiB)
>> > - unmount, shut down filesystem, restart
>> > =A0=3D=3D> osd assert.
>> Okay, this is probably unrelated to your attempt to change non-root
>> dir layouts. (It's in the OSD, which just isn't going to care at all
>> about metadata changes.) Can you gather up the debug info for that a=
nd
>> file a bug report?
>
> Given Sage's reply, do you still want this information?
Sage says it's a known issue, so nope!
Thanks,
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
