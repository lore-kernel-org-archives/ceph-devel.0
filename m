From: Justin Erenkrantz <justin@erenkrantz.com>
Subject: Re: ceph-ci.git?
Date: Mon, 18 May 2015 07:02:34 -0700
Message-ID: <CAOGLoJMHD85HxH1cn6+JScmXqiKDbVGUHMLkQ_JcqnGntYEowg@mail.gmail.com>
References: <alpine.DEB.2.00.1505172130440.8350@cobra.newdream.net>
	<55599E24.6040208@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33268 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbbEROCf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 May 2015 10:02:35 -0400
Received: by obblk2 with SMTP id lk2so124531125obb.0
        for <ceph-devel@vger.kernel.org>; Mon, 18 May 2015 07:02:34 -0700 (PDT)
In-Reply-To: <55599E24.6040208@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, May 18, 2015 at 1:09 AM, Loic Dachary <loic@dachary.org> wrote:
> Maybe it would be better to keep http://github.com/ceph/ceph as it is and create a release repository (say https://git.ceph.com/?p=ceph-release.git) to only have the stable, master and next branches. Contributors who accidentally force push master on http://github.com/ceph/ceph would have the comfort of knowing that master on https://git.ceph.com/?p=ceph-release.git can be trusted to be a reference.

+1.  -- justin
