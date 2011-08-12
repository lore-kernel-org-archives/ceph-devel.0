From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: remove user function of radosgw
Date: Fri, 12 Aug 2011 08:33:51 -0700
Message-ID: <CAORUGqADXgzWi=bg3CcXNHsyUMpSQ7qc4CzM8k3uLkL5UWZ6_g@mail.gmail.com>
References: <CAPE_nyKvv5SG1wE0iVT0crTMpUHr6RfwWxBnhQuwKN-XqbGkeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:54639 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab1HLPeL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2011 11:34:11 -0400
Received: by iye16 with SMTP id 16so1747138iye.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2011 08:34:11 -0700 (PDT)
In-Reply-To: <CAPE_nyKvv5SG1wE0iVT0crTMpUHr6RfwWxBnhQuwKN-XqbGkeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Aug 12, 2011 at 08:14, Sylar Shen <kimulaaa@gmail.com> wrote:
> I am using radosgw right now.
> It worked great but there is a strange thing - I cannot remove a radosgw user.
> I've read the usage information of "radosgw_admin" and knew that it
> has "user rm" command.
> So my command was "radosgw_admin user rm --uid=test" but the test
> account wasn't deleted.
> I am wondering if my command was wrong or something.

Can you give us more info -- what did the "user rm" command output,
how did you determine that the user still exists?

I just tested this and it Works For Me(tm); requests get 403 Forbidden
as soon as I do the "user rm".
