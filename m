From: Tommi Virtanen <tv@inktank.com>
Subject: Re: iozone test crashed on ceph
Date: Tue, 5 Jun 2012 09:45:38 -0700
Message-ID: <CADvuQRHMxM9PxOyxmej9_MuJajGNV2=yBxL9vN7P4KEvA7US5A@mail.gmail.com>
References: <loom.20120601T025228-787@post.gmane.org> <0F43C46A9543420FBEB081A55ACD1FB0@inktank.com>
 <loom.20120604T235042-446@post.gmane.org> <CADvuQRFRsc24feZFbQYo7Rkg=ot4PF7j9VCEFDO2PJq3AGkzsw@mail.gmail.com>
 <loom.20120605T012913-573@post.gmane.org> <loom.20120605T014157-339@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34506 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278Ab2FEQp7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 12:45:59 -0400
Received: by dady13 with SMTP id y13so7530157dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 09:45:59 -0700 (PDT)
In-Reply-To: <loom.20120605T014157-339@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: udit agarwal <fzdudit@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jun 4, 2012 at 4:43 PM, udit agarwal <fzdudit@gmail.com> wrote:
> Sorry ,the link is: [...]

If you run iozone again, does the bug happen again?

Comparing your iozone run with our test suite, we don't currently do
-i 2 (random read/write), and we only run a few specific record sizes
to save time (-r 16K,1M); your run is talking about record len "4"
(K?) when it crashes. That might be relevant for triggering this.

Summarizing for others:

Jun  4 22:19:03 hp1 kernel: [ 7627.132026] BUG: unable to handle
kernel NULL pointer dereference at 000000000000000a
Jun  4 22:19:03 hp1 kernel: [ 7627.132036] IP: [<ffffffffa01a1fd3>]
ceph_update_writeable_page+0xe3/0x590 [ceph]
Jun  4 22:19:03 hp1 kernel: [ 7627.132058] PGD 795e3067 PUD 37673067 PMD 0
Jun  4 22:19:03 hp1 kernel: [ 7627.132065] Oops: 0000 [#1] PREEMPT SMP
...
Jun  4 22:19:03 hp1 kernel: [ 7627.132213] Call Trace:
Jun  4 22:19:03 hp1 kernel: [ 7627.132247]  [<ffffffffa01a24ec>]
ceph_write_begin+0x6c/0x100 [ceph]
Jun  4 22:19:03 hp1 kernel: [ 7627.132267]  [<ffffffff810f6652>]
generic_perform_write+0xc2/0x200
Jun  4 22:19:03 hp1 kernel: [ 7627.132277]  [<ffffffff810f67ea>]
generic_file_buffered_write+0x5a/0x90
Jun  4 22:19:03 hp1 kernel: [ 7627.132284]  [<ffffffff810f7dc9>]
__generic_file_aio_write+0x219/0x410
Jun  4 22:19:03 hp1 kernel: [ 7627.132293]  [<ffffffff810f802f>]
generic_file_aio_write+0x6f/0xf0
Jun  4 22:19:03 hp1 kernel: [ 7627.132306]  [<ffffffffa019cfbf>]
ceph_aio_write+0x2cf/0x580 [ceph]
Jun  4 22:19:03 hp1 kernel: [ 7627.132323]  [<ffffffff811533d8>]
do_sync_write+0xb8/0xf0
Jun  4 22:19:03 hp1 kernel: [ 7627.132330]  [<ffffffff81153bce>]
vfs_write+0xae/0x180
Jun  4 22:19:03 hp1 kernel: [ 7627.132337]  [<ffffffff81153ef7>]
sys_write+0x47/0x90
Jun  4 22:19:03 hp1 kernel: [ 7627.132344]  [<ffffffff815a5d12>]
system_call_fastpath+0x16/0x1b

Any takers?

Now, while we're interested in resolving this bug, we are currently
focusing on RADOS, RBD, and radosgw, and that means that the Ceph
Distributed File System is not getting as much of our time. It may
take a while for us to come back. If none of the developers see an
easy fix for this, we'll need to file it in the bug tracker and come
back to it in a few months.
