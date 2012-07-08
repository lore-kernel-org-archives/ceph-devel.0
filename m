From: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Subject: Re: Ceph status for Wheezy
Date: Sun, 08 Jul 2012 22:22:52 +0000
Message-ID: <1341786172.24592.49.camel@julia>
References: <1341122210.10000.46.camel@julia>
	 <Pine.LNX.4.64.1206302303580.11497@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:39590 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab2GHWXG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Jul 2012 18:23:06 -0400
In-Reply-To: <Pine.LNX.4.64.1206302303580.11497@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

On Sat, 2012-06-30 at 23:12 -0700, Sage Weil wrote:
> Fingers crossed!
 It may go into Wheezy, but I need some information.

> Barring any last-minute catastrophies, 0.48 should be released Monday.
 It was released since then. But there are several files that I don't
know where to install. First are some headers under /usr/include/crush :
crush.h , hash.h , mapper.h and types.h .
I'm sure that librados-config and its manpage goes to librados-dev .
What about ceph-disk-activate , ceph-disk-prepare exists , boto_tool and
ceph-coverage ? They are python scripts except the latter being a shell
script.

Laszlo/GCS

