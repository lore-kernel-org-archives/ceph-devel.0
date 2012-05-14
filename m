From: Gregory Farnum <greg@inktank.com>
Subject: Re: Disabling logs in the mon data directory?
Date: Mon, 14 May 2012 13:42:30 -0700
Message-ID: <CAPYLRzhmTHiUkDsOgvsvQaUuXbsNVzqVCWEbkAu6Y8bx9eD7jA@mail.gmail.com>
References: <CAPud5_79Vn0xwTSB-2Zhp5sz05DmOgLCWREEP6oV3Frj=QyfCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54075 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757829Ab2ENUmb convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 May 2012 16:42:31 -0400
Received: by lahd3 with SMTP id d3so3648492lah.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 May 2012 13:42:30 -0700 (PDT)
In-Reply-To: <CAPud5_79Vn0xwTSB-2Zhp5sz05DmOgLCWREEP6oV3Frj=QyfCw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

Sorry for the long delay; we've all been really busy here...

On Tue, May 1, 2012 at 4:24 PM, Nick Bartos <nick@pistoncloud.com> wrot=
e:
> I'm trying to get all logs going to syslog, and disable all ceph log
> files. =A0I added the following to [global]:
>
> =A0 =A0log file =3D ""
> =A0 =A0log to syslog =3D true
>
> Which I thought would do the trick, however I see that there are stil=
l
> logs generated in the monitor data directory. =A0I also tried adding =
the
> following to [global], but it doesn't seem to help:
>
> =A0 =A0clog to monitors =3D false
> =A0 =A0clog to syslog =3D true

So I don't know anybody actually running it this way, but these
settings *ought* to work. Do you have that in the config file for each
daemon individually?
If not there's probably some issue with how we're reading in config
files versus creating our logging objects.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
