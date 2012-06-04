From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: Infiniband 40GB
Date: Mon, 4 Jun 2012 14:34:42 +0200
Message-ID: <CAMvP8PAkDdhhJnT+KBH4p2U+g+qLfp6O=MzPyEct-q4Yzw_LVA@mail.gmail.com>
References: <4FCB1C0A.4050504@profihost.ag> <4FCB5EED.30909@inktank.com>
 <4FCC5431.6070002@suse.de> <4FCCA9EF.6080701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:62120 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760460Ab2FDMfD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 08:35:03 -0400
Received: by ghrr11 with SMTP id r11so3241765ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 05:35:02 -0700 (PDT)
In-Reply-To: <4FCCA9EF.6080701@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Hannes Reinecke <hare@suse.de>, Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 4, 2012 at 2:28 PM, Mark Nelson <mark.nelson@inktank.com> w=
rote:
>
> For syncfs support, upgrade to a distro with glibc 2.13+ (ie precise)=
=2E I've
> noticed a significant improvement in our spinning disk performance go=
ing
> from oneiric and kernel 3.3 to precise and kernel 3.4. =A0I think par=
t of this
> is related to the raid drivers for the cards we have in our test boxe=
s
> though. =A0I'm actually recording blktrace and seekwatcher results fo=
r all of
> our tests to specifically look at syncs and disk seek behavior...
>

Correct me if I'am wrong. But AFAIR precise in running 3.2 kernel.
--=20
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
