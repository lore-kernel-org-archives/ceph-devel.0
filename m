From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: OSD doesn't start
Date: Fri, 06 Jul 2012 01:33:13 +0200
Message-ID: <1680690.nczT3S6HBC@mranderson>
References: <1563053.ttVafs9Pph@mranderson> <F1FB8F95B3FA4FF19D53AE9F060D88F5@inktank.com> <95834053.QbLuzMQ4OG@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.ki.iif.hu ([193.6.222.244]:38261 "EHLO strudel.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786Ab2GFIvy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 04:51:54 -0400
Received: from cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [193.225.14.182])
	by strudel.ki.iif.hu (Postfix) with ESMTP id 4BFE4399
	for <ceph-devel@vger.kernel.org>; Fri,  6 Jul 2012 10:51:50 +0200 (CEST)
Received: from strudel.ki.iif.hu ([IPv6:::ffff:193.6.222.244])
	by cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id l5rk6cUYk4TO for <ceph-devel@vger.kernel.org>;
	Fri,  6 Jul 2012 10:51:43 +0200 (CEST)
Received: from mranderson.localnet (adsl166.adsl.hungarnet.hu [193.6.17.166])
	by strudel.ki.iif.hu (Postfix) with ESMTPSA id 8AB8D49
	for <ceph-devel@vger.kernel.org>; Fri,  6 Jul 2012 10:51:42 +0200 (CEST)
In-Reply-To: <95834053.QbLuzMQ4OG@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2012. July 5. 16:12:42 Sz=E9kelyi Szabolcs wrote:
> On 2012. July 4. 09:34:04 Gregory Farnum wrote:
> > Hrm, it looks like the OSD data directory got a little busted someh=
ow. How
> > did you perform your upgrade? (That is, how did you kill your daemo=
ns, in
> > what order, and when did you bring them back up.)
>=20
> Since it would be hard and long to describe in text, I've collected t=
he
> relevant log entries, sorted by time at http://pastebin.com/Ev3M4DQ9 =
=2E The
> short story is that after seeing that the OSDs won't start, I tried t=
o bring
> down the whole cluster and start it up from scratch. It didn't change
> anything, so I rebooted the two machines (running all three daemons),=
 to
> see if it changes anything. It didn't and I gave up.
>=20
> My ceph config is available at http://pastebin.com/KKNjmiWM .
>=20
> Since this is my test cluster, I'm not very concerned about the data =
on it.
> But the other one, with the same config, is dying I think. ceph-fuse =
is
> eating around 75% CPU on the sole monitor ("cc") node. The monitor ab=
out
> 15%. On the other two nodes, the OSD eats around 50%, the MDS 15%, th=
e
> monitor another 10%. No Ceph filesystem activity is going on at the m=
oment.
> Blktrace reports about 1kB/s disk traffic on the partition hosting th=
e OSD
> data dir. The data seems to be accessible at the moment, but I'm afra=
id
> that my production cluster will end up in a similar situation after
> upgrade, so I don't dare to touch it.
>=20
> Do you have any suggestion what I should check?

Yes, it definitely looks like dying. Besides the above symptoms all cli=
ents'=20
ceph-fuse burn the CPU, there are unreadable files on the fs (tar block=
s on=20
them infinitely), the FUSE clients emit messages like

ceph-fuse: 2012-07-05 23:21:41.583692 7f444dfd5700  0 -- client_ip:0/11=
81=20
send_message dropped message ping v1 because of no pipe on con 0x103400=
0

every 5 seconds. I tried to backup the data on it, but it got blocked i=
n the=20
middle. Since then I'm unable to get any data out of it, not even by ki=
lling=20
ceph-fuse and remounting the fs.

--=20
cc


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
