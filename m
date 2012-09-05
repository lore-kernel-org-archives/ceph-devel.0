From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rbd 0.48 storage support for kvm proxmox distribution available
Date: Wed, 05 Sep 2012 09:44:38 -0700
Message-ID: <50478176.3010702@inktank.com>
References: <de08e94f-aa29-4ff7-b3a2-98ead9463886@mailpro> <50474704.2000800@widodh.nl> <CADvuQRHe-k_PRsMTFSawMhk=O8xcXB-jnVh8gqaeZ=jpSqPd4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50437 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758828Ab2IEQol (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 12:44:41 -0400
Received: by pbbrr13 with SMTP id rr13so1213980pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 09:44:41 -0700 (PDT)
In-Reply-To: <CADvuQRHe-k_PRsMTFSawMhk=O8xcXB-jnVh8gqaeZ=jpSqPd4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

On 09/05/2012 09:40 AM, Tommi Virtanen wrote:
> On Wed, Sep 5, 2012 at 5:35 AM, Wido den Hollander <wido@widodh.nl> wrote:
>> I also thought it is on the roadmap to not read /etc/ceph/ceph.conf by
>> default with librbd/librados to take away these kind of issues.
>
> Hmm. I'm not intimately familiar with librbd, but it seems it just
> takes RADOS ioctx as an argument, and as far as I know (/can
> experiment in 2 minutes) you definitely have a choice of whether
> librados reads a config file or not..
>
> rbd the command line tool does read a config file by default; pass
> --conf=/dev/null to prevent that, then pass what ever config options
> you need to set as --foo-bar=baz.

That's right, all the configuration is done by calls to the
rados_conf_* functions [1] before calling rados_connect. It
looks like the libvirt storage pool doesn't call
rados_conf_read_file(cluster, NULL), so it won't read /etc/ceph/ceph.conf.

Josh

[1] http://ceph.com/docs/master/api/librados/#rados_conf_read_file
