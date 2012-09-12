From: Tommi Virtanen <tv@inktank.com>
Subject: Re: ceph-level build system fixes & cleanup
Date: Wed, 12 Sep 2012 09:33:36 -0700
Message-ID: <CADvuQRGJQceqRE5+YC0UCM4UEn8na3yB77asS3eZ1hWCz-oYPQ@mail.gmail.com>
References: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:55705 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab2ILQd5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 12:33:57 -0400
Received: by qaas11 with SMTP id s11so2373343qaa.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Sep 2012 09:33:56 -0700 (PDT)
In-Reply-To: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Engelhardt <jengelh@inai.de>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org

On Tue, Sep 11, 2012 at 7:22 PM, Jan Engelhardt <jengelh@inai.de> wrote=
:
> per our short exchange in private, I am taking to spruce up the
> ceph build system definitions. First comes leveldb, more shall
> follow soonish.

Thanks!

> Patches #1=E2=80=932 are mandatory for continued successful operation=
,
> #3=E2=80=935 cosmetical, and #6 a proposal.
> You are free to merge, pick or give blame :)

I'd like to see a more explanatory commit message for 6/6, but a quick
skim of all of these guys looked fine.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
