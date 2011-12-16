From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: RBD layering needs to work across pools
Date: Fri, 16 Dec 2011 15:45:12 -0800
Message-ID: <CAF3hT9DVEAFmVnYSb9Ru7TbH6YVf7EVVar+dmSjKZ1sFdZRRWA@mail.gmail.com>
References: <CAORUGqBWQ5Sm1npyq4Jh0eoEHCmNz+Rb1jE+mOrT8KGM+A=CwA@mail.gmail.com>
	<CAORUGqAudf68yWzQhgFND1Dh1sxM2ArUitbn_s16acsS2W29wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61019 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab1LPXpN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 18:45:13 -0500
Received: by iaeh11 with SMTP id h11so5045234iae.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 15:45:13 -0800 (PST)
In-Reply-To: <CAORUGqAudf68yWzQhgFND1Dh1sxM2ArUitbn_s16acsS2W29wQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <josh.durgin@dreamhost.com>

On Fri, Dec 16, 2011 at 3:40 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Fri, Dec 16, 2011 at 14:48, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
>> To support this, we'd need to make sure the RBD layering we're
>> building is able to use base images in a separate pool. (And handle
>> the ugly case where after a misconfiguration the client can't access
>> the base image anymore...)
>>
>> Josh, can you say whether that falls in line with what's been planne=
d
>> for the layering?
>
> Nevermind, I see parent_{pool, image_id, snap_id} in
> http://tracker.newdream.net/issues/1772
>
> Just keep that in mind as a hard requirement.

We've needed it for other things too =97 one of the explicitly
enumerated ideas was being able to migrate VMs between pools that are
located primarily in different data centers/racks/whatever.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
