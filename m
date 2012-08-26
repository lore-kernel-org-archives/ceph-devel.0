From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: Ceph doesn't detect journal failure while the OSD is running
Date: Sun, 26 Aug 2012 22:47:37 +0200
Message-ID: <CAOLwVUkigWf-tSLepaaTOj8dsN43gpuLsJ2h=4Lm6GLAG16g1A@mail.gmail.com>
References: <CAOLwVUkKW4FhSb4+YKrC7j+_EFAkh--mS_famV44Zd67OgB-oQ@mail.gmail.com>
 <F13ACA9DFF5F414BB9E2B7502BD9EC33@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58950 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752397Ab2HZUr7 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 Aug 2012 16:47:59 -0400
Received: by lagy9 with SMTP id y9so2153471lag.19
        for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 13:47:57 -0700 (PDT)
In-Reply-To: <F13ACA9DFF5F414BB9E2B7502BD9EC33@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Greg,

My first test was:

* put a journal on tmpfs
* umount the tmpfs

The second one was almost the same:

* rm -rf /journals/*

Here /journals contains every journal... (3 actually)

This action wiped off the journal and ceph didn't detect anything.

After that I created a new pool, a new image inside it, mapped it,
formated it and wrote data in it with dd. I also used rados bench to
write data.
Ceph didn't see anything, only a service ceph restart osd make them
the OSDs crashed.


On Sun, Aug 26, 2012 at 9:43 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
>
> On Sunday, August 26, 2012 at 11:09 AM, S=E9bastien Han wrote:
> > Hi guys!
> >
> > Ceph doesn't seem to detect a journal failure. The cluster keeps
> > writing data even if the journal doesn't exist anymore.
> > I can find anywhere in the log or from the ceph's command output an=
y
> > information about a journal failure. Obviously if an OSD is restart=
ed
> > ceph will complain but a failure on fly won't be detected.
> >
> > It seems that Ceph just writes directly to the backend filesystem
> > without complaining.
> >
> > Yes my monitoring system will tell me that the disk which contains =
my
> > journals is down... But it's not the point here :)
> >
> > The really good point for me is that the cluster keeps running even=
 if
> > the journal is gone. The bad point is obviously that the cluster ke=
eps
> > writing data to the backend filesystem (without O_DIRECT I guess...=
).
> > I'll prefer a 'read only' cluster facility while the journal is dow=
n.
> > Being able to retrieve the data is as crucial as writing data.
> >
> > Any reaction about that? Roadmap feature maybe?
> So are you saying the filesystem that the journal was located on disa=
ppeared? Or the underlying disk disappeared?
> And then the OSD didn't notice?
>
> If so, that's definitely a problem to be corrected as soon as we can=85=
It's more likely to make the OSD shut down than to continue serving rea=
ds, though.
> -Greg
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
