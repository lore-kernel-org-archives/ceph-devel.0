From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Running into an error with mkcephfs
Date: Fri, 20 Jul 2012 15:46:35 -0700
Message-ID: <CADvuQRH1rVvS5To2U_ah9uk4eO-OOKFx0GqbQZOxjYtthrHZQw@mail.gmail.com>
References: <5009D18D.6050506@scalableinformatics.com> <CAPYLRzh2S3xDK9Rh_kpuLCcMPpSrgC7T99UAtAJrCsh3Unjgmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62463 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab2GTWq4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 18:46:56 -0400
Received: by lbbgm6 with SMTP id gm6so5664422lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 15:46:55 -0700 (PDT)
In-Reply-To: <CAPYLRzh2S3xDK9Rh_kpuLCcMPpSrgC7T99UAtAJrCsh3Unjgmw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: landman@scalableinformatics.com, ceph-devel@vger.kernel.org

On Fri, Jul 20, 2012 at 3:04 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> If I remember mkcephfs correctly, it deliberately does not create the
> directories for each store (you'll notice that
> http://ceph.com/docs/master/start/quick-start/#deploy-the-configurati=
on
> includes creating the directory for each daemon) =E2=80=94 does /data=
/1/osd0
> exist yet?

Yeah, and there's a simple reason for that: you most likely wanted
those to be separate disks, with separate filesystems, and mkdir'ing
automatically might make you accidentally run all your OSDs on your OS
disk.

The new deployment stuff neatly sidesteps mkcephfs and makes this much
more robust, so we're not spending much time in improving mkcephfs
error reporting. The new stuff will be ready for wide use very soon.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
