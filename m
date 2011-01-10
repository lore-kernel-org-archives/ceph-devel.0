From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: Can you help me?
Date: Mon, 10 Jan 2011 10:13:09 -0800
Message-ID: <AANLkTi=YsBcvQC7BPH=keCrW+97KKTgfPMZ5OaavDcEE@mail.gmail.com>
References: <201101102244418619138@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:36413 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab1AJSNL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Jan 2011 13:13:11 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 790E2C069
	for <ceph-devel@vger.kernel.org>; Mon, 10 Jan 2011 10:13:11 -0800 (PST)
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2566AC06A
	for <ceph-devel@vger.kernel.org>; Mon, 10 Jan 2011 10:13:10 -0800 (PST)
Received: by wyb28 with SMTP id 28so19674422wyb.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Jan 2011 10:13:09 -0800 (PST)
In-Reply-To: <201101102244418619138@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Qian Wei <hzqianwei@gmail.com>
Cc: Greg Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Mon, Jan 10, 2011 at 6:44 AM, Qian Wei <hzqianwei@gmail.com> wrote:
>
> Can=A0you=A0help=A0me? I am installing the ceph(the latest version v0=
=2E23.1=A0). I finish the process of "make", and no error happens,=A0bu=
t I can't find the file "keyring.bin" in anywhere of my Ubuntu 10.10. I=
s there anything wrong may=A0cause=A0this problem like=A0 I am facing n=
ow. Thank you! Thank you very much!!!
>

Moving this to the list.

The keyring.bin isn't created by the makefile, and moreover, currently
it is not required when using the default configuration. One easy way
to create it is to start a simple test cluster from under ceph/src
like this (don't run it if you already did it and don't want to
clobber your data):

 ~/ceph/src$ ./vstart.sh -n -x

This will generate a new filesystem, with a default ceph.conf and a
newly generated keyring file. Another way to create a keyring file is
by using the cauthtool command (there are examples in the cauthtool
man page).


Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
