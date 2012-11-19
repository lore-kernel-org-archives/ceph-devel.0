From: Gregory Farnum <greg@inktank.com>
Subject: Re: Removed directory is back in the Ceph FS
Date: Mon, 19 Nov 2012 15:25:41 -0800
Message-ID: <CAPYLRzgi4uQHYX9W4o+_EQvrw4KyU57Siq2XtU+GgNRAFLgPRw@mail.gmail.com>
References: <CAOGW2pyKcL=vs7p2i3yDNCC1Vxoh6cx053vECVCm=Twt7H4M5A@mail.gmail.com>
	<CAOGW2pzG466Q3p-EXwx6_jxOjazPa3yxO8H6UtDDaLxVgu7rbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60201 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab2KSXZl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 18:25:41 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so7709673iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 15:25:41 -0800 (PST)
In-Reply-To: <CAOGW2pzG466Q3p-EXwx6_jxOjazPa3yxO8H6UtDDaLxVgu7rbg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Franck Marchand <fmarchand@agaetis.fr>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Nov 13, 2012 at 3:23 AM, Franck Marchand <fmarchand@agaetis.fr> wrote:
> Hi,
>
> I have a weird pb. I remove a folder using a mounted fs partition. I
> did it and it worked well.

What client are you using? How did you delete it? (rm -rf, etc?) Are
you using multiple clients or one, and did you check it on a different
client?

> I checked later to see if I had all my folders in ceph fs ... : the
> folder I removed was back and I can't remove it ! Here is the error
> message I got :
>
> rm -rf 2012-11-10/
> rm cannot remove `2012-11-10': Directory not empty
>
> This folder is empty ...
> So anybody had the same pb ? Am I doing something wrong ?

This sounds like a known but undiagnosed problem with the MDS
"rstats". The part where your client reported success is a new
wrinkle, though.
-Greg


>
> Thx
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
