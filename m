From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Very slow recovery/peering with latest master
Date: Thu, 24 Sep 2015 11:27:41 -0700
Message-ID: <CAJ4mKGZqOyc=JF_j2VC33-CyV1d8KFT1dmaeTxhFSkKJmO8hoA@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE48251@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAJ4mKGa1vr6Zp9ZUaT8rrHDgRFJgdkO2c8LZqMQuwxwYt7TJ+A@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE536F2@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAN=+7FWL8c2EO8CU0DS_bMpEXXZS4tpWnkgvjg9p7+D3ztLQhg@mail.gmail.com>
	<2B48BC83-794A-4C76-A50D-86C9349B73BE@hpe.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CE53886@SACMBXIP01.sdcorp.global.sandisk.com>
	<33032584-0996-4506-B07E-66F1DD650A0D@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33699 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331AbbIXS1m convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 14:27:42 -0400
Received: by wiclk2 with SMTP id lk2so40529349wic.0
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 11:27:41 -0700 (PDT)
In-Reply-To: <33032584-0996-4506-B07E-66F1DD650A0D@hpe.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Handzik, Joe" <joseph.t.handzik@hpe.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Samuel Just <sjust@redhat.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "Sage Weil (sage@newdream.net)" <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 23, 2015 at 4:42 PM, Handzik, Joe <joseph.t.handzik@hpe.com=
> wrote:
> Ok. When configuring with ceph-disk, it does something nifty and actu=
ally gives the OSD the uuid of the disk's partition as its fsid. I boot=
strap off that to get an argument to pass into the function you have id=
entified as the bottleneck. I ran it by sage and we both realized there=
 would be cases where it wouldn't work...I'm sure neither of us realize=
d the failure would take three minutes though.
>
> In the short term, it makes sense to create an option to disable or s=
hort-circuit the blkid code. I would prefer that the default be left wi=
th the code enabled, but I'm open to default disabled if others think t=
his will be a widespread problem. You could also make sure your OSD fsi=
ds are set to match your disk partition uuids for now too, if that's a =
faster workaround for you (it'll get rid of the failure).

I'd leave it enabled by default =E2=80=94 ceph-disk is the standard way=
 of
setting up a Ceph cluster, and mkcephfs is definitely going bye-bye.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
