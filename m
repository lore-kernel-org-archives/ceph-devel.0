From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: OSD doesn't start
Date: Sun, 08 Jul 2012 20:51:38 +0200
Message-ID: <7377491.S2NCfnprEH@mranderson>
References: <1563053.ttVafs9Pph@mranderson> <95834053.QbLuzMQ4OG@mranderson> <1680690.nczT3S6HBC@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.ki.iif.hu ([193.6.222.244]:57324 "EHLO strudel.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934Ab2GHSvr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Jul 2012 14:51:47 -0400
Received: from cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [193.225.14.182])
	by strudel.ki.iif.hu (Postfix) with ESMTP id 660433CA
	for <ceph-devel@vger.kernel.org>; Sun,  8 Jul 2012 20:51:45 +0200 (CEST)
Received: from strudel.ki.iif.hu ([IPv6:::ffff:193.6.222.244])
	by cirkusz.lvs.iif.hu (cirkusz.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id pFKxri3fVWTt for <ceph-devel@vger.kernel.org>;
	Sun,  8 Jul 2012 20:51:41 +0200 (CEST)
Received: from mranderson.localnet (adsl166.adsl.hungarnet.hu [193.6.17.166])
	by strudel.ki.iif.hu (Postfix) with ESMTPSA id 01FE83BE
	for <ceph-devel@vger.kernel.org>; Sun,  8 Jul 2012 20:51:39 +0200 (CEST)
In-Reply-To: <1680690.nczT3S6HBC@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2012. July 6. 01:33:13 Sz=E9kelyi Szabolcs wrote:
> On 2012. July 5. 16:12:42 Sz=E9kelyi Szabolcs wrote:
> > On 2012. July 4. 09:34:04 Gregory Farnum wrote:
> > > Hrm, it looks like the OSD data directory got a little busted som=
ehow.
> > > How
> > > did you perform your upgrade? (That is, how did you kill your dae=
mons,
> > > in
> > > what order, and when did you bring them back up.)
> >=20
> > Since it would be hard and long to describe in text, I've collected=
 the
> > relevant log entries, sorted by time at http://pastebin.com/Ev3M4DQ=
9 . The
> > short story is that after seeing that the OSDs won't start, I tried=
 to
> > bring down the whole cluster and start it up from scratch. It didn'=
t
> > change anything, so I rebooted the two machines (running all three
> > daemons), to see if it changes anything. It didn't and I gave up.
> >=20
> > My ceph config is available at http://pastebin.com/KKNjmiWM .
> >=20
> > Since this is my test cluster, I'm not very concerned about the dat=
a on
> > it.
> > But the other one, with the same config, is dying I think. ceph-fus=
e is
> > eating around 75% CPU on the sole monitor ("cc") node. The monitor =
about
> > 15%. On the other two nodes, the OSD eats around 50%, the MDS 15%, =
the
> > monitor another 10%. No Ceph filesystem activity is going on at the
> > moment.
> > Blktrace reports about 1kB/s disk traffic on the partition hosting =
the OSD
> > data dir. The data seems to be accessible at the moment, but I'm af=
raid
> > that my production cluster will end up in a similar situation after
> > upgrade, so I don't dare to touch it.
> >=20
> > Do you have any suggestion what I should check?
>=20
> Yes, it definitely looks like dying. Besides the above symptoms all c=
lients'
> ceph-fuse burn the CPU, there are unreadable files on the fs (tar blo=
cks on
> them infinitely), the FUSE clients emit messages like
>=20
> ceph-fuse: 2012-07-05 23:21:41.583692 7f444dfd5700  0 -- client_ip:0/=
1181
> send_message dropped message ping v1 because of no pipe on con 0x1034=
000
>=20
> every 5 seconds. I tried to backup the data on it, but it got blocked=
 in the
> middle. Since then I'm unable to get any data out of it, not even by
> killing ceph-fuse and remounting the fs.

So it looks like the recent leap second caused all my troubles... After=
 a=20
colleague applied the workaround descibed here[0], the load on the node=
s went=20
back to normal, but the cluster was still sick. For example, stopping o=
ne of=20
the monitors and looking at the output of `ceph -s`, it still showed al=
l the=20
monitors as up & running, whereas it was clear that at least one of the=
m=20
should have been marked down (there was no ceph-mon process there).

=46inally I stopped the whole cluster (BTW `ceph stop` documented here[=
1]=20
doesn't work any longer, it replies something like 'unrecognized subsys=
tem'),=20
rebooted all the nodes, and everything came up as it should have.

Cheers,
--=20
cc


[0] http://www.h-online.com/open/news/item/Leap-second-bug-in-Linux-was=
tes-
electricity-1631462.html
[1] http://ceph.com/docs/master/control/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
