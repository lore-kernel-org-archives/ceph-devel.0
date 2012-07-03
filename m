From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: MDS spinning wild after restart on all nodes
Date: Tue, 3 Jul 2012 08:46:29 +0200
Message-ID: <201207030846.29754.a.ott@m-privacy.de>
References: <201206151143.25706.a.ott@m-privacy.de> <Pine.LNX.4.64.1206150940460.4551@cobra.newdream.net> <CAPYLRzjW5BGuq0b8prLona3c3+d+kKCQd0MbxGjYcR7c8a7TXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:34494 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932325Ab2GCGqj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 02:46:39 -0400
In-Reply-To: <CAPYLRzjW5BGuq0b8prLona3c3+d+kKCQd0MbxGjYcR7c8a7TXQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Greg!

On Monday 02 July 2012 you wrote:
> Amon,
> I've been going through my backlog of flagged emails and came across
> this one. Did you ever get that information for the bug that you were
> going to try and find?

After attaching my first results to the bug=20
http://tracker.newdream.net/issues/2596 I retried with strace, but with=
=20
strace on it, MDS worked fine. This means it is probably a race somewhe=
re.

After that I meant to try again. Unfortunately, I got flooded with work=
 and=20
have not yet found the time. I will retry with 0.48 release as soon as =
I=20
can - only three working days left before going on holidays there might=
 still=20
be a chance.

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
