From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: apache/fcgi deprecation?
Date: Mon, 8 Feb 2016 15:57:06 -0700
Message-ID: <CALqRxCxtJ5a0xB68kSNP7xr3qcJ-rEr=xP+ByqyusyuOWU2HgQ@mail.gmail.com>
References: <56B42126.7090106@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34855 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258AbcBHW5I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 17:57:08 -0500
Received: by mail-wm0-f49.google.com with SMTP id c200so37285984wme.0
        for <ceph-devel@vger.kernel.org>; Mon, 08 Feb 2016 14:57:07 -0800 (PST)
In-Reply-To: <56B42126.7090106@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sure, please do it!

I think it's just a matter of no one having time to remove it.

On Thu, Feb 4, 2016 at 9:12 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> I was just browsing the RGW documentation and noticed that parts of it are
> still apache/fcgi-oriented (with no mention of civetweb) even in master.
>
> My impression was that civetweb is now recommended for RGW deployments as it
> is faster. Is that true? And is there a plan to deprecate/drop apache/fcgi
> support, or will it remain indefinitely?
>
> Would it be a good idea to expunge apache/fcgi from the docs and point folks
> to civetweb instead?
>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
