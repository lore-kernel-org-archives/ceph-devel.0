From: Dan Jakubiec <dan.jakubiec@gmail.com>
Subject: Re: What is XFS/filesystem corruption and whose fault is it?
Date: Thu, 1 Dec 2016 10:04:32 -0600
Message-ID: <7F16E120-AF6C-4277-B10A-851783A8F9E8@gmail.com>
References: <e7d7de6a-fd30-4957-b49d-9f3f2ae10871@suse.cz>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36654 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbcLAQEf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Dec 2016 11:04:35 -0500
Received: by mail-yw0-f180.google.com with SMTP id a10so194223305ywa.3
        for <ceph-devel@vger.kernel.org>; Thu, 01 Dec 2016 08:04:35 -0800 (PST)
In-Reply-To: <e7d7de6a-fd30-4957-b49d-9f3f2ae10871@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We lost a whole cluster once due to incorrect write cache settings on =
multiple OSDs.

I think the recommendations on that page are correct, but I would also =
add that you must disable any write caching on the drive itself as well.

The XFS FAQ is the best place I've found that explains all the ins and =
outs (Q24 thru Q28):

http://xfs.org/index.php/XFS_FAQ <http://xfs.org/index.php/XFS_FAQ>

-- Dan

> On Nov 25, 2016, at 10:26, Nathan Cutler <ncutler@suse.cz> wrote:
>=20
> I've been doing some research on OSDs not starting after power =
outages, when supposedly "uncorruptible" XFS filesystems are corrupted =
and need repair. This led me to write the following brief blog post:
>=20
> =
http://smithfarm-thebrain.blogspot.cz/2016/11/what-is-xfsfilesystem-corrup=
tion-and.html
>=20
> Any comments and/or suggestions for improvement would be most welcome.
>=20
> Thanks for reading!
>=20
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

