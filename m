From: Gregory Farnum <greg@inktank.com>
Subject: Re: maintanance on osd host
Date: Thu, 28 Feb 2013 08:14:29 -0800
Message-ID: <CAPYLRzh4YFTuZ4rrewYPX3j0kg6bA2bSuyhrKtJ=3SRYHOTgdg@mail.gmail.com>
References: <512CCD19.7010509@profihost.ag>
	<alpine.DEB.2.00.1302260904440.2730@cobra.newdream.net>
	<727CEF0E-7D1E-4298-B0E4-9729CAA4E787@profihost.ag>
	<alpine.DEB.2.00.1302260922510.4819@cobra.newdream.net>
	<512D10AA.2020906@profihost.ag>
	<CAPYLRzi+Mrcyp-Nd8C-hqBWfUAvSCNOYY8PE9Po7uPfPTcS9EQ@mail.gmail.com>
	<512DB7A5.3090500@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63429 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab3B1QOa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Feb 2013 11:14:30 -0500
Received: by mail-qc0-f174.google.com with SMTP id z24so182334qcq.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Feb 2013 08:14:29 -0800 (PST)
In-Reply-To: <512DB7A5.3090500@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Feb 26, 2013 at 11:37 PM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Hi Greg,
>   Hi Sage,
>
> Am 26.02.2013 21:27, schrieb Gregory Farnum:
>> On Tue, Feb 26, 2013 at 11:44 AM, Stefan Priebe <s.priebe@profihost.=
ag> wrote:
>> "out" and "down" are quite different =97 are you sure you tried "dow=
n"
>> and not "out"? (You reference out in your first email, rather than
>> down.)
>> -Greg
>
> sorry that's it i misread down / out. Sorry. Wouldn't it make sense t=
o
> mark the osd automatically down when shutting down via the init scrip=
t?
> It doesn't seem to make sense to hope for the automatic detection whe=
n
> somebody uses the init script.

Yes, yes it would. http://tracker.ceph.com/issues/4267 :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
