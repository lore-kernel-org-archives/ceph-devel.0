From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: mkfs on osd - failed in 0.47
Date: Mon, 21 May 2012 22:58:15 +0200
Message-ID: <CAMwB3Tg=wTMGZd_Og9A2-bMzfD4tSAPW4eOZWFo4_5DQ0RyR5w@mail.gmail.com>
References: <CAMwB3TgPPbPWY5814_LVvD853fnbW1gH1mQGsaUSwJMyGR0ovQ@mail.gmail.com>
	<4FBAAA6E.4000506@profihost.ag>
	<CAPYLRzicrk97U5j_7_n=WM-PJ6u0TZbzbTzcvOZRr+dZ3YLVOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43663 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758513Ab2EUU6Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 16:58:16 -0400
Received: by weyu7 with SMTP id u7so3455141wey.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 13:58:15 -0700 (PDT)
In-Reply-To: <CAPYLRzicrk97U5j_7_n=WM-PJ6u0TZbzbTzcvOZRr+dZ3YLVOA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, ceph-devel@vger.kernel.org

Yes on root. 30 minutes ago on 0.46 same operation works.

ii  ceph                             0.47-1precise
distributed storage and file system
ii  ceph-common                      0.47-1precise              common
utilities to mount and interact with a ceph filesystem
ii  ceph-fuse                        0.47-1precise
=46USE-based client for the Ceph distributed file system
ii  libcephfs1                       0.47-1precise              Ceph
distributed file system client library
ii  python-ceph                      0.47-1precise              Python
libraries for the Ceph distributed filesystem

Repo:

deb http://ceph.com/debian/ precise main


On Mon, May 21, 2012 at 10:54 PM, Gregory Farnum <greg@inktank.com> wro=
te:
> Are you actually running as root? (ie, right perms?)
> What version of Ceph are you using? If you pulled and built binaries
> off of master over the weekend, I believe it was broken for a few
> hours in a way that will manifest somewhat like this.
>
> On Mon, May 21, 2012 at 1:49 PM, Stefan Priebe <s.priebe@profihost.ag=
> wrote:
>> Am 21.05.2012 22:41, schrieb S=C5=82awomir Skowron:
>>
>>> # ceph-osd -i 0 --mkjournal --mkfs --monmap /tmp/monmap
>>> 2012-05-21 22:36:54.150374 7f65fbc0b780 -1 filestore(/vol0/data/osd=
=2E0)
>>> leveldb db created
>>> 2012-05-21 22:36:54.152699 7f65fbc0b780 -1 filestore(/vol0/data/osd=
=2E0)
>>> Extended attributes don't appear to work. Got error (2) No such fil=
e
>>> or directory. If you are using ext3 or ext4, be sure to mount the
>>> underlying file system with the 'user_xattr' option.
>>> 2012-05-21 22:36:54.152729 7f65fbc0b780 -1 OSD::mkfs: couldn't moun=
t
>>> FileStore: error -95
>>> 2012-05-21 22:36:54.152761 7f65fbc0b780 -1 =C2=A0** ERROR: error cr=
eating
>>> empty object store in /vol0/data/osd.0: (95) Operation not supporte=
d
>>
>>
>> I get the same (v0.47) while using XFS and trying to restore an osd:
>>
>> #~: ceph-osd -c /etc/ceph/ceph.conf -i 1 --mkfs --monmap /tmp/monmap
>> 2012-05-21 22:47:34.151171 7f9090a80780 -1 filestore(/srv) leveldb d=
b
>> created
>> 2012-05-21 22:47:34.539570 7f9090a80780 -1 filestore(/srv) Extended
>> attributes don't appear to work. Got error (2) No such file or direc=
tory. If
>> you are using ext3 or ext4, be sure to mount the underlying file sys=
tem with
>> the 'user_xattr' option.
>> 2012-05-21 22:47:34.539618 7f9090a80780 -1 OSD::mkfs: couldn't mount
>> FileStore: error -95
>> 2012-05-21 22:47:34.539642 7f9090a80780 -1 =C2=A0** ERROR: error cre=
ating empty
>> object store in /srv: (95) Operation not supported
>>
>> Stefan
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml



--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
