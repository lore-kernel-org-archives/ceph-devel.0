From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph doesn't detect journal failure while the OSD is running
Date: Mon, 27 Aug 2012 09:20:57 -0700
Message-ID: <CAPYLRzjv2+DWNeyiVM9fch9vTT7w_+XF38Cpxz1_dMH8TD2NpA@mail.gmail.com>
References: <CAOLwVUkKW4FhSb4+YKrC7j+_EFAkh--mS_famV44Zd67OgB-oQ@mail.gmail.com>
	<F13ACA9DFF5F414BB9E2B7502BD9EC33@inktank.com>
	<CAOLwVUkigWf-tSLepaaTOj8dsN43gpuLsJ2h=4Lm6GLAG16g1A@mail.gmail.com>
	<alpine.DEB.2.00.1208261355520.11218@cobra.newdream.net>
	<CAOLwVU=r46QGy_P7Lc2HNmY4cJKfi3bpTHM_Wad_P2TaXX5WEg@mail.gmail.com>
	<Pine.LNX.4.64.1208271041090.25096@Psilocybe.Update.UU.SE>
	<CAOLwVUn2-YsOXB4dYTS_HO5BGJgSpfEW3rR3+v1T2qBnnDQWfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35749 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab2H0QU7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 12:20:59 -0400
Received: by lbbgj3 with SMTP id gj3so2623837lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 09:20:57 -0700 (PDT)
In-Reply-To: <CAOLwVUn2-YsOXB4dYTS_HO5BGJgSpfEW3rR3+v1T2qBnnDQWfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Jerker Nyberg <jerker@update.uu.se>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 27, 2012 at 9:10 AM, S=E9bastien Han <han.sebastien@gmail.c=
om> wrote:
> Ok for the lazy umount but the journal is not here anymore, maybe
> still written in memory.

The lazy unmount keeps the filesystem attached to the tree until
nobody's using it anymore. What you've done here is to say "as soon as
nobody's touching this, kill it!" So the Ceph OSD keeps on using the
journal, and Linux keeps it around...and then when you shut down the
OSD, Linux removes the journal (*after* the OSD is done with it).
There is literally nothing that Ceph can do about this scenario.
-Greg

> On Mon, Aug 27, 2012 at 10:59 AM, Jerker Nyberg <jerker@update.uu.se>=
 wrote:
>> On Sun, 26 Aug 2012, S=E9bastien Han wrote:
>>
>>> I used:
>>>
>>> umount -l to bypassed the warning.
>>
>>
>> "umount -l" does a lazy unmount. The file system is not really unmou=
nted
>> until it is not busy anymore. Ceph may continue to use the open jour=
nals and
>> they should be visible in the file system hierarchy.
>>
>> Kind regards,
>> Jerker Nyberg.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
