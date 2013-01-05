From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph stability
Date: Fri, 4 Jan 2013 16:37:36 -0800
Message-ID: <CAPYLRzirzX0NROW6L-xQ9N60N7r8oxb7gTxEir22tBAX5OLhMQ@mail.gmail.com>
References: <CAD5ewrosrMWD3jxznaMhab=VTL4VzQ7savVk42KDe374VSSzbA@mail.gmail.com>
	<50D1C09E.9000504@inktank.com>
	<CAD5ewrryqXEDv_HDGK8RettDmi7LwH_eEOCNCx_1jduj61_=cA@mail.gmail.com>
	<50D3213A.2080401@inktank.com>
	<50D434FB.4020909@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:61989 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492Ab3AEAhh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 19:37:37 -0500
Received: by mail-qc0-f178.google.com with SMTP id j34so9172589qco.37
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 16:37:36 -0800 (PST)
In-Reply-To: <50D434FB.4020909@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <ao@m-privacy.de>
Cc: Mark Nelson <mark.nelson@inktank.com>, Roman Hlynovskiy <roman.hlynovskiy@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Dec 21, 2012 at 2:07 AM, Amon Ott <ao@m-privacy.de> wrote:
> Am 20.12.2012 15:31, schrieb Mark Nelson:
>> On 12/20/2012 01:08 AM, Roman Hlynovskiy wrote:
>>> Hello Mark,
>>>
>>> for multi-mds solutions do you refer to multi-active arch or 1 acti=
ve
>>> and many standby arch?
>>
>> That's a good question!  I know we don't really recommend multi-acti=
ve
>> right now for production use.  Not sure what our current recommendat=
ions
>> are for multi-standby.  As far as I know it's considered to be more
>> stable.  I'm sure Greg or Sage can chime in with a more accurate
>> assessment.
>
> We have been testing a lot with multi-standby, because a single MDS d=
oes
> not make a lot of sense in a cluster. Maybe the clue is to have only =
one
> standby, making SPOF a DPOF?

The number of standbys should not have any impact on stability =97 they
are read-only until the active MDS gets declared down, at which point
one of them becomes active. I suppose having a standby could reduce
stability if your active MDS is overloaded enough to miss check-ins
without actually going down =97 without a standby it would eventually
recover, but with a standby a transition happens. That's the only
difference, though.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
