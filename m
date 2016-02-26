From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: vstart and Python bindings
Date: Thu, 25 Feb 2016 17:35:44 -0700
Message-ID: <20160225173544.62c8fb5e@lembas.zaitcev.lan>
References: <20160224233718.6a8c7569@lembas.zaitcev.lan>
	<CALe9h7dfBm1hvCMDZQb4TERjUMh2GhcsUyWFe16k7ZJ8fon2nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40896 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbcBZAfp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Feb 2016 19:35:45 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 84DDD3D0051
	for <ceph-devel@vger.kernel.org>; Fri, 26 Feb 2016 00:35:45 +0000 (UTC)
In-Reply-To: <CALe9h7dfBm1hvCMDZQb4TERjUMh2GhcsUyWFe16k7ZJ8fon2nQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 25 Feb 2016 11:41:46 +0000
John Spray <jspray@redhat.com> wrote:

> The cython changes broke cmake (amaredia mentioned in IRC he
> was working on a fix?) and libcephfs's python bindings (fix
> https://github.com/ceph/ceph/pull/7745).

The above seems to imply that something at least gets built and then
works, so for my general education I'm curious just how you do that.
Even if large parts, such as cephfs, are knocked out, I could be
okay with what's left, as long as I can get OSDs and monitor to run.
But I use vstart for that and it does not work (because rados.py
is not built/cythonized). Is there a simple workaround everyone
employs that I just don't see? Willem mentioned that he's tweaking
Makefile.am, which could help... if ./configure even tried to
source those in src/pybind. I'm missing something obvious here, am I?

-- Pete
