From: Marcin Szukala <szukala.marcin@gmail.com>
Subject: Re: Ceph version 0.56.1, data loss on power failure
Date: Wed, 16 Jan 2013 11:50:07 +0100
Message-ID: <CA+-7kDCLhNx3QQ3OUGxrKT6VJszyPuPdgceA8C-pqYZRBqKkZQ@mail.gmail.com>
References: <CA+-7kDCRhRnijbEt2NxX2BgAqfF5fLaXoMOB7VUTCpeTgn9X9Q@mail.gmail.com>
	<CAF6-1L7otPweDqmq-MzEnO+TU5aHSZ3JKW+SaqG740Hw5q9ULA@mail.gmail.com>
	<CA+-7kDAxr7pa2MsVxsdxH5BLghDwDMs+SrKZhpAcJSjXwG=RuQ@mail.gmail.com>
	<CAPYLRzje19sAjtyRq8PX2zV0=GHpnzWdqOMk04UVUaRn2T7TOg@mail.gmail.com>
	<CA+-7kDCODuG-mWXEHv_QFdo1Guow55dd55+yPz85hKN+5rU1Gw@mail.gmail.com>
	<CAPYLRzhu1Tdj_MQnVJOQj6rFpVGDyiokx9k-ysb+jpbh_3F9wA@mail.gmail.com>
	<CA+-7kDBDWCv=dZN1Avc+BqLfxz5KKGNMHOjZvq5D7SnM6RSjvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36239 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758678Ab3APKuJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 05:50:09 -0500
Received: by mail-lb0-f181.google.com with SMTP id ge1so936772lbb.12
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 02:50:07 -0800 (PST)
In-Reply-To: <CA+-7kDBDWCv=dZN1Avc+BqLfxz5KKGNMHOjZvq5D7SnM6RSjvA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

Any ideas how can I resolve my issue? Or where the problem is?

Let me describe the issue.
Host boots up and maps RBD image with XFS filesystems
Host mounts the filesystems from the RBD image
Host starts to write data to the mounted filesystems
Host experiences power failure
Host comes up and map the RBD image
Host mounts the filesystems from the RBD image
All data from all filesystems is lost
Host is able to use the filesystems with no problems.

Filesystem is XFS, no errors on filesystem,

Kernel 3.5.0-19-generic

root@openstack-1:/etc/init# ceph -s
   health HEALTH_OK
   monmap e1: 3 mons at
{a=10.3.82.102:6789/0,b=10.3.82.103:6789/0,d=10.3.82.105:6789/0},
election epoch 10, quorum 0,1,2 a,b,d
   osdmap e132: 56 osds: 56 up, 56 in
    pgmap v87165: 13744 pgs: 13744 active+clean; 52727 MB data, 102 GB
used, 52028 GB / 52131 GB avail
   mdsmap e1: 0/0/1 up

Regards,
Marcin
