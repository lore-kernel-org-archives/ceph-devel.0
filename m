From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: fuse problem
Date: Thu, 19 May 2011 07:32:06 -0700
Message-ID: <BANLkTikndSSH4aUJj9qVvEfwBvSuZteuYA@mail.gmail.com>
References: <BANLkTimJGtnfQPa4LkgbfKx5HZ7drG9u5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33282 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab1ESOcH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 10:32:07 -0400
Received: by vxi39 with SMTP id 39so1942301vxi.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2011 07:32:06 -0700 (PDT)
In-Reply-To: <BANLkTimJGtnfQPa4LkgbfKx5HZ7drG9u5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, May 19, 2011 at 4:12 AM, huang jun <hjwsm1989@gmail.com> wrote:
> hi, all
> i just encountered a problem about cfuse:
> i mount cfsue successfully on /mnt by using
> =A0 "cfuse -m 192.168.0.170:6789 /mnt"
> but when i enter /mnt directory, it shows that:
> =A0 [root@localhost mnt]# ll
> =A0 ls: .: Transport endpoint is not connected

This is a FUSE failure message that generally occurs when your
userspace process (in this case cfuse) has exited (closed its
connection to the FUSE kernel driver).
does 'ceph -s' show that your ceph cluster is up and healthy?
You may want to turn on client debugging to see why cfuse is exiting:
http://ceph.newdream.net/wiki/Debugging


> my cfuse client is on centos5, it kernel version is 2.6.18
> and OSD cluster is on debian5, 2.6.35
> i don't know whether it related to SimpleMessenger,so anyone can give
> me some prompts?
>
> thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
