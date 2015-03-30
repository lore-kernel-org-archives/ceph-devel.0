From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Where is the systemd files?
Date: Mon, 30 Mar 2015 09:56:20 -0600
Message-ID: <55197224.8040907@redhat.com>
References: <CAANLjFoVm7a7e2Mbx-OruUCaMSYpOFpES_N_vfUP9-AbS8vcwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49369 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbbC3P4W (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Mar 2015 11:56:22 -0400
In-Reply-To: <CAANLjFoVm7a7e2Mbx-OruUCaMSYpOFpES_N_vfUP9-AbS8vcwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>, Ceph-User <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com

The systemd service unit files were imported into the tree, but they
have not been added into any upstream packaging yet. See the discussion
at https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=769593 or "git log
-- systemd". I don't think there are any upstream tickets in Redmine for
this yet.

Since Hammer is very close to being released, the service unit files
will not be available in the Hammer packages. The earliest we would ship
them would be the Infernalis release series.

I've recently added a "_with_systemd" conditional to the RPM spec
(ceph.spec.in) in master in order to support socket directory creation
using tmpfiles.d. That same "_with_systemd" logic could be extended to
ship the service unit files on the relevant RPM-based platforms and ship
SysV-init scripts on the older platforms (eg RHEL 6).

I'm not quite sure how we ought to handle that on Debian-based packages.
Is there a way to conditionalize the Debian packaging to "use systemd on
some versions of the distro, and use upstart on other versions" ?

- Ken

On 03/26/2015 11:13 PM, Robert LeBlanc wrote:
> I understand that Giant should have systemd service files, but I don't
> see them in the CentOS 7 packages.
> 
> https://github.com/ceph/ceph/tree/giant/systemd
> 
> [ulhglive-root@mon1 systemd]# rpm -qa | grep --color=always ceph
> ceph-common-0.93-0.el7.centos.x86_64
> python-cephfs-0.93-0.el7.centos.x86_64
> libcephfs1-0.93-0.el7.centos.x86_64
> ceph-0.93-0.el7.centos.x86_64
> ceph-deploy-1.5.22-0.noarch
> [ulhglive-root@mon1 systemd]# for i in $(rpm -qa | grep ceph); do rpm
> -ql $i | grep -i --color=always systemd; done
> [nothing returned]
> 
> Thanks,
> Robert LeBlanc

