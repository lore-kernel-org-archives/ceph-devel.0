From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] libcephfs: return error when not mounted
Date: Mon, 14 May 2012 13:57:04 -0700
Message-ID: <CAPYLRzgBa8Ucoqase5jQU_a8SrW0DtaZozp2ckDT5a0=Y6FoGQ@mail.gmail.com>
References: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu>
	<CADvuQRENXm=5O+uZ8-UwGidSgbn3KvV212sPkUam9uzOyLrvMg@mail.gmail.com>
	<FC7D87FB-20FE-400E-959D-7C3FC558A89B@cs.ucsc.edu>
	<Pine.LNX.4.64.1205141034001.20330@cobra.newdream.net>
	<6DA7B347-76E2-4D6D-9ABA-42BF973F8AAC@cs.ucsc.edu>
	<CAPYLRzgn_cwk6LfYgZbC5FvBbph9z6HGh_qyveHBr3CFOocs8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56539 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400Ab2ENU5G convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 16:57:06 -0400
Received: by lbbgm6 with SMTP id gm6so3641810lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 May 2012 13:57:04 -0700 (PDT)
In-Reply-To: <CAPYLRzgn_cwk6LfYgZbC5FvBbph9z6HGh_qyveHBr3CFOocs8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Mon, May 14, 2012 at 10:49 AM, Gregory Farnum <greg@inktank.com> wro=
te:
> I haven't had the chance to go over everything thoroughly (I notice a
> few other users of EDOM that I want to check out), but those
> definitely sound better to me.
> More better review comments later today.
> -Greg

After reviewing, I do have one other note, and that's on the use of
errno. Most of Ceph avoids errno; it's only set in 19 places in the
code and a lot of those don't count. However, we seem to have run into
a need for it (readdir), and this patchset has both rewinddir and
seekdir returning under error conditions without doing any
notification. So I think both of those functions (and any I missed)
need to set errno if they bail out =97 the other possibility is
converting them to have a return code, which I'm not opposed to but is
another user-visible change.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
