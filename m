From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Document and example for libceph, librbd and librados
Date: Wed, 4 May 2011 21:33:29 -0700
Message-ID: <BANLkTikUEMB9K1WnkyLoAOM6ir2R=eOcJg@mail.gmail.com>
References: <BANLkTinSe6i7TVY7gsncqxJQ_+p_yTz13A@mail.gmail.com>
	<1304514803.4036.104.camel@wido-laptop.pcextreme.nl>
	<BANLkTi=2kquZH-+SxsPy8MEGAk0nynP5mA@mail.gmail.com>
	<1304523657.4036.110.camel@wido-laptop.pcextreme.nl>
	<BANLkTi=i6so2XwLUBceHQfakY5qaJDfpSA@mail.gmail.com>
	<Pine.LNX.4.64.1105042121150.17319@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42101 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab1EEEda convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 00:33:30 -0400
Received: by bwz15 with SMTP id 15so1526087bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 May 2011 21:33:29 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105042121150.17319@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: tsk <aixt2006@gmail.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Wed, May 4, 2011 at 9:24 PM, Sage Weil <sage@newdream.net> wrote:
>> 3. =A0 The user space process and the cosd process will run on the s=
ame
>> host. To lower the network utilization, force-feeding will be used. =
I
>> guess reading performance may be better when do this, is it right? I
>> need to confirm this. =A0How to configure the force-feeding option=FF=
=FF In
>> the libs or the CRUSH map?
>
> There is a 'preferred' field you can set via the libceph interface.
> There is also a get_local_osd() that tells you an osd on the local no=
de
> (if there is one).
>

Btw, it'd be nice to also be able to get osd or a list of osds by
subnet/netmask.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
