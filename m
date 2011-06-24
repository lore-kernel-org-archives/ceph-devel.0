From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: ceph
Date: Fri, 24 Jun 2011 11:39:30 -0700
Message-ID: <BANLkTim_rRGZT_DFC=xfyN2Rj2dB=JeRUw@mail.gmail.com>
References: <553761202.17749.1308901258735.JavaMail.root@mail.linserv.se>
	<621874796.17751.1308901312866.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45816 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab1FXSjb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jun 2011 14:39:31 -0400
Received: by bwd5 with SMTP id 5so15000bwd.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jun 2011 11:39:30 -0700 (PDT)
In-Reply-To: <621874796.17751.1308901312866.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 24, 2011 at 12:41 AM, Martin Wilderoth
<martin.wilderoth@linserv.se> wrote:
> Hello,
>
> I get Segmentation fault when running the command ceph to check the status. I'm uning the deb packages deb http://ceph.newdream.net/debian/ sid main
>
> I have installed the testing distribution of Debian.
> The other parts seems fine. The version of ceph is 0.29.1-1
>
Do you have a backtrace for that segfault? Did you update all the
packages (including ceph-client-tools)?

Yehuda
