From: Christian Brunner <chb@muc.de>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sat, 30 Jul 2011 20:33:29 +0200
Message-ID: <CAO47_--C2AmHVdmGC=dep4OonLom5tdSARjQRa5jTJPXFb48vw@mail.gmail.com>
References: <4E33D101.1050504@ufm.su>
	<9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64006 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595Ab1G3Sdb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jul 2011 14:33:31 -0400
Received: by vws1 with SMTP id 1so3647682vws.19
        for <ceph-devel@vger.kernel.org>; Sat, 30 Jul 2011 11:33:29 -0700 (PDT)
In-Reply-To: <9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

2011/7/30 Theodore Tso <tytso@mit.edu>:

>
> P.S =A0Ext4 in the RHEL 6.x kernel is I believe a technology
> preview, which means it might not get full support from
> Red Hat. =A0Still, if you do see those sorts of problems with
> ext4 on a RHEL kernel, and you have a valid Red Hat
> support contract, I'd definitely encourage you to file a
> bug with the distro.

Ext4 should be a standard feature in RHEL6 and we have a support
contract. However I have to wait until monday to file a bug report,
since I can't do this by myself, but we will do this.

Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
