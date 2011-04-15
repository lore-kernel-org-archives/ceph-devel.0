From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: can anyone give me some advice
Date: Fri, 15 Apr 2011 10:45:23 -0700
Message-ID: <BANLkTimL7bH0ddZbvEY0h9HAXo3aT5d+7Q@mail.gmail.com>
References: <BANLkTi=DW6Go2gOqiJsDLJa8ObiuSHQMjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47881 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755716Ab1DORpZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 13:45:25 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8BE12C068
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 10:45:25 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 39719C062
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 10:45:25 -0700 (PDT)
Received: by eyx24 with SMTP id 24so821766eyx.19
        for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2011 10:45:23 -0700 (PDT)
In-Reply-To: <BANLkTi=DW6Go2gOqiJsDLJa8ObiuSHQMjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Qian Wei <hzqianwei@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Apr 14, 2011 at 8:47 PM, Qian Wei <hzqianwei@gmail.com> wrote:
> Hello everyonel:
> =A0 =A0 =A0 =A0Recently, I have put up a simple test platform. Now I =
want to test
> the MDS cluster's performance,but I don't how to get it. Can anyone
> give me some advices or some tools may help me get it.

Any kind of metadata-heavy workload will do it -- creating/destroying
inodes, updating metadata on files, etc.
If there's a specific kind of workload you want to test, you should
probably test that workload!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
