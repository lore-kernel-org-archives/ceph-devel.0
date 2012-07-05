From: Florian Haas <florian@hastexo.com>
Subject: Re: Writes to mounted Ceph FS fail silently if client has no write
 capability on data pool
Date: Thu, 5 Jul 2012 22:25:46 +0200
Message-ID: <CAPUexz_BfEOkJmcTaiPStnPA9WsFDDDwP33VcgHQ-YCe9FOE7g@mail.gmail.com>
References: <CAPUexz-2R40ZRyEhQeEuq29fzgENDkHk=O+xXF=7jiG7ZP0Xuw@mail.gmail.com>
	<CAPYLRzhay0Jr9dV5WCR_s07c58Q5aGQ0dWCkTDeL6_oWCb_tRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:38000 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab2GEUZs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 16:25:48 -0400
Received: by qaas11 with SMTP id s11so41972qaa.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 13:25:47 -0700 (PDT)
In-Reply-To: <CAPYLRzhay0Jr9dV5WCR_s07c58Q5aGQ0dWCkTDeL6_oWCb_tRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 5, 2012 at 10:01 PM, Gregory Farnum <greg@inktank.com> wrot=
e:
>> Also, going down the rabbit hole, how would this behavior change if =
I
>> used cephfs to set the default layout on some directory to use a
>> different pool?
>
> I'm not sure what you're asking here =E2=80=94 if you have access to =
the
> metadata server, you can change the pool that new files go into, and =
I
> think you can set the pool to be whatever you like (and we should
> probably harden all this, too). So you can fix it if it's a problem,
> but you can also turn it into a problem.

I am aware that I would be able to do this.

My question was more along the lines of: if the pool that data is
written to can be set on a per-file or per-directory basis, and we can
also set read and write permissions per pool, how would the filesystem
behave properly? Hide files the mounting user doesn't have read access
to? Return -EIO or -EPERM on writes to files stored in pools we can't
write to? Failing a mount if we're missing some permission on any file
or directory in the fs? All of these sound painful in one way or
another, so I'm having trouble envisioning what the "correct" behavior
would look like.

=46lorian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
