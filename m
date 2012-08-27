From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: Ceph doesn't detect journal failure while the OSD is running
Date: Mon, 27 Aug 2012 18:10:35 +0200
Message-ID: <CAOLwVUn2-YsOXB4dYTS_HO5BGJgSpfEW3rR3+v1T2qBnnDQWfg@mail.gmail.com>
References: <CAOLwVUkKW4FhSb4+YKrC7j+_EFAkh--mS_famV44Zd67OgB-oQ@mail.gmail.com>
 <F13ACA9DFF5F414BB9E2B7502BD9EC33@inktank.com> <CAOLwVUkigWf-tSLepaaTOj8dsN43gpuLsJ2h=4Lm6GLAG16g1A@mail.gmail.com>
 <alpine.DEB.2.00.1208261355520.11218@cobra.newdream.net> <CAOLwVU=r46QGy_P7Lc2HNmY4cJKfi3bpTHM_Wad_P2TaXX5WEg@mail.gmail.com>
 <Pine.LNX.4.64.1208271041090.25096@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63169 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab2H0QK5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 12:10:57 -0400
Received: by lbbgj3 with SMTP id gj3so2616518lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 09:10:55 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1208271041090.25096@Psilocybe.Update.UU.SE>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jerker Nyberg <jerker@update.uu.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ok for the lazy umount but the journal is not here anymore, maybe
still written in memory.

On Mon, Aug 27, 2012 at 10:59 AM, Jerker Nyberg <jerker@update.uu.se> w=
rote:
> On Sun, 26 Aug 2012, S=E9bastien Han wrote:
>
>> I used:
>>
>> umount -l to bypassed the warning.
>
>
> "umount -l" does a lazy unmount. The file system is not really unmoun=
ted
> until it is not busy anymore. Ceph may continue to use the open journ=
als and
> they should be visible in the file system hierarchy.
>
> Kind regards,
> Jerker Nyberg.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
