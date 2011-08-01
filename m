From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: rados callbacks
Date: Mon, 1 Aug 2011 08:59:52 -0700
Message-ID: <CAF3hT9C1HqWPBOvRESB2Na7xs6ECKD_WV0XFHi5H5Fy_JfLOUw@mail.gmail.com>
References: <CAO47_-9LwTQFfzZko=8oKz+nM5OKrcfW6ch0A9ZX6hqedhieTw@mail.gmail.com>
	<CAC-hyiH8QWYNNbxb6d8CDr3dkFVHX=VwdcijJjRHLfv+pV=QEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55249 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab1HAP7x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 11:59:53 -0400
Received: by gwaa12 with SMTP id a12so1481421gwa.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Aug 2011 08:59:52 -0700 (PDT)
In-Reply-To: <CAC-hyiH8QWYNNbxb6d8CDr3dkFVHX=VwdcijJjRHLfv+pV=QEw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: chb@muc.de, ceph-devel@vger.kernel.org

On Mon, Aug 1, 2011 at 8:23 AM, Yehuda Sadeh Weinraub
<yehuda.sadeh@dreamhost.com> wrote:
> The osd first sends the ack when it receives the request

Actually it sends an ack when the request is applied in-memory to all
the up OSDs in the PG. :)
