From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Braindump: multiple clusters on the same hardware
Date: Wed, 17 Oct 2012 17:10:14 -0700
Message-ID: <CADvuQREqfhBMWtmQ95pEJrvmDeikdGq5cXujs4GJQgMYgYV_kA@mail.gmail.com>
References: <CADvuQREhkrqxm1dMo3XXFpwhtCzC7SM7cK_7+r5HnACGbCnJLw@mail.gmail.com>
 <CAM2gkg5UK3uDB7Zqsn6hzX4_aFBz0JGBTeJfo3uFb4=9b9zy6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:61506 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab2JRAKf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Oct 2012 20:10:35 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so2511475qcr.19
        for <ceph-devel@vger.kernel.org>; Wed, 17 Oct 2012 17:10:35 -0700 (PDT)
In-Reply-To: <CAM2gkg5UK3uDB7Zqsn6hzX4_aFBz0JGBTeJfo3uFb4=9b9zy6g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Wilkins <john.wilkins@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Oct 17, 2012 at 3:59 PM, John Wilkins <john.wilkins@inktank.com> wrote:
> Are there any issues related to ports or network conflicts?

Yeah, two monitors belonging to different clusters on the same host
are probably going to collide on the listening TCP port, if admin
doesn't explicitly avoid that. I don't have an easy answer, apart from
the old doctor joke of "don't do that, then". I think it comes down to
being careful with your $cluster.confs. Exactly how is a good question
for later ;)

> your notes and wrote the following for the Ceph configuration section. I'll
> need to update cluster ops with --cluster=clustername usage too.

Just about everything should take --cluster=, so you probably don't
need to repeat it much, just explain it once in the section that talks
about multiple clusters on the same hardware.

> When creating default directories or files, you should also use the cluster
> name at the appropriate places in the path. For example::
>
> sudo mkdir /var/lib/ceph/osd/openstack-0
> sudo mkdir /var/lib/ceph/mon/openstack-a

Yeah except I want people to use ceph-deploy -- which will be the
topic of the next braindump email, due to arrive tomorrow!
