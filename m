From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: CephFS and the next hammer release v0.94.7
Date: Thu, 14 Apr 2016 10:43:04 -0700
Message-ID: <CAJ4mKGbOLmcbbLojsqctHbzj=KQkQwVg6bQ7XhpxACvkhi17gg@mail.gmail.com>
References: <570B8B1E.5060505@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35035 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932503AbcDNRnG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2016 13:43:06 -0400
Received: by mail-vk0-f50.google.com with SMTP id t129so118541352vkg.2
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2016 10:43:05 -0700 (PDT)
In-Reply-To: <570B8B1E.5060505@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

On Mon, Apr 11, 2016 at 4:31 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Greg,
>
> The next hammer release as found at https://github.com/ceph/ceph/tree/hammer passed most of the fs suite (http://pulpito.ovh.sepia.ceph.com:8081/teuthology-2016-04-10_17:00:02-fs-hammer---basic-openstack/) failed 2 and has 5 dead. There are no matching tests in on the sepia lab.
>
> Do you think the hammer branch is ready for QE to start their own round of testing ? Or should the above errors be investigated first ?

I'm sorry I lost track of this.

That test breakdown seems typical to me given the current state of our
suite on ovh. If one wanted to check carefully, verifying that all the
dead jobs have crashed OSDs (on ENOSPC or EIO) would verify that.

Otherwise, it's probably appropriate to start QE testing on the sepia lab.
-Greg
