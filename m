From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: 'log dir' directive respected no longer?
Date: Thu, 25 Aug 2011 11:33:20 -0700
Message-ID: <CA+qbEUPYJv6k5Mf2B2JOvPZ5UWWuU2g6B4_Xj6NoEyOj=-mZYg@mail.gmail.com>
References: <CAN4=B2mqHxzhDLh9R_yzstsuCcaBCK78MeZZFomzCkWowUqbdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38594 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab1HYSdW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2011 14:33:22 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id DFF76C065
	for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2011 11:36:12 -0700 (PDT)
Received: from mail-fx0-f46.google.com (mail-fx0-f46.google.com [209.85.161.46])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 8C9F9C067
	for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2011 11:36:12 -0700 (PDT)
Received: by fxh19 with SMTP id 19so1967507fxh.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2011 11:33:20 -0700 (PDT)
In-Reply-To: <CAN4=B2mqHxzhDLh9R_yzstsuCcaBCK78MeZZFomzCkWowUqbdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

As Wido said, "log dir" has been removed and replaced by "log file."

Basically log_dir =3D foo was equivalent to something like log_file =3D
foo/$name.$id.log

The problem with the log_dir directive is that the behavior was
confusing if users supplied both log_dir and log_file in their
configuration files. Since log_file defaults to something like
/var/log/ceph/$name.$id.log for daemons, this tended to happen a lot.
log_file can do everything log_dir did, plus more, so we dropped the
old directive.

sincerely,
Colin


On Wed, Aug 24, 2011 at 11:16 PM, Brian Chrisman <brchrisman@gmail.com>=
 wrote:
> I've noticed the 'log dir' directive in my ceph.conf no longer tells
> logs where to go.
> Am I missing something?
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
