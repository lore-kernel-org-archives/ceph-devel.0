From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: bad fsid
Date: Mon, 5 Mar 2012 14:46:58 -0800
Message-ID: <CAORUGqAMv35FhQT=Ks49qD4_xKwJaKiTM_KY-s2Dymo3bzD2gA@mail.gmail.com>
References: <4F516A75.6020500@cs.ucsc.edu> <CAORUGqCgPzhSKzOdxHsQG=o64zrhzUmLvDOd5u3Q5k-+0_Q8YQ@mail.gmail.com>
 <4F550936.8020701@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:64638 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757083Ab2CEWrS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Mar 2012 17:47:18 -0500
Received: by dadp12 with SMTP id p12so5713505dad.11
        for <ceph-devel@vger.kernel.org>; Mon, 05 Mar 2012 14:47:18 -0800 (PST)
In-Reply-To: <4F550936.8020701@genome.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@genome.wustl.edu>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 5, 2012 at 10:43, Matt Weil <mweil@genome.wustl.edu> wrote:
> I recreated the file system and got this on the client until it was
> rebooted.
>
> Is there a step I missed?
>
>> libceph: bad fsid, had 02f7ef57-25e0-475f-8948-5c562a4d370c got
>> 6089a28f-8ff4-42f5-8825-1a929f5770bd

Sounds like you had the client in continuous operation even when you
deleted the previous cephfs and created a new one -- the client
doesn't know that that happened, and was warning about an unexpected
destination.

If you destroy & recreate your whole cluster, you need to restart
clients too. Neatest way would be to have the client apps be down
during the fs recreate, otherwise you will get these log messages.
