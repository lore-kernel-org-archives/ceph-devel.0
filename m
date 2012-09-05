From: Tommi Virtanen <tv@inktank.com>
Subject: Re: rbd 0.48 storage support for kvm proxmox distribution available
Date: Wed, 5 Sep 2012 09:43:07 -0700
Message-ID: <CADvuQRFhEFu0wYRtQJ8htfmTLtUbQNfsFzR9UqnNUxeh_WqkTQ@mail.gmail.com>
References: <de08e94f-aa29-4ff7-b3a2-98ead9463886@mailpro> <50474704.2000800@widodh.nl>
 <CADvuQRHe-k_PRsMTFSawMhk=O8xcXB-jnVh8gqaeZ=jpSqPd4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:47410 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab2IEQn2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 12:43:28 -0400
Received: by vbbff1 with SMTP id ff1so329710vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 09:43:28 -0700 (PDT)
In-Reply-To: <CADvuQRHe-k_PRsMTFSawMhk=O8xcXB-jnVh8gqaeZ=jpSqPd4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

On Wed, Sep 5, 2012 at 9:40 AM, Tommi Virtanen <tv@inktank.com> wrote:
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

So *QEmu* makes librados read a config file.

You can avoid that just like with the rbd command line tool, pass
conf=/dev/null. Quoting
git://git.kernel.org/pub/scm/virt/kvm/qemu-kvm.git block/rbd.c:

 * The "conf" option specifies a Ceph configuration file to read.  If
 * it is not specified, we will read from the default Ceph locations
 * (e.g., /etc/ceph/ceph.conf).  To avoid reading _any_ configuration
 * file, specify conf=/dev/null.
