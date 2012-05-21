From: Gregory Farnum <greg@inktank.com>
Subject: Re: mkfs on osd - failed in 0.47
Date: Mon, 21 May 2012 13:54:31 -0700
Message-ID: <CAPYLRzicrk97U5j_7_n=WM-PJ6u0TZbzbTzcvOZRr+dZ3YLVOA@mail.gmail.com>
References: <CAMwB3TgPPbPWY5814_LVvD853fnbW1gH1mQGsaUSwJMyGR0ovQ@mail.gmail.com>
	<4FBAAA6E.4000506@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41393 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758513Ab2EUUyc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 16:54:32 -0400
Received: by lbbgm6 with SMTP id gm6so3776608lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 13:54:31 -0700 (PDT)
In-Reply-To: <4FBAAA6E.4000506@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>, =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

Are you actually running as root? (ie, right perms?)
What version of Ceph are you using? If you pulled and built binaries
off of master over the weekend, I believe it was broken for a few
hours in a way that will manifest somewhat like this.

On Mon, May 21, 2012 at 1:49 PM, Stefan Priebe <s.priebe@profihost.ag> =
wrote:
> Am 21.05.2012 22:41, schrieb S=F9awomir Skowron:
>
>> # ceph-osd -i 0 --mkjournal --mkfs --monmap /tmp/monmap
>> 2012-05-21 22:36:54.150374 7f65fbc0b780 -1 filestore(/vol0/data/osd.=
0)
>> leveldb db created
>> 2012-05-21 22:36:54.152699 7f65fbc0b780 -1 filestore(/vol0/data/osd.=
0)
>> Extended attributes don't appear to work. Got error (2) No such file
>> or directory. If you are using ext3 or ext4, be sure to mount the
>> underlying file system with the 'user_xattr' option.
>> 2012-05-21 22:36:54.152729 7f65fbc0b780 -1 OSD::mkfs: couldn't mount
>> FileStore: error -95
>> 2012-05-21 22:36:54.152761 7f65fbc0b780 -1 =A0** ERROR: error creati=
ng
>> empty object store in /vol0/data/osd.0: (95) Operation not supported
>
>
> I get the same (v0.47) while using XFS and trying to restore an osd:
>
> #~: ceph-osd -c /etc/ceph/ceph.conf -i 1 --mkfs --monmap /tmp/monmap
> 2012-05-21 22:47:34.151171 7f9090a80780 -1 filestore(/srv) leveldb db
> created
> 2012-05-21 22:47:34.539570 7f9090a80780 -1 filestore(/srv) Extended
> attributes don't appear to work. Got error (2) No such file or direct=
ory. If
> you are using ext3 or ext4, be sure to mount the underlying file syst=
em with
> the 'user_xattr' option.
> 2012-05-21 22:47:34.539618 7f9090a80780 -1 OSD::mkfs: couldn't mount
> FileStore: error -95
> 2012-05-21 22:47:34.539642 7f9090a80780 -1 =A0** ERROR: error creatin=
g empty
> object store in /srv: (95) Operation not supported
>
> Stefan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
