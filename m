From: Tim Flavin <tim.flavin@gmail.com>
Subject: Re: mkcehfs: ** ERROR: error creating empty object store in
 /data/sd1: (2) No such file or directory
Date: Tue, 28 Aug 2012 15:52:44 -0400
Message-ID: <CAEj+kb=GuhZ+wyVoMMp8OUhiMUTSGRo3DtUjE7rwy9ZHwkFruQ@mail.gmail.com>
References: <CAEj+kbmZs=x+8MVRwDs4PDbozFqSk+Qgd4EYEEe4HVQUYjxGLg@mail.gmail.com>
	<alpine.DEB.2.00.1208281013360.25640@cobra.newdream.net>
	<CAEj+kbmaQRQbWtj_+e6tw+UjE0HqxGU=aQY8DTbmxC5XUDoJLw@mail.gmail.com>
	<CADvuQRFm0nVgOjZhbo=YEkOoAJo5Rep4psofPfgFeVe==G=Sjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:49847 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab2H1Twp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 15:52:45 -0400
Received: by vbbff1 with SMTP id ff1so6209872vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 12:52:44 -0700 (PDT)
In-Reply-To: <CADvuQRFm0nVgOjZhbo=YEkOoAJo5Rep4psofPfgFeVe==G=Sjw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Tommi:

That was it.

osd    journal = /user1/log

should have been

osd     journal = /home/user1/log

Works much better now.  The error message was a bit confusing.    I
was looking for ENOENTs related to /data/sd1 not /user1/log.  It was
there, but there were other ENOENTs after it.


Tim




On Tue, Aug 28, 2012 at 2:20 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Tue, Aug 28, 2012 at 1:38 PM, Tim Flavin <tim.flavin@gmail.com> wrote:
>> Sage:  Yes I tried that.
>
> I wonder if the journal file exists..
>
>
