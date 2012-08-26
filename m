From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph doesn't detect journal failure while the OSD is
 running
Date: Sun, 26 Aug 2012 12:43:49 -0700
Message-ID: <F13ACA9DFF5F414BB9E2B7502BD9EC33@inktank.com>
References: <CAOLwVUkKW4FhSb4+YKrC7j+_EFAkh--mS_famV44Zd67OgB-oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52312 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab2HZTnk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Aug 2012 15:43:40 -0400
Received: by dady13 with SMTP id y13so2059648dad.19
        for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 12:43:40 -0700 (PDT)
In-Reply-To: <CAOLwVUkKW4FhSb4+YKrC7j+_EFAkh--mS_famV44Zd67OgB-oQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sunday, August 26, 2012 at 11:09 AM, S=C3=A9bastien Han wrote:
> Hi guys!
> =20
> Ceph doesn't seem to detect a journal failure. The cluster keeps
> writing data even if the journal doesn't exist anymore.
> I can find anywhere in the log or from the ceph's command output any
> information about a journal failure. Obviously if an OSD is restarted
> ceph will complain but a failure on fly won't be detected.
> =20
> It seems that Ceph just writes directly to the backend filesystem
> without complaining.
> =20
> Yes my monitoring system will tell me that the disk which contains my
> journals is down... But it's not the point here :)
> =20
> The really good point for me is that the cluster keeps running even i=
f
> the journal is gone. The bad point is obviously that the cluster keep=
s
> writing data to the backend filesystem (without O_DIRECT I guess...).
> I'll prefer a 'read only' cluster facility while the journal is down.
> Being able to retrieve the data is as crucial as writing data.
> =20
> Any reaction about that? Roadmap feature maybe?
So are you saying the filesystem that the journal was located on disapp=
eared? Or the underlying disk disappeared?
And then the OSD didn't notice?

If so, that's definitely a problem to be corrected as soon as we can=E2=
=80=A6It's more likely to make the OSD shut down than to continue servi=
ng reads, though.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
