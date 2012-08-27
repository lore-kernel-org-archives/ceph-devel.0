From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: Re: Ceph doesn't detect journal failure while the OSD is running
Date: Mon, 27 Aug 2012 10:59:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1208271041090.25096@Psilocybe.Update.UU.SE>
References: <CAOLwVUkKW4FhSb4+YKrC7j+_EFAkh--mS_famV44Zd67OgB-oQ@mail.gmail.com>
 <F13ACA9DFF5F414BB9E2B7502BD9EC33@inktank.com>
 <CAOLwVUkigWf-tSLepaaTOj8dsN43gpuLsJ2h=4Lm6GLAG16g1A@mail.gmail.com>
 <alpine.DEB.2.00.1208261355520.11218@cobra.newdream.net>
 <CAOLwVU=r46QGy_P7Lc2HNmY4cJKfi3bpTHM_Wad_P2TaXX5WEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-293463789-1695705278-1346057305=:25096"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:40928 "EHLO
	Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab2H0JHd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 05:07:33 -0400
In-Reply-To: <CAOLwVU=r46QGy_P7Lc2HNmY4cJKfi3bpTHM_Wad_P2TaXX5WEg@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1208271048370.25096@Psilocybe.Update.UU.SE>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---293463789-1695705278-1346057305=:25096
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.1208271048371.25096@Psilocybe.Update.UU.SE>

On Sun, 26 Aug 2012, Sébastien Han wrote:

> I used:
>
> umount -l to bypassed the warning.

"umount -l" does a lazy unmount. The file system is not really unmounted 
until it is not busy anymore. Ceph may continue to use the open journals 
and they should be visible in the file system hierarchy.

Kind regards,
Jerker Nyberg.
---293463789-1695705278-1346057305=:25096--
