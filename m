From: Mark Korondi <korondi.mark@gmail.com>
Subject: Reimplemented `rbd cache writethrough until flush` broken?
Date: Wed, 17 Aug 2016 17:03:05 +0200
Message-ID: <CACiqYg665Zt3uPUshXcJkT-OWf=Q7yokZ1U02yQs-0OoH8wxtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37180 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbcHQPEr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Aug 2016 11:04:47 -0400
Received: by mail-wm0-f53.google.com with SMTP id i5so238214625wmg.0
        for <ceph-devel@vger.kernel.org>; Wed, 17 Aug 2016 08:03:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Jason Dillaman <dillaman@redhat.com>

Hi all,

my team struggles with enabling rbd caching with Jewel clusters. In
Hammer, we successfully use rbd caching with the `writethrough until
flush` directive set to true and we get expected IOPS numbers.
However, with the same configuration using Jewel,  IOPS drops; after
analyzing logs it seems to us that the writeback caching mechanism
never gets enabled regardless of flush request is being sent.

We found a bug entry describing an issue similar to ours:
http://tracker.ceph.com/issues/16654

As our note #3 says, we concluded that it seems that the imagecontext
user_flushed() signal is missing from the later version, therefore the
caching mechanism will never be switched to writeback.

Our questions are these:
1) is this change intentional and one needs to configure their
environment differently? If yes, how?
2) documentation states that this workaround is only needed with older
virtio kernel driver too old. With newer kernels, what would be the
possible implications of setting `rbd cache writethrough until flush`
to false? Is my understanding correct that this virtio driver version
what matters is that is *in the VM*?

Thanks,
Mark
