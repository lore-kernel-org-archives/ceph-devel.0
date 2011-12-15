From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Return stale file handle (-ESTALE) like NFS instead of hanging forever?
Date: Wed, 14 Dec 2011 22:23:31 -0800
Message-ID: <CAF3hT9CHwgkuXynhdM9bmG2g6n2pFYdxxwRH3mCw7Jxcp6QfzQ@mail.gmail.com>
References: <201112081455.56365.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35418 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab1LOGXc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2011 01:23:32 -0500
Received: by iaeh11 with SMTP id h11so2315257iae.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2011 22:23:32 -0800 (PST)
In-Reply-To: <201112081455.56365.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

On Thu, Dec 8, 2011 at 5:55 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> Hi folks,
>
> if file access through Ceph kernel client cannot continue, e.g. becau=
se there
> is no mds available, it hangs forever.
>
> I would prefer if after a timeout the application would get an error =
code,
> e.g. the -ESTALE that NFS and Gluster return if something goes wrong.=
 This
> would allow for the application to handle the error instead of blocki=
ng
> forever without a chance to recover.
This is interesting to me =97 Ceph works very hard to provide POSIX
semantics and so philosophically the introduction of ESTALE returns is
not a natural thing for us.
That doesn't necessarily make it the wrong choice, but since Ceph's
systems are designed to be self-repairing the expectation is that any
outage is a temporary situation that will resolve itself pretty
quickly. And unlike NFS, which often returns ESTALE when other file
accesses might succeed, if Ceph fails on an MDS request that's pretty
much the ballgame. So returning ESTALE seems like it's a cop-out,
losing data and behaving unexpectedly without actually doing anything
to resolve the issues or giving other data a chance to get saved =97 ie=
,
it's not something we want to do automatically. I believe we already
honor interrupts so that you can do things like Ctrl-C an application
waiting for IO and cancel the operations.

Can you describe why this behavior interests you (and manual
interruption is insufficient)? I discussed with a few people the
possibility of making it an off-by-default mount option (though I'm
unclear on the technical difficulty involved; I'm not big on our
kernel stuff); presumably that would be enough for your purposes?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
