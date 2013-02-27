From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: maintanance on osd host
Date: Wed, 27 Feb 2013 08:37:09 +0100
Message-ID: <512DB7A5.3090500@profihost.ag>
References: <512CCD19.7010509@profihost.ag> <alpine.DEB.2.00.1302260904440.2730@cobra.newdream.net> <727CEF0E-7D1E-4298-B0E4-9729CAA4E787@profihost.ag> <alpine.DEB.2.00.1302260922510.4819@cobra.newdream.net> <512D10AA.2020906@profihost.ag> <CAPYLRzi+Mrcyp-Nd8C-hqBWfUAvSCNOYY8PE9Po7uPfPTcS9EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:44286 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab3B0HhR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Feb 2013 02:37:17 -0500
In-Reply-To: <CAPYLRzi+Mrcyp-Nd8C-hqBWfUAvSCNOYY8PE9Po7uPfPTcS9EQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,
  Hi Sage,

Am 26.02.2013 21:27, schrieb Gregory Farnum:
> On Tue, Feb 26, 2013 at 11:44 AM, Stefan Priebe <s.priebe@profihost.a=
g> wrote:
> "out" and "down" are quite different =97 are you sure you tried "down=
"
> and not "out"? (You reference out in your first email, rather than
> down.)
> -Greg

sorry that's it i misread down / out. Sorry. Wouldn't it make sense to
mark the osd automatically down when shutting down via the init script?
It doesn't seem to make sense to hope for the automatic detection when
somebody uses the init script.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
