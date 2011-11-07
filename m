From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: BUG at fs/inode.c
Date: Mon, 7 Nov 2011 16:32:14 +0100
Message-ID: <201111071632.16145.a.ott@m-privacy.de>
References: <201110241239.13157.a.ott@m-privacy.de> <201111051806.52907.a.ott@m-privacy.de> <Pine.LNX.4.64.1111052207510.22731@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:48576 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979Ab1KGPc3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 10:32:29 -0500
In-Reply-To: <Pine.LNX.4.64.1111052207510.22731@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sunday 06 November 2011 wrote Sage Weil:
> Pretty sure I've found this.  Can you test the patch below?

With this patch, the bug disappeared. Thank you, good work!

Unfortunately, I hit another bug with ceph_filldir(). Will report on th=
at one=20
soon, when I know more. Might also be my fault, need to check.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
