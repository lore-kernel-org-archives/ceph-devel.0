From: Gaudenz Steinlin <gaudenz@debian.org>
Subject: Re: [Ceph-announce] v0.80.11 Firefly released
Date: Mon, 23 Nov 2015 17:59:49 +0100
Message-ID: <87d1v0ps6y.fsf@meteor.durcheinandertal.bofh>
References: <alpine.DEB.2.00.1511191404500.3880@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vechigen.cirrax.com ([217.197.128.12]:46459 "EHLO
	mail.cirrax.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbbKWRHo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 12:07:44 -0500
In-Reply-To: <alpine.DEB.2.00.1511191404500.3880@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>, ceph-announce@ceph.com, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

Sage Weil <sage@redhat.com> writes:
>
> Getting Ceph
> ------------
>
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://download.ceph.com/tarballs/ceph-0.80.11.tar.gz

This leads to a 404 Error. The tar.bz2 file is missing as well. In
addition it would be nice to have some way to verify the downloaded
files. There are no checksum files for uploads after the hacking of
ceph.com and those that are there don't help much as they are not
signed.

download.ceph.com is available over https but this is not linked in the
release announcements. Using https would be at least a first step.

Gaudenz
