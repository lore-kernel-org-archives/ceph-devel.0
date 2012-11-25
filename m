From: Gregory Farnum <greg@inktank.com>
Subject: Re: Redundancy when mount with multiple mon IP
Date: Sun, 25 Nov 2012 11:05:20 -0800
Message-ID: <2BD5E9EBA7FF44309750F6D4D4B6403C@inktank.com>
References: <CAJiejCRq2wcRVivDpXDGcQ4t5r=3ZM8-ywVh0EiuPdS+nuDqRg@mail.gmail.com>
 <alpine.DEB.2.00.1211250826370.23552@cobra.newdream.net>
 <CAJiejCT-BvsgnwB_HYp31DFqjwdaCWsWfhCSQOgrwLNfO37emA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60363 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab2KYTFW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Nov 2012 14:05:22 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4515008pad.19
        for <ceph-devel@vger.kernel.org>; Sun, 25 Nov 2012 11:05:22 -0800 (PST)
In-Reply-To: <CAJiejCT-BvsgnwB_HYp31DFqjwdaCWsWfhCSQOgrwLNfO37emA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: Sage Weil <sage@inktank.com>, "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Sunday, November 25, 2012 at 9:30 AM, Drunkard Zhang wrote:
> 2012/11/26 Sage Weil <sage@inktank.com (mailto:sage@inktank.com)>:
> > On Sun, 25 Nov 2012, Drunkard Zhang wrote:
> > > I'm using ceph-0.51. I setup 3 monitors. then mount with 3 mon IP=
 at
> > > another host with either kernel mode or fuse, neither give me
> > > redundancy.
> > > =20
> > > Here's commands I used at client (IP: 10.0.0.2) side;
> > > mount -t ceph log3,log21,squid86-log12:/ /mnt/bc
> > > ceph-fuse -m log3,log21,squid86-log12 /mnt/bc
> > > =20
> > > When mounted, read/write is OK, then add a iptables rule at log3 =
to
> > > REJECT/DROP packets from client 10.0.0.2, operation at client stu=
ck
> > > due to IO problem.
> > > =20
> > > Related stuck processes on client look like this:
> > > log1 ~ # ps auwx |g bc
> > > root 1325 0.0 0.0 120100 3536 pts/0 Sl 23:10 0:00
> > > ceph-fuse -m log3,log21,squid86-log12 /mnt/bc
> > > root 1404 0.0 0.0 16192 700 pts/0 S 23:10 0:00 ls
> > > --color=3Dauto /mnt/bc
> > =20
> > =20
> > =20
> > Can you repeat teh test with '--debug-monc 20 --debug-ms 1 --log-fi=
le /tmp/foo'
> > on the command line and attach the resulting log?
> > =20
> > Thanks!
> > sage
> =20
> =20
> Thanks for the hint, I think the problem found, I rejected the client
> at mon.log3 which also acts as mds, and it's up and active, another
> mds is up and standby. So the client cannot connect to mds server? Is
> it possible to get more than one mds up and active simultaneously, an=
d
> let client know that?

The active MDS servers partition the namespace between them =E2=80=94 c=
lients need to be able to communicate with them all. You can configure =
which MDS is active (at start-up) if you like; unfortunately the best r=
eference is still in the wiki: http://ceph.com/deprecated/Standby-repla=
y_modes
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
