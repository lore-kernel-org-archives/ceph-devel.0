From: Ryan Grant <rgrant+ceph@metascopic.com>
Subject: Re: CEPH distributed filesystem on two sites
Date: Wed, 14 Jul 2010 11:15:37 -0700
Message-ID: <AANLkTilK9ca7yhp_5oxWro_uAD045kdKZytVogNgxZ-3@mail.gmail.com>
References: <AANLkTikDlZd0AUFzJ_VCnWYYsTnHlTmilok2o4_ErFvq@mail.gmail.com>
	<AANLkTikj5e1JlAHK2lfoiVlXsnxCh0M5gAMBl6ZdxtEn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62349 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757194Ab0GNSPu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jul 2010 14:15:50 -0400
Received: by pxi14 with SMTP id 14so85868pxi.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jul 2010 11:15:45 -0700 (PDT)
In-Reply-To: <AANLkTikj5e1JlAHK2lfoiVlXsnxCh0M5gAMBl6ZdxtEn@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>, Roland Rabben <roland@jotta.no>, ceph-devel@vger.kernel.org

> On Mon, Jul 12, 2010 at 11:59 AM, Roland Rabben <roland@jotta.no> wro=
te:
>> Have there been any work to get CEPH working with two datacenters?

On Mon, Jul 12, 2010 at 12:39 PM, Gregory Farnum <gregf@hq.newdream.net=
> wrote:
> That said, as Brian discusses it will work, but expect writes to
> proceed at about the speed of your datacenter interconnect.

Roland did not specify an access pattern, but from context he may
be considering the offsite copy as a backup.

my understanding is that ceph is smart enough not to make
writes block, when there are no other open readers of files - it
returns as fast as local disk can acknowledge.

what does ceph do if it can get a couple copies made quickly
(but not the third remote copy)
and all readers are in the local datacenter?

--=20
=A0 Ryan Grant
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
