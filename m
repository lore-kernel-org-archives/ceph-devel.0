From: Nick Bartos <nick@pistoncloud.com>
Subject: Re: Consistently reading/writing rados objects via command line
Date: Tue, 22 Jan 2013 08:38:33 -0800
Message-ID: <CAPud5_4fdrdSb9aNms1H=4HPm_YYovQQuVJgzF4APcRKWXOzqQ@mail.gmail.com>
References: <CAPud5_7tn1yEkCZSb+f7MC8_-jGFPzm+VZp6RAMBK8vaX3sArA@mail.gmail.com>
	<0CFBBA27610A4E35A8D340A46E009F40@inktank.com>
	<alpine.DEB.2.00.1301212113140.29915@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:61717 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622Ab3AVQqY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 11:46:24 -0500
Received: by mail-qc0-f181.google.com with SMTP id x40so4578127qcp.12
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 08:46:23 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301212113140.29915@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

Assuming that the clone is atomic so that the client only ever grabbed
a complete old or new version of the file, that method really seems
ideal.  How much work/time would that be?

The objects will likely average around 10-20MB, but it's possible that
in some cases they may grow to a few hundred MB.


On Mon, Jan 21, 2013 at 9:14 PM, Sage Weil <sage@inktank.com> wrote:
> With a bit of additional support in the rados tool, we could write to
> object $foo.tmp with key $foo, and then clone it into position and delete
> the .tmp.
>
> If they're really big objects, though, you may also be better off with
> radosgw, which provides striping and atomicity..
>
> sage
