From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: How to remove lost objects.
Date: Thu, 19 Jan 2012 00:48:50 +0400
Message-ID: <CAADCt4+BL6mdrQ5XyMwdNjOMQeBh-aUAxp_8ohR-AeZ4Xd8SOA@mail.gmail.com>
References: <CAADCt4KfW7JS59ev_T4L3VMvmQm+OquD-8L7NTKS9u2RjNMPKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:45089 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757640Ab2ARUtM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 15:49:12 -0500
Received: by wibhm6 with SMTP id hm6so2545047wib.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 12:49:11 -0800 (PST)
In-Reply-To: <CAADCt4KfW7JS59ev_T4L3VMvmQm+OquD-8L7NTKS9u2RjNMPKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

But still don't know what happens with ceph, so it can't
respond and hang. It is not a good behavior, because
such situation leads to unresponsible cluster in case of
temporal network failure.

2012/1/18 Andrey Stepachev <octo47@gmail.com>:
> Hi,
>
> I've test ceph against laggy network. (0ms-400ms delays).
> At some moment i got many messages like:
> 2012-01-18 16:06:49.184776 7ff134119700 -- 84.201.161.73:6801/25424
> send_message dropped message osd_op_reply(291 1000000101b.0000001e
> [write 66734080~37
> 4784] ondisk =3D 0) v1 because of no pipe on con 0x315e640
> And ceph don't respond on ls on some of subdirs (via hadoop fs -ls or
> kernel client)
> My cluster runs with no debug at that moment, so I can't find what is=
 going on.
>
> After restart ceph writes to log
> 2012-01-18 16:10:39.985509 7f217989d780 osd.1 155 pg[0.155( v 136'373
> (94'368,136'373]+backlog n=3D3 ec=3D1 les/c 150/145 146/151/58) [] r=3D=
0
> lpr=3D0 (info mismatch, log(94'368,0'0]+backlog) (log bound mismatch,
> actual=3D[8'124,94'369]) lcod 0'0 mlcod 0'0 inactive] read_log =C2=A0=
got dup
> 94'369 (last was 94'369, dropping that one)
>
> After such strange hangouts i found, that rm -rf on filesystem
> (mounted via kernel),
> fs shows, that 210Gb still in use. Looking at /data/osd.x i found man=
y
> objects inside.
> So:
> a) looks like some errors lead us to orphaned objects in rados
> b) i can't find utility, which can check that orpaned data (and clean=
up it)
>
> Question: how I can identify what objects are, and how I can clean up=
 them.
>
> --
> Andrey.



--=20
Andrey.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
