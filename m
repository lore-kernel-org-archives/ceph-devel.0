From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: [PATCH 1/2] support for xattrs in libceph
Date: Tue, 10 May 2011 13:35:49 -0700
Message-ID: <BANLkTinXWPaBjtf95YX2q1ZUDeqK_RAYdQ@mail.gmail.com>
References: <1305056329-482-1-git-send-email-brchrisman@gmail.com>
	<1305056329-482-2-git-send-email-brchrisman@gmail.com>
	<BANLkTin=Pmsb2v5J+OPS_f5kW6ZCyN=xSQ@mail.gmail.com>
	<BANLkTinQA+rc4=UaknJopb+h3CG4diDskQ@mail.gmail.com>
	<BANLkTi=x7S1faQZMKLpRy1=bASWPRmq=1A@mail.gmail.com>
	<BANLkTikgJ-gWAeJY6_+TspgDXjD+-iDDyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41516 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab1EJUfv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 16:35:51 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2207AC066
	for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 13:35:51 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id C5EA8C064
	for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 13:35:50 -0700 (PDT)
Received: by ewy4 with SMTP id 4so1944754ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 13:35:49 -0700 (PDT)
In-Reply-To: <BANLkTikgJ-gWAeJY6_+TspgDXjD+-iDDyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Brian Chrisman <brchrisman@gmail.com>, ceph-devel@vger.kernel.org

On Tue, May 10, 2011 at 1:34 PM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> lsetxattr and friends are known linux API functions, and have
> corresponding system calls with the same name. I say let's keep them
> as is.

Heh. Should probably just ignore clueless me in that case. :)
