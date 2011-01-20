From: Sage Weil <sage@newdream.net>
Subject: Re: can't read the superbloack
Date: Wed, 19 Jan 2011 21:05:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101192102400.14234@cobra.newdream.net>
References: <AANLkTim8CMPTHE9nWOxoza9WZPwwJ3=ZU5T+Y6iKyXdv@mail.gmail.com>
 <AANLkTi=TWipdK19hJU-OL5EKkb-R49jxonqSCBaurPSm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1869167834-1295499913=:14234"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59136 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab1ATFFB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jan 2011 00:05:01 -0500
In-Reply-To: <AANLkTi=TWipdK19hJU-OL5EKkb-R49jxonqSCBaurPSm@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Qian Wei <hzqianwei@gmail.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1869167834-1295499913=:14234
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 19 Jan 2011, Gregory Farnum wrote:
> On Tue, Jan 18, 2011 at 6:38 PM, Qian Wei <hzqianwei@gmail.com> wrote:
> > Now the my client machine still can't mount the system, the error
> > message is "can't read the superblock ".Moreover, I can use
> > "init-ceph" command to start the system,and the =A0"cosd cmon cmds" is
> > on process table(so I think the system is running), but I can't =A0use
> > ?ceph? command to administrate the system, ?2011-01-13 13:27:05.800552
> > b5f41b70 -- :/4555 >> 192.168.178.160:0/0 pipe(0x8429c48 sd=3D3 pgs=3D0
> > cs=3D0 l=3D0).fault first fault ? is the error message.Do you know what=
's
> > wrong may cause these problems?
> Well, that "fault first fault" message is very generic so doesn't tell
> us much. However, between that and the superblock error, there's
> clearly some issue about communicating with your monitor. There are a
> few ways to debug this, but let's check out your configuration file...
> > [mon0]
> > =A0 =A0 =A0 =A0host =3D cephosd
> > =A0 =A0 =A0 =A0mon addr =3D 192.168.178.160
> I'm pretty sure that's your problem. You need to specify a port as
> well. If that doesn't resolve your issues, we can take a deeper look.

Note that the default port is 6789.. you should use that:

=09mon addr =3D 192.168.178.160:6789

sage
--557981400-1869167834-1295499913=:14234--
