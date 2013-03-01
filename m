From: John Wilkins <john.wilkins@inktank.com>
Subject: Re: maintanance on osd host
Date: Fri, 1 Mar 2013 11:40:35 -0800
Message-ID: <CAM2gkg7Eyt=-Qjys8JtvpNGzYHb9PN-yKaEmNCP+tavd1jwirg@mail.gmail.com>
References: <512CCD19.7010509@profihost.ag>
	<alpine.DEB.2.00.1302260904440.2730@cobra.newdream.net>
	<727CEF0E-7D1E-4298-B0E4-9729CAA4E787@profihost.ag>
	<alpine.DEB.2.00.1302260922510.4819@cobra.newdream.net>
	<512D10AA.2020906@profihost.ag>
	<CAPYLRzi+Mrcyp-Nd8C-hqBWfUAvSCNOYY8PE9Po7uPfPTcS9EQ@mail.gmail.com>
	<512DB7A5.3090500@profihost.ag>
	<CAPYLRzh4YFTuZ4rrewYPX3j0kg6bA2bSuyhrKtJ=3SRYHOTgdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:42830 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab3CATkg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Mar 2013 14:40:36 -0500
Received: by mail-vc0-f176.google.com with SMTP id fk10so2161413vcb.7
        for <ceph-devel@vger.kernel.org>; Fri, 01 Mar 2013 11:40:35 -0800 (PST)
In-Reply-To: <CAPYLRzh4YFTuZ4rrewYPX3j0kg6bA2bSuyhrKtJ=3SRYHOTgdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have it documented here:

http://ceph.com/docs/master/rados/operations/troubleshooting-osd/#stopp=
ing-w-out-rebalancing

Let me know if this works for you.

On Thu, Feb 28, 2013 at 8:14 AM, Gregory Farnum <greg@inktank.com> wrot=
e:
> On Tue, Feb 26, 2013 at 11:37 PM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> Hi Greg,
>>   Hi Sage,
>>
>> Am 26.02.2013 21:27, schrieb Gregory Farnum:
>>> On Tue, Feb 26, 2013 at 11:44 AM, Stefan Priebe <s.priebe@profihost=
=2Eag> wrote:
>>> "out" and "down" are quite different =E2=80=94 are you sure you tri=
ed "down"
>>> and not "out"? (You reference out in your first email, rather than
>>> down.)
>>> -Greg
>>
>> sorry that's it i misread down / out. Sorry. Wouldn't it make sense =
to
>> mark the osd automatically down when shutting down via the init scri=
pt?
>> It doesn't seem to make sense to hope for the automatic detection wh=
en
>> somebody uses the init script.
>
> Yes, yes it would. http://tracker.ceph.com/issues/4267 :)
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
John Wilkins
Senior Technical Writer
Intank
john.wilkins@inktank.com
(415) 425-9599
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
