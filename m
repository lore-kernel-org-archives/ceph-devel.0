From: Takuya ASADA <syuu@dokukino.com>
Subject: Re: read/write on RADOS using external buffer
Date: Wed, 15 Sep 2010 06:03:06 +0900
Message-ID: <AANLkTi=cp6QipKogCfqNOaEoanP3K+XEeczoZe2k7JzN@mail.gmail.com>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com> <Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41222 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab0INVDc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Sep 2010 17:03:32 -0400
Received: by wwd20 with SMTP id 20so233409wwd.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Sep 2010 14:03:30 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi,

> There currently isn't a way to use a preallocated buffer for reads. =C2=
=A0The
> incoming data is read into a buffer allocated low in the stack by the
> messaging layer. =C2=A0The bufferlist& ref is really a handle for the=
 caller to
> get at the buffers; any prior contents are discarded.

I understood.
So that allocated inside SimpleMessenger::Pipe::read_message(), right?

> This is something that could be changed, but it will require an addit=
ional
> messenger callback so that the upper layers can provide the buffer to=
 read
> the data into. =C2=A0(That is what the kernel implementation does.)

Well, could you tell me where can I find that callback code?
In fs/ceph/messenger.c?
I'd like to look into it.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
