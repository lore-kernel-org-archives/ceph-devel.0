From: Martin Mailand <martin@tuxadero.com>
Subject: Re: Strange write behavior on an osd
Date: Tue, 24 Apr 2012 19:39:22 +0200
Message-ID: <4F96E54A.6080904@tuxadero.com>
References: <4F96B971.5050806@tuxadero.com> <4F96C557.4090603@gmail.com> <4F96CF81.4030707@tuxadero.com> <4F96D56E.1080205@gmail.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:34354 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812Ab2DXRjZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Apr 2012 13:39:25 -0400
In-Reply-To: <4F96D56E.1080205@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Jo=E3o_Eduardo_Lu=EDs?= <jecluis@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

Am 24.04.2012 18:31, schrieb Jo=E3o Eduardo Lu=EDs:
> What kernel and btrfs versions are you using?

Kernel:3.4.0-rc3

btrfs-tools                     0.19+20100601-3ubuntu3

That's how I created the fs.
mkfs.btrfs -n 32k -l 32k /dev/sd{c,d,e,f}

-martin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
