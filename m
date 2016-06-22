From: Ruben Kerkhof <ruben@rubenkerkhof.com>
Subject: Re: udev events on a disk, at boot time
Date: Wed, 22 Jun 2016 13:33:52 +0200
Message-ID: <CAPed3OFyST0oJs0SQaxKXLRSu71YYPUTu+ZpKBmaEX2QaWri8g@mail.gmail.com>
References: <57695098.50403@dachary.org> <CAPed3OFeAJvLy+7G8YdwJ1pdi=p+tRatpPPQ=DmsvGjr-5QouA@mail.gmail.com>
 <57696DC1.3090803@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35295 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbcFVMEN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 08:04:13 -0400
Received: by mail-oi0-f53.google.com with SMTP id r2so18360951oih.2
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 05:03:35 -0700 (PDT)
In-Reply-To: <57696DC1.3090803@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> I wonder how my CentOS 7.2 setup is different. I'll try to reproduce =
the problem on CentOS 7.2 as well.
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre

Meanwhile I've tried a few different things. Rolling back Ceph to
10.2.1 didn't help. Upgrading the kernel to 4.6 from ELrepo didn't
help either.

One thing that might be different between our setups is that my root
fs is on LVM. I'll reinstall a server just to see if that matters.

Another workaround for this that works for me is running 'udevadm
trigger -c add -s block' after boot, this mounts the ceph volumes
successfully.

Kind regards,

Ruben
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
