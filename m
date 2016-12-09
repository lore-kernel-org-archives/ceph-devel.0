From: Samuel Just <sjust@redhat.com>
Subject: Re: Question about OSDService
Date: Fri, 9 Dec 2016 11:20:52 -0800
Message-ID: <CAN=+7FW=UzVW1K7P3UmKs=Fo4RY_TTsSi3KXbta61A+7C8nPkg@mail.gmail.com>
References: <46828928.bf4b.158e2f77511.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33303 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbcLITUy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Dec 2016 14:20:54 -0500
Received: by mail-qk0-f178.google.com with SMTP id x190so27509491qkb.0
        for <ceph-devel@vger.kernel.org>; Fri, 09 Dec 2016 11:20:53 -0800 (PST)
In-Reply-To: <46828928.bf4b.158e2f77511.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's an admittedly clumsy way of separating self-contained bits of
state that do not require the osd_lock and can be safety accessed
without the osd_lock from the pg worker threads from the state that
does require the osd_lock.  Think of it as a set of services provided
by class OSD to PG implementations.
-Sam

On Fri, Dec 9, 2016 at 1:43 AM, xxhdx1985126 <xxhdx1985126@163.com> wrote:
>
> Hi, everyone.
>
>
> I'm a little confused about OSDService. As far as I know, class OSD can accomplish all the task that a OSD need to do, what is OSDService used for? Especially, what is the meaning of methods like OSDService::get_nextmap_reserved, OSDService::release_map, OSDService::await_reserved_maps?
>
>
> Thanks:-)
