From: Gregory Farnum <greg@gregs42.com>
Subject: Re: [ceph-users] More writes on filestore than on journal ?
Date: Mon, 23 Mar 2015 07:29:05 -0700
Message-ID: <CAC6JEv9J7jEtgv3tcruXr8TN6gXFn1_iNexv8S_F772MY2vjXw@mail.gmail.com>
References: <1427116891.16770.25.camel@daevel.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34025 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbCWO3H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 10:29:07 -0400
Received: by iedfl3 with SMTP id fl3so42446130ied.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Mar 2015 07:29:06 -0700 (PDT)
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com. [209.85.223.174])
        by mx.google.com with ESMTPSA id j87sm699469iod.21.2015.03.23.07.29.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2015 07:29:06 -0700 (PDT)
Received: by ieclw3 with SMTP id lw3so36802960iec.2
        for <ceph-devel@vger.kernel.org>; Mon, 23 Mar 2015 07:29:05 -0700 (PDT)
In-Reply-To: <1427116891.16770.25.camel@daevel.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: ceph-users <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Mar 23, 2015 at 6:21 AM, Olivier Bonvalet <ceph.list@daevel.fr>=
 wrote:
> Hi,
>
> I'm still trying to find why there is much more write operations on
> filestore since Emperor/Firefly than from Dumpling.

Do you have any history around this? It doesn't sound familiar,
although I bet it's because of the WBThrottle and flushing changes.

>
> So, I add monitoring of all perf counters values from OSD.
>
> From what I see : =C2=ABfilestore.ops=C2=BB reports an average of 78 =
operations
> per seconds. But, block device monitoring reports an average of 113
> operations per seconds (+45%).
> please thoses 2 graphs :
> - https://daevel.fr/img/firefly/osd-70.filestore-ops.png
> - https://daevel.fr/img/firefly/osd-70.sda-ops.png

That's unfortunate but perhaps not surprising =E2=80=94 any filestore o=
p can
change a backing file (which requires hitting both the file and the
inode: potentially two disk seeks), as well as adding entries to the
leveldb instance.
-Greg

>
> Do you see what can explain this difference ? (this OSD use XFS)
>
> Thanks,
> Olivier
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
