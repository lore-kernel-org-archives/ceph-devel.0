From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: How are you dealing with hammer -> jewel upgrades?
Date: Tue, 10 May 2016 11:13:42 -0600
Message-ID: <CALqRxCxvKHSy=iGctuQq5fT=uTcEbR1jOLK5ZaRXiPovH_POjQ@mail.gmail.com>
References: <5731FE60.1090704@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36203 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbcEJRNn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 13:13:43 -0400
Received: by mail-vk0-f49.google.com with SMTP id s184so24659621vkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2016 10:13:43 -0700 (PDT)
In-Reply-To: <5731FE60.1090704@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I was thinking about handling it in the OSD directly, particularly
since it already has the UID from --setuid.
http://tracker.ceph.com/issues/15733

I haven't done any work on this, though :)

On Tue, May 10, 2016 at 9:29 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Regarding $SUBJ, the release notes [1] provide instructions for manually
> changing the ownership of the directories in /var/lib/ceph
>
> I am exploring ways to automate the ownership change. The /var/lib/ceph/osd
> tree seems to be the most problematic because it could contain a very large
> number of files/directories.
>
> Before I try to come up with a solution for automating it (perhaps by
> hacking "ceph-disk activate", I thought I'd ask here if anyone has already
> done any thinking/work in this area.
>
> [1] https://github.com/ceph/ceph/blob/master/doc/release-notes.rst#L257-L295
>
> Thanks!
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
