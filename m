From: Gregory Farnum <greg@inktank.com>
Subject: Re: Writes to mounted Ceph FS fail silently if client has no write
 capability on data pool
Date: Thu, 5 Jul 2012 13:32:33 -0700
Message-ID: <CAPYLRzgkhwBosxZxyJTW2A5m4pFgHkpcxpVhrrxf6KVLuhh7Yw@mail.gmail.com>
References: <CAPUexz-2R40ZRyEhQeEuq29fzgENDkHk=O+xXF=7jiG7ZP0Xuw@mail.gmail.com>
	<CAPYLRzhay0Jr9dV5WCR_s07c58Q5aGQ0dWCkTDeL6_oWCb_tRg@mail.gmail.com>
	<CAPUexz_BfEOkJmcTaiPStnPA9WsFDDDwP33VcgHQ-YCe9FOE7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42544 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab2GEUcf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 16:32:35 -0400
Received: by lbbgm6 with SMTP id gm6so13436783lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 13:32:33 -0700 (PDT)
In-Reply-To: <CAPUexz_BfEOkJmcTaiPStnPA9WsFDDDwP33VcgHQ-YCe9FOE7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 5, 2012 at 1:25 PM, Florian Haas <florian@hastexo.com> wrot=
e:
> On Thu, Jul 5, 2012 at 10:01 PM, Gregory Farnum <greg@inktank.com> wr=
ote:
>>> Also, going down the rabbit hole, how would this behavior change if=
 I
>>> used cephfs to set the default layout on some directory to use a
>>> different pool?
>>
>> I'm not sure what you're asking here =97 if you have access to the
>> metadata server, you can change the pool that new files go into, and=
 I
>> think you can set the pool to be whatever you like (and we should
>> probably harden all this, too). So you can fix it if it's a problem,
>> but you can also turn it into a problem.
>
> I am aware that I would be able to do this.
>
> My question was more along the lines of: if the pool that data is
> written to can be set on a per-file or per-directory basis, and we ca=
n
> also set read and write permissions per pool, how would the filesyste=
m
> behave properly? Hide files the mounting user doesn't have read acces=
s
> to? Return -EIO or -EPERM on writes to files stored in pools we can't
> write to? Failing a mount if we're missing some permission on any fil=
e
> or directory in the fs? All of these sound painful in one way or
> another, so I'm having trouble envisioning what the "correct" behavio=
r
> would look like.

Ah, yes. My feeling would be that we want to treat it like a local
file they aren't allowed to access =97=A0ie, return EPERM. I *think* th=
at
is what will actually happen if they try to read those files, but the
write path works a bit differently (since the writes are flushed out
asynchronously) and so we would need to introduce some smarts into the
client to check the pool permissions and proactively apply them on any
attempted access.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
