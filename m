From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Need some help in setting up rbd image with kvm
Date: Tue, 14 Feb 2012 09:29:15 -0800
Message-ID: <CAF3hT9Dbi9ANUPQUcxxOqbUz0G754rOx2UfSXaKZi8o19qoWqQ@mail.gmail.com>
References: <CAHbZLqR9FxoTLmLvEMBxtsvzb_jfGDBw8pdCnH_S12FQCifVLg@mail.gmail.com>
	<CAHbZLqQXSbsW2zUeDFwvXSr-+siY35sBy5xDye+9TNUbOVHxDw@mail.gmail.com>
	<CAORUGqBnTbhR0LF4CGa3tXT31HhhobabnwSKt5peVqhUZX37rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57364 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab2BNR3Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 12:29:16 -0500
Received: by iacb35 with SMTP id b35so196907iac.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2012 09:29:15 -0800 (PST)
In-Reply-To: <CAORUGqBnTbhR0LF4CGa3tXT31HhhobabnwSKt5peVqhUZX37rA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Upendra Moturi <upendra.m@hexagrid.com>, ceph-devel@vger.kernel.org

On Tue, Feb 14, 2012 at 9:24 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Tue, Feb 14, 2012 at 04:47, Upendra Moturi <upendra.m@hexagrid.com=
> wrote:

>> Can we create a rbd device without filesystem mounted and can it be =
a
>> shared device.
>
> Yes. Yes.

Note that if you do this, it's not well-coordinated =97=A0you may do a
read and miss a write that's currently in progress from another
client. Use flush or an equivalent command if you have multiple
servers writing to the same region of an RBD mount!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
