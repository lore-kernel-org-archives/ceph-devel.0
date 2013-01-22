From: Nick Bartos <nick@pistoncloud.com>
Subject: Re: Consistently reading/writing rados objects via command line
Date: Tue, 22 Jan 2013 08:59:14 -0800
Message-ID: <CAPud5_6yb=7wL9eMJLJn5ix0DKRkG_yyVJnki0-bcZ-bFt=1pw@mail.gmail.com>
References: <CAPud5_7tn1yEkCZSb+f7MC8_-jGFPzm+VZp6RAMBK8vaX3sArA@mail.gmail.com>
	<0CFBBA27610A4E35A8D340A46E009F40@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f42.google.com ([209.85.128.42]:59851 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab3AVQ7P convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 11:59:15 -0500
Received: by mail-qe0-f42.google.com with SMTP id 9so376644qea.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 08:59:14 -0800 (PST)
In-Reply-To: <0CFBBA27610A4E35A8D340A46E009F40@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

I had thought about doing something like that, but I'm not sure how to
do it in a race-free way.  For example if I was to set 'done=3Dyes' on =
a
file, then check that before trying to download the file, the instant
I try to download the file the writer of the file could remove the
xattr and start updating the file, which seems like it would result in
the client getting a corrupted file.

On Mon, Jan 21, 2013 at 5:11 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
> You must be writing large-ish objects? By default the rados tool will=
 upload objects 4MB at a time and you're trying to download mid-way thr=
ough the full object upload. You can add a "--block-size 20971520" to u=
pload 20MB in a single operation, but make sure you don't exceed the "o=
sd max write size" (90MB by default).
> This is all client-side stuff, though =97 from the RADOS object store=
's perspective, the file is complete after each 4MB write. If you want =
something more sophisticated (like handling larger objects) you'll need=
 to do at least some minimal tooling of your own, e.g. by setting an ob=
ject xattr before starting and after finishing the file change, then ch=
ecking for that presence when reading (and locking on reads or doing a =
check when the read completes). You can do that with the "setxattr", "r=
mxattr", and "getxattr" options.
> -Greg
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
