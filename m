From: Owen Synge <osynge@suse.com>
Subject: Pentagon Orange redefined in ceph-deploy
Date: Thu, 09 Jul 2015 21:37:20 +0200
Message-ID: <559ECD70.9080700@suse.com>
References: <559E4814.8030007@suse.com> <6E87029C-274C-4223-83AA-88CA5B0F59EC@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:37077 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbbGITiu (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 9 Jul 2015 15:38:50 -0400
In-Reply-To: <6E87029C-274C-4223-83AA-88CA5B0F59EC@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@redhat.com>
Cc: ceph-devel@vger.kernel.org

Dear all,

Their are other details to be discussed, and hopefully lead to
agreement, but lets get to issue #1. The style issues still apply to
ceph and ceph-deploy.

=46rom what you said, in my opinion the "boat anchor" in ceph-deploy is
redefined, as coupling of facade pattern, where all data is available,
to the ssh loop in a connection. This is probably the biggest single
architectural issue in ceph-deploy.

Travis Rhoden stated that the modules are imported as objects as they
are "instantiated", I should check this, this is very good news and
removes many objections to the outcome.

The discussion of point (3) is still worth continuing though in a
separate thread as it is still important enough to require discussion,
but it is of a style and good practice discussion rather than Boat
Anchor problem level.

Many other topics are unaffected.

On 07/09/2015 07:00 PM, Travis Rhoden wrote:
>> (1A) You have to close one facade to start anouther, eg in ceph-depl=
oy
>> > you have to close each connection before connecting to the next se=
rver
>> > so making it slow to use as all state has to be gathered.
> concurrency has come up before in ceph-deploy.  It has been our expli=
cit goal to make ceph-deploy as simple and *clear* as possible for user=
s, with one of the main purposes to be extremely verbose and essentiall=
y *teach* a user how to deploy a Ceph cluster.  That=E2=80=99s why it p=
rints everything it does by default, shows every remote command, and pr=
ints the output back in order.  Concurrency would muddy those waters, t=
hough we do all want things to go faster.
>=20
> It is not necessarily the facade pattern that is the limitation there=
 =E2=80=94 it is the implementation within ceph-deploy.  We simply do a=
 =E2=80=9Cfor host is hostnames=E2=80=A6=E2=80=9D loop everywhere =E2=80=
=94 it doesn=E2=80=99t matter what we are using underneath, we are doin=
g one SSH connection at a time.

Best regards

Owen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
