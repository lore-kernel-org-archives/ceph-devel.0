From: Christian Brunner <chb@muc.de>
Subject: Re: rados callbacks
Date: Mon, 1 Aug 2011 18:53:05 +0200
Message-ID: <CAO47_--NLDXLksFdCSY_LVGw0rtThpE8fMRyRjDFkjPsDcgX3Q@mail.gmail.com>
References: <CAO47_-9LwTQFfzZko=8oKz+nM5OKrcfW6ch0A9ZX6hqedhieTw@mail.gmail.com>
	<CAC-hyiH8QWYNNbxb6d8CDr3dkFVHX=VwdcijJjRHLfv+pV=QEw@mail.gmail.com>
	<CAF3hT9C1HqWPBOvRESB2Na7xs6ECKD_WV0XFHi5H5Fy_JfLOUw@mail.gmail.com>
	<Pine.LNX.4.64.1108010907280.6290@cobra.newdream.net>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46476 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab1HAQxG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 12:53:06 -0400
Received: by vws1 with SMTP id 1so4590704vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Aug 2011 09:53:05 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1108010907280.6290@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>, ceph-devel@vger.kernel.org

2011/8/1 Sage Weil <sage@newdream.net>:
> On Mon, 1 Aug 2011, Gregory Farnum wrote:
>> On Mon, Aug 1, 2011 at 8:23 AM, Yehuda Sadeh Weinraub
>> <yehuda.sadeh@dreamhost.com> wrote:
>> > The osd first sends the ack when it receives the request
>>
>> Actually it sends an ack when the request is applied in-memory to al=
l
>> the up OSDs in the PG. :)
>
> That was the original intent, at least. =A0More precisely..
>
> =A0* ACK means the request is in the page/buffer cache on all replica=
s
> =A0* COMMIT means the request is on stable storage on all replicas
> =A0* COMMIT implies ACK.

Could we make this an option in librbd? A performance mode with a
callback on ACK and a secure mode with callback on COMMIT.

Considered that I have two independent datacenters, the performance
mode should be "quite safe".

I will try this in a few days...

Thanks,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
