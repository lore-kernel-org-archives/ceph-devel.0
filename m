From: Tommi Virtanen <tv@inktank.com>
Subject: Re: rbd 0.48 storage support for kvm proxmox distribution available
Date: Wed, 5 Sep 2012 09:40:03 -0700
Message-ID: <CADvuQRHe-k_PRsMTFSawMhk=O8xcXB-jnVh8gqaeZ=jpSqPd4Q@mail.gmail.com>
References: <de08e94f-aa29-4ff7-b3a2-98ead9463886@mailpro> <50474704.2000800@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57534 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab2IEQkZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 12:40:25 -0400
Received: by vcbfk26 with SMTP id fk26so1094843vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 09:40:24 -0700 (PDT)
In-Reply-To: <50474704.2000800@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

On Wed, Sep 5, 2012 at 5:35 AM, Wido den Hollander <wido@widodh.nl> wrote:
> I also thought it is on the roadmap to not read /etc/ceph/ceph.conf by
> default with librbd/librados to take away these kind of issues.

Hmm. I'm not intimately familiar with librbd, but it seems it just
takes RADOS ioctx as an argument, and as far as I know (/can
experiment in 2 minutes) you definitely have a choice of whether
librados reads a config file or not..

rbd the command line tool does read a config file by default; pass
--conf=/dev/null to prevent that, then pass what ever config options
you need to set as --foo-bar=baz.
