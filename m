From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Wed, 9 Jan 2013 17:35:13 +0100
Message-ID: <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
References: <CAOLwVUk-pf22gXFD+8A8FGgtE4mWfz3r8minKQ6vP6q_ftYRdQ@mail.gmail.com>
 <8366806.170.1357747859058.JavaMail.dspano@it1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:49079 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab3AIQfe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 11:35:34 -0500
Received: by mail-lb0-f179.google.com with SMTP id gm13so1178568lbb.24
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 08:35:33 -0800 (PST)
In-Reply-To: <8366806.170.1357747859058.JavaMail.dspano@it1>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Spano <dspano@optogenics.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

If you wait too long, the system will trigger OOM killer :D, I already
experienced that unfortunately...

Sam?

On Wed, Jan 9, 2013 at 5:10 PM, Dave Spano <dspano@optogenics.com> wrot=
e:
> OOM killer



--
Regards,
S=E9bastien Han.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
