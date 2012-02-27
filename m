From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [WRN] map e### wrongly marked me down or wrong addr
Date: Mon, 27 Feb 2012 15:53:06 -0800
Message-ID: <CAF3hT9BYOSqOjJmWj7n4qRZAY-P3ae+dAPEdqjmTjUVs+ERPRg@mail.gmail.com>
References: <2230716.Iq9SpLVmvc@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54242 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab2B0XxH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2012 18:53:07 -0500
Received: by iagj37 with SMTP id j37so434702iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2012 15:53:06 -0800 (PST)
In-Reply-To: <2230716.Iq9SpLVmvc@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

2012/2/27 Sz=E9kelyi Szabolcs <szekelyi@niif.hu>:
> Hello,
>
> whenever I restart osd.0 I see a pair of messages like
>
> 2012-02-27 17:26:00.132666 mon.0 <osd_1_ip>:6789/0 106 : [INF] osd.0
> <osd_0_ip>:6801/29931 failed (by osd.1 <osd_1_ip>:6806/20125)
> 2012-02-27 17:26:21.074926 osd.0 <osd_0_ip>:6801/29931 1 : [WRN] map =
e370
> wrongly marked me down or wrong addr

To elaborate, if you look at the IP you'll see that it takes the form
ip:port/random_number. That random number is to prevent exactly the
situation you're asking about, where the new instance of a daemon gets
stuck with stuff from its previous instance.

We'll also probably want "debug osd =3D 10" to help diagnose what's
going on, if you can get us full logs of it happening... :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
