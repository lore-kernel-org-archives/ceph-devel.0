From: Dino Yancey <dino2gnt@gmail.com>
Subject: Re: Slow requests
Date: Mon, 17 Dec 2012 08:37:26 -0600
Message-ID: <CA+GnOzQnYaxy79JHfBJwU-iA6ZkO=mnS-J_JA=_WzxCHsbm-LQ@mail.gmail.com>
References: <50CDD3DB.7000501@mermaidconsulting.dk>
	<C4049E4484F13747B672D64B9C12C31328DADAC9@PWMAILM01.cscinfo.com>
	<alpine.DEB.2.00.1212161454110.18820@cobra.newdream.net>
	<50CE5517.3010700@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62513 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab2LQOh1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 09:37:27 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so7192571vcd.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 06:37:26 -0800 (PST)
In-Reply-To: <50CE5517.3010700@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jens,

Seems that the RPM packager likes to keep the latest and greatest
versions in http://ceph.com/rpm-testing/ but this path isn't defined
in the ceph yum repository.

Dino

On Sun, Dec 16, 2012 at 5:11 PM, Jens Kristian S=F8gaard
<jens@mermaidconsulting.dk> wrote:
> Hi Sage,
>
>
>> v0.52 is also quite old.  This was resolved in v0.55, I believe.  Wh=
ere
>> are you looking for the RPMs?  v0.55 should be there...
>
>
> The homepage said to look in:
>
>   http://ceph.com/rpms/fc17/x86_64/
>
> The newest there is 0.52-6.fc17.x86_64.
>
> I also looked at the EL6 folder, but the newest there is also 0.52-6.
>
> --
> Jens Kristian S=F8gaard, Mermaid Consulting ApS,
>
> jens@mermaidconsulting.dk,
> http://www.mermaidconsulting.com/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
______________________________
Dino Yancey
2GNT.com Admin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
