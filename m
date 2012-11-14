From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: Small feature request for v0.55 release
Date: Wed, 14 Nov 2012 15:47:38 -0800
Message-ID: <CANLRBoxdcO8YLp69Lg7uhAWF+xffqPjdDGUVuOx_Wq4XV6g-1w@mail.gmail.com>
References: <CAPud5_4pT3OPeVC=e2cFwpdiYXsx96TuAfYiCDJbWJek+hw_Xg@mail.gmail.com>
	<sfid-H20121114-231457-+037.12-1@marduk.tchpc.tcd.ie>
	<alpine.DEB.2.00.1211141513040.26823@cobra.newdream.net>
	<2C7727ED-B154-4C3F-871C-58E47ED907D6@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62479 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab2KNXrj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 18:47:39 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so1086088vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 15:47:38 -0800 (PST)
In-Reply-To: <2C7727ED-B154-4C3F-871C-58E47ED907D6@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: Sage Weil <sage@inktank.com>, Nick Bartos <nick@pistoncloud.com>, ceph-devel@vger.kernel.org

On Wed, Nov 14, 2012 at 3:40 PM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
>
> On 14 Nov 2012, at 16:14, Sage Weil wrote:
>
>>
>> Appending the codename to the version string is something we did wit=
h
>> argonaut (0.48argonaut) just to make it obvious to users which stabl=
e
>> version they are on.
>>
>> How do people feel about that?  Is it worthwhile?  Useless?  Ugly?
>>
>> We can certainly skip it for 0.55 bobtail=85
>
> Just throwing in some thoughts, but how about a scheme like ${name}-s=
table-${version}.tar.bz2 and have the corresponding directory structure=
 inside and just ditch code names in the tar ball filename? It doesn't =
look as nice with out a codename, but it makes it absolutely clear to n=
ew users that it is a stable release.
>
Personally, I'd prefer standard naming of ${name}-${version}.tar.bz2.
You make it clear on your site which version is the LTS release, and
which are the developer releases.

t.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
