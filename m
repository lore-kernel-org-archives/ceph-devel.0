From: flisky <yinjifeng@lianjia.com>
Subject: Re: [EMG]incomplete pgs make RGW unusable
Date: Tue, 19 May 2015 16:57:29 +0800
Message-ID: <mjettq$dj6$1@ger.gmane.org>
References: <mjdupr$jtu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57035 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754631AbbESI5m (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 May 2015 04:57:42 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YudLE-0001Zl-Qo
	for ceph-devel@vger.kernel.org; Tue, 19 May 2015 10:57:37 +0200
Received: from 106.39.60.34 ([106.39.60.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 10:57:36 +0200
Received: from yinjifeng by 106.39.60.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 10:57:36 +0200
In-Reply-To: <mjdupr$jtu$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I follow the instruction from=20
http://tracker.ceph.com/issues/10411#note-4, and finally get=20
force_create_pg work.

Thanks, Brian Rak. It helps a lot.

And, it would be great if the=20
[feature](http://tracker.ceph.com/issues/10098) is implemented.

BR,

On 2015=E5=B9=B405=E6=9C=8819=E6=97=A5 08:06, flisky wrote:
> Hi core developers,
>
> Sorry, I have to raise this from user list because there is no respon=
se.
>
> I reformat the disks to increase osd journal size. During the process=
, I
> lost 9 pgs.
>
> The incomplete pgs belong to the pool .rgw.buckets, which causes slow
> requests and make RGW unusable.
> I have to restart the OSDs and RGWs time to time, to make RGW respons=
ible.
>
> The most scary things happen. I cannot recovery the incomplete pgs.
>
> [force_create_pg](http://tracker.ceph.com/issues/10098) marks it a
> feature to handle this.
>
> The [blog](https://ceph.com/community/incomplete-pgs-oh-my/) is not
> working, either.
>
> And finally I give up the recovery, and use 'rados cppool' to copy ou=
r
> huge pool, it's STUCK...
>
> I'm very frustrated, and very surprised that Ceph doesn't offer a way=
 to
> just let the lost data lost.
>
> Could anyone give any advise on this? Thanks!
>
> Sincerely,
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
