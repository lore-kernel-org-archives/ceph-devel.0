From: Florian Haas <florian@hastexo.com>
Subject: Re: v0.42 not compiling .deb's (but v0.41 can)
Date: Tue, 21 Feb 2012 10:58:49 +0100
Message-ID: <CAPUexz9b3-qCDLZ4uHmamdygh54X5WA5J5nAdL3RqxcuxFZ3Zg@mail.gmail.com>
References: <81C477727102DA4E9B2605AC748C495407E36DF7D7@exch10>
	<81C477727102DA4E9B2605AC748C495407E36DF7D9@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38121 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725Ab2BUJ6v convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 04:58:51 -0500
Received: by qadc10 with SMTP id c10so4128832qad.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2012 01:58:50 -0800 (PST)
In-Reply-To: <81C477727102DA4E9B2605AC748C495407E36DF7D9@exch10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Feb 21, 2012 at 9:57 AM, Paul Pettigrew
<Paul.Pettigrew@mach.com.au> wrote:
> I was able to workaround this by using the slower build command (ie n=
ot adding the "-j16" option):
> =C2=A0dpkg-buildpackage

=46WIW, I just built 0.42 on squeeze amd64, with "dpkg-buildpackage -j4=
"
on a 2-core virtual machine, and that build completed just fine.

Cheers,
=46lorian

--=20
Need help with High Availability?
http://www.hastexo.com/now
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
