From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: mkfs on osd - failed in 0.47
Date: Mon, 21 May 2012 22:49:50 +0200
Message-ID: <4FBAAA6E.4000506@profihost.ag>
References: <CAMwB3TgPPbPWY5814_LVvD853fnbW1gH1mQGsaUSwJMyGR0ovQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59662 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758480Ab2EUUtx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 16:49:53 -0400
In-Reply-To: <CAMwB3TgPPbPWY5814_LVvD853fnbW1gH1mQGsaUSwJMyGR0ovQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

Am 21.05.2012 22:41, schrieb S=B3awomir Skowron:
> # ceph-osd -i 0 --mkjournal --mkfs --monmap /tmp/monmap
> 2012-05-21 22:36:54.150374 7f65fbc0b780 -1 filestore(/vol0/data/osd.0=
)
> leveldb db created
> 2012-05-21 22:36:54.152699 7f65fbc0b780 -1 filestore(/vol0/data/osd.0=
)
> Extended attributes don't appear to work. Got error (2) No such file
> or directory. If you are using ext3 or ext4, be sure to mount the
> underlying file system with the 'user_xattr' option.
> 2012-05-21 22:36:54.152729 7f65fbc0b780 -1 OSD::mkfs: couldn't mount
> FileStore: error -95
> 2012-05-21 22:36:54.152761 7f65fbc0b780 -1  ** ERROR: error creating
> empty object store in /vol0/data/osd.0: (95) Operation not supported

I get the same (v0.47) while using XFS and trying to restore an osd:

#~: ceph-osd -c /etc/ceph/ceph.conf -i 1 --mkfs --monmap /tmp/monmap
2012-05-21 22:47:34.151171 7f9090a80780 -1 filestore(/srv) leveldb db=20
created
2012-05-21 22:47:34.539570 7f9090a80780 -1 filestore(/srv) Extended=20
attributes don't appear to work. Got error (2) No such file or=20
directory. If you are using ext3 or ext4, be sure to mount the=20
underlying file system with the 'user_xattr' option.
2012-05-21 22:47:34.539618 7f9090a80780 -1 OSD::mkfs: couldn't mount=20
=46ileStore: error -95
2012-05-21 22:47:34.539642 7f9090a80780 -1  ** ERROR: error creating=20
empty object store in /srv: (95) Operation not supported

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
