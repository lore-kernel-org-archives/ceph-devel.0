From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: workloads/rbd_fsx_cache_writethrough.yaml hangs on dumpling
Date: Mon, 2 Feb 2015 21:48:47 +0800
Message-ID: <CAAM7YAmrh_DeJgPY-QECbiZqO4w0R=ummQBug=5B8dyoZrkjWw@mail.gmail.com>
References: <54CF7927.7010908@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:51979 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbbBBNss convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Feb 2015 08:48:48 -0500
Received: by mail-la0-f47.google.com with SMTP id hz20so40812279lab.6
        for <ceph-devel@vger.kernel.org>; Mon, 02 Feb 2015 05:48:47 -0800 (PST)
In-Reply-To: <54CF7927.7010908@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Jason Dillaman <dillaman@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 2, 2015 at 9:18 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> http://pulpito.ceph.com/loic-2015-01-29_15:39:38-rbd-dumpling-backpor=
ts---basic-multi/730029/ hangs on dumpling and got killed after two day=
s.
>
> Although workloads/rbd_fsx_cache_writethrough.yaml  was running with =
the thrasher, it does not seem to be related to http://tracker.ceph.com=
/issues/10513 : it was running on a mira070 (16GB RAM) and plana78 (8GB=
 RAM).
>
> I don't see anything in https://github.com/ceph/ceph-qa-suite/blob/ma=
ster/tasks/rbd_fsx.py that would suggest it needs backporting a fix to =
the ceph-qa-suite branch of dumpling.
>
> I browsed the commits related to RBD that are in the dumpling-backpor=
ts branch ( see here for the list I used http://tracker.ceph.com/issues=
/10560 ). I don't see anything in the issues that need backporting to d=
umpling either.
>
> Another run of this specific test has been scheduled to check if it a=
lways happens at http://pulpito.ceph.com/loic-2015-02-02_13:58:32-rbd:t=
hrash:workloads:rbd_fsx_cache_writethrough.yaml-dumpling-backports---ba=
sic-multi/
>
> Does that ring a bell by any chance ?
>

maybe it's the same as http://tracker.ceph.com/issues/10498

>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
