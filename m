From: Gregory Farnum <greg@inktank.com>
Subject: Re: Consistently reading/writing rados objects via command line
Date: Mon, 21 Jan 2013 17:11:12 -0800
Message-ID: <0CFBBA27610A4E35A8D340A46E009F40@inktank.com>
References: <CAPud5_7tn1yEkCZSb+f7MC8_-jGFPzm+VZp6RAMBK8vaX3sArA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:37283 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3AVBLP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jan 2013 20:11:15 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so3700613pad.3
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jan 2013 17:11:15 -0800 (PST)
In-Reply-To: <CAPud5_7tn1yEkCZSb+f7MC8_-jGFPzm+VZp6RAMBK8vaX3sArA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Monday, January 21, 2013 at 5:01 PM, Nick Bartos wrote:
> I would like to store some objects in rados, and retrieve them in a
> consistent manor. In my initial tests, if I do a 'rados -p foo put
> test /tmp/test', while it is uploading I can do a 'rados -p foo get
> test /tmp/blah' on another machine, and it will download a partially
> written file without returning an error code, so the downloader canno=
t
> tell the file is corrupt/incomplete.
> =20
> My question is, how do I read/write objects in rados via the command
> line in such a way where the downloader does not get a corrupt or
> incomplete file? It's fine if it just returns an error on the client
> and I can try again, I just need to be notified on error.
> =20
You must be writing large-ish objects? By default the rados tool will u=
pload objects 4MB at a time and you're trying to download mid-way throu=
gh the full object upload. You can add a "--block-size 20971520" to upl=
oad 20MB in a single operation, but make sure you don't exceed the "osd=
 max write size" (90MB by default).
This is all client-side stuff, though =E2=80=94 from the RADOS object s=
tore's perspective, the file is complete after each 4MB write. If you w=
ant something more sophisticated (like handling larger objects) you'll =
need to do at least some minimal tooling of your own, e.g. by setting a=
n object xattr before starting and after finishing the file change, the=
n checking for that presence when reading (and locking on reads or doin=
g a check when the read completes). You can do that with the "setxattr"=
, "rmxattr", and "getxattr" options.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
