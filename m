From: Sage Weil <sage@newdream.net>
Subject: Re: use UUID mount btrfs failed
Date: Wed, 12 Oct 2011 09:03:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110120901460.17393@cobra.newdream.net>
References: <CABAwU-Z=VJ4DkVANPyw6ogMyLz1CoGxAWcTGEay0QUOodL+Yiw@mail.gmail.com>
 <CAFtEh-dwema2fWTbX_EHsPuPhK56kDiMqe5xEuev86nPCtHZRA@mail.gmail.com>
 <CABAwU-bS7gZscTkDUDTzBetSZ_v1GgQtcr0rH3VTa8Xj3ETTpA@mail.gmail.com>
 <j73j32$6fs$1@dough.gmane.org> <CABAwU-YKYKORm1gfWQkPeE73SYe_R=-Sg7S3+ZZnusk2miH-Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-707065540-1318435398=:17393"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60105 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab1JLQDU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2011 12:03:20 -0400
In-Reply-To: <CABAwU-YKYKORm1gfWQkPeE73SYe_R=-Sg7S3+ZZnusk2miH-Cg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: Thomas Mueller <thomas@chaschperli.ch>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-707065540-1318435398=:17393
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 12 Oct 2011, huang jun wrote:
> 2011/10/12 Thomas Mueller <thomas@chaschperli.ch>:
> > On 12.10.2011 10:22, huang jun wrote:
> >>
> >> 2011/10/12 Damien Churchill<damoxc@gmail.com>:
> >>>
> >>> On 12 October 2011 02:22, huang jun<hjwsm1989@gmail.com> =A0wrote:
> >>>>
> >>>> I use the UUID option to mount the btrfs disk,but i can not success.
> >>>> first, the disk is /dev/sdd1
> >>>> then, i pull out the disk
> >>>> and after mintues, pushed it again,at this time, it changes to /dev/=
sde1
> >>>> at this time, if we use /etc/init.d/ceph restart, it will failed, fo=
r
> >>>> the current mount option is likely "/dev/sd** "
> >>>> but the UUID didn't change.
> >>>> why i can not mount it successfuly?

Maybe a dumb question, but I'm assuming you've done 'btrfsctl -a' or=20
'btrfs device scan'?  Do you see lines like

[  237.100670] device fsid 78a8ca36-478b-402b-9110-b2be4915d5f3 devid 1=20
transid 4107 /dev/sde1

with the UUID in question in the dmesg output?

sage


--557981400-707065540-1318435398=:17393--
