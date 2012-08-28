From: Tommi Virtanen <tv@inktank.com>
Subject: Re: mkcehfs: ** ERROR: error creating empty object store in
 /data/sd1: (2) No such file or directory
Date: Tue, 28 Aug 2012 14:20:39 -0400
Message-ID: <CADvuQRFm0nVgOjZhbo=YEkOoAJo5Rep4psofPfgFeVe==G=Sjw@mail.gmail.com>
References: <CAEj+kbmZs=x+8MVRwDs4PDbozFqSk+Qgd4EYEEe4HVQUYjxGLg@mail.gmail.com>
 <alpine.DEB.2.00.1208281013360.25640@cobra.newdream.net> <CAEj+kbmaQRQbWtj_+e6tw+UjE0HqxGU=aQY8DTbmxC5XUDoJLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:41735 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751236Ab2H1SVB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Aug 2012 14:21:01 -0400
Received: by lagy9 with SMTP id y9so3492109lag.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 11:20:59 -0700 (PDT)
In-Reply-To: <CAEj+kbmaQRQbWtj_+e6tw+UjE0HqxGU=aQY8DTbmxC5XUDoJLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Flavin <tim.flavin@gmail.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Tue, Aug 28, 2012 at 1:38 PM, Tim Flavin <tim.flavin@gmail.com> wrote:
> Sage:  Yes I tried that.

I wonder if the journal file exists..

        osd journal = /user1/log
