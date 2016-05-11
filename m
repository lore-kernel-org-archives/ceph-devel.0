From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: How are you dealing with hammer -> jewel upgrades?
Date: Tue, 10 May 2016 18:09:08 -0600
Message-ID: <CALqRxCyXrfTmFvFrLOt0D2uxC_ixcXo5fmhb+OA8vRVcsHWsVg@mail.gmail.com>
References: <5731FE60.1090704@suse.cz>
	<CALqRxCxvKHSy=iGctuQq5fT=uTcEbR1jOLK5ZaRXiPovH_POjQ@mail.gmail.com>
	<573273A7.3040902@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33802 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbcEKAJK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 20:09:10 -0400
Received: by mail-vk0-f44.google.com with SMTP id m188so37345462vka.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2016 17:09:09 -0700 (PDT)
In-Reply-To: <573273A7.3040902@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 10, 2016 at 5:49 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> If someone is passing a user/group other than "ceph" to the OSD via
> --setuser/--setgroup, they will be doing the same with ceph-disk (which also
> takes --setuser/--setgroup). Alternatively they will not be using ceph-disk
> at all.

Sure, I think that makes sense.
