From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Quota function of radosgw
Date: Tue, 31 May 2011 09:17:35 -0700
Message-ID: <BANLkTim8bUttOc-RLZ2XHe7e+5mreXOaBw@mail.gmail.com>
References: <BANLkTikpoxS6ZzPJ6q9iUD9etawm24rApQ@mail.gmail.com>
	<BANLkTikaeMSQ1PVoAopSxeqB5pmELuzGow@mail.gmail.com>
	<BANLkTimMsGNtOABRXFd24YeNumLM0gQzKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58548 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756994Ab1EaQRh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2011 12:17:37 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 78308C457
	for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 09:17:37 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 2861FC243
	for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 09:17:37 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1713018eyx.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 09:17:35 -0700 (PDT)
In-Reply-To: <BANLkTimMsGNtOABRXFd24YeNumLM0gQzKw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, May 28, 2011 at 7:45 PM, Sylar Shen <kimulaaa@gmail.com> wrote:
> Hi Gregory,
> Thanks for your information very much!
> Dropbox could limit the quota value of each user.
> Does Dropbox implement the quota function by recording every size of
> file in its own database?
> Or Dropbox just controls the quota of each user by the client application?
> If Dropbox did neither of the two approaches above, how did they do?
> Sorry it may be a little stupid question but I am curious about that......:p
I really have no idea how Dropbox works; it's got no relation to Ceph
except that I use it. ;)

> By the way, the test of re-exporting NFS I did worked not bad.
> And I am wondering since Ceph can re-export NFS, then can Ceph
> re-export SAMBA that connects to windows?
We don't have a samba re-export functionality, although you can just
run samba on a Ceph mount if you like. And I think bchrisman is
working on one, but you'd have to ask him about that. :)
-Greg
