From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: Re: Slow ceph fs performance
Date: Thu, 04 Oct 2012 09:14:37 -0400
Message-ID: <201210041314.q94DEbF9014551@ayesha.phys.virginia.edu>
References: <CAPYLRzhBrOj0Woum9mv0k_wmDpCJ1qwqMtkgB7wp5f5Anm_tWw@mail.gmail.com>
Reply-To: bryan@Virginia.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:42282 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020Ab2JDNOi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Oct 2012 09:14:38 -0400
Received: from ayesha.phys.virginia.edu (localhost [127.0.0.1])
	by ayesha.phys.virginia.edu (8.14.4/8.14.4) with ESMTP id q94DEbF9014551
	for <ceph-devel@vger.kernel.org>; Thu, 4 Oct 2012 09:14:37 -0400
In-reply-to: Your message of "Wed, 03 Oct 2012 11:35:42 PDT."
             <CAPYLRzhBrOj0Woum9mv0k_wmDpCJ1qwqMtkgB7wp5f5Anm_tWw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Greg,

greg@inktank.com said:
> I think I'm with Mark now =97 this does indeed look like too much ran=
dom IO for
> the disks to handle. In particular, Ceph requires that each write be =
synced to
> disk before it's considered complete, which rsync definitely doesn't.=
 In the
> filesystem this is generally disguised fairly well by all the caches =
and such
> in the way, but this use case is unfriendly to that arrangement.

> However, I am particularly struck by seeing one of your OSDs at 96% d=
isk
> utilization while the others remain <50%, and I've just realized we n=
ever saw
> output from ceph -s. Can you provide that, please?=20

	Here's the ceph -s output:

   health HEALTH_OK
   monmap e1: 3 mons at {0=3D192.168.1.31:6789/0,1=3D192.168.1.32:6789/=
0,2=3D192.168.1
=2E33:6789/0}, election epoch 2, quorum 0,1,2 0,1,2
   osdmap e24: 4 osds: 4 up, 4 in
    pgmap v8363: 960 pgs: 960 active+clean; 15099 MB data, 38095 MB use=
d, 74354=20
GB / 74391 GB avail
   mdsmap e25: 1/1/1 up {0=3D2=3Dup:active}, 2 up:standby

	The OSD disk utilization seems to vary a lot during these
benchmarks.  My recollection is that each of the OSD hosts sometimes
sees near-100% utilization.

						Bryan


--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bryan Wright              |"If you take cranberries and stew them like=20
Physics Department        | applesauce, they taste much more like prune=
s
University of Virginia    | than rhubarb does."  --  Groucho=20
Charlottesville, VA  22901|		=09
(434) 924-7218            |         bryan@virginia.edu
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
