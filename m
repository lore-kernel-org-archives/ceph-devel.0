From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [ceph-users] Permanent MDS restarting under load
Date: Wed, 11 Nov 2015 09:38:27 +0200
Message-ID: <35a8606d289ec9d757574832592b094f@natalenko.name>
References: <0bde8c53b6e2bbdffbe5f470e6d08076@natalenko.name>
 <CAJ4mKGYODLhtU6MfKCbWJsPYxKC2qcf0NJ9MBDd4XHYjF6_RWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vulcan.natalenko.name ([104.207.131.136]:29253 "EHLO
	vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbbKKHic (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Nov 2015 02:38:32 -0500
In-Reply-To: <CAJ4mKGYODLhtU6MfKCbWJsPYxKC2qcf0NJ9MBDd4XHYjF6_RWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>


10.11.2015 22:38, Gregory Farnum wrote:

> Which requests are they? Are these MDS operations or OSD ones?

Those requests appeared in ceph -w output and are the follows:

https://gist.github.com/5045336f6fb7d532138f

Is that correct that there are OSD operations blocked? osd.3 is one of=20
data pool HDDs, and other OSDs also appear in slow requests warning=20
besides osd.3 as well.

I guess that may be related to replica 4 setup of our cluster and only =
5=20
OSDs for each host. But we plan to add 6 more OSDs to each host after=20
data migration is finished. Could that help in spreading load?

> So that "blacklisted" means that the monitors decided the MDS was
> nonresponsive, failed over to another daemon, and blocked this one of=
f
> from the cluster.

So, one could adjust blacklist timeout, but there is no way to=20
rate-limit requests? Am I correct?

> Yeah, the MDS doesn't really do a good job back-pressuring clients
> right now when it or the OSDs aren't keeping up with the workload.
> That's something we need to work on once fsck stuff is behaving. rsyn=
c
> is also (sadly) a workload that frequently exposes these problems, bu=
t
> I'm not used to seeing the MDS daemon get stuck quite that quickly.
> How frequently is it actually getting swapped?

Quite often. MDSes are swapped once per 1 minute or so under heavy load=
:

=3D=3D=3D
=D0=BB=D0=B8=D1=81 10 10:40:47 data.la.net.ua bash[18112]: 2015-11-10 1=
0:40:47.357633=20
7f76c42e2700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:41:49 data.la.net.ua bash[18112]: 2015-11-10 1=
0:41:49.237962=20
7f1a939af700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:43:14 data.la.net.ua bash[18112]: 2015-11-10 1=
0:43:14.899375=20
7f17f6eaa700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:44:11 data.la.net.ua bash[18112]: 2015-11-10 1=
0:44:11.810116=20
7f693b64c700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:45:14 data.la.net.ua bash[18112]: 2015-11-10 1=
0:45:14.761684=20
7f7616097700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:46:35 data.la.net.ua bash[18112]: 2015-11-10 1=
0:46:35.927190=20
7fdfb7f62700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:47:41 data.la.net.ua bash[18112]: 2015-11-10 1=
0:47:41.888064=20
7fb88139b700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:49:57 data.la.net.ua bash[18112]: 2015-11-10 1=
0:49:57.542545=20
7fbb360eb700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:51:02 data.la.net.ua bash[18112]: 2015-11-10 1=
0:51:02.486907=20
7fb488fa1700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:52:03 data.la.net.ua bash[18112]: 2015-11-10 1=
0:52:03.871463=20
7f4cc0236700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:53:20 data.la.net.ua bash[18112]: 2015-11-10 1=
0:53:20.290494=20
7f9dc48d3700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:54:17 data.la.net.ua bash[18112]: 2015-11-10 1=
0:54:17.086940=20
7f45a9105700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:55:17 data.la.net.ua bash[18112]: 2015-11-10 1=
0:55:17.547123=20
7f6c48f50700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:56:32 data.la.net.ua bash[18112]: 2015-11-10 1=
0:56:32.558378=20
7f2bf0a70700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:57:34 data.la.net.ua bash[18112]: 2015-11-10 1=
0:57:34.534306=20
7fc69b42c700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:58:37 data.la.net.ua bash[18112]: 2015-11-10 1=
0:58:37.061903=20
7fea3de23700 -1 MDSIOContextBase: blacklisted!  Restarting...
=D0=BB=D0=B8=D1=81 10 10:59:52 data.la.net.ua bash[18112]: 2015-11-10 1=
0:59:52.579594=20
7fe23b468700 -1 MDSIOContextBase: blacklisted!  Restarting...
=3D=3D=3D

Any idea?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
