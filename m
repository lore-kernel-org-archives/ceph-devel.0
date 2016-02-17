From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] add CephFS support in VirtFS
Date: Wed, 17 Feb 2016 09:37:16 +0000
Message-ID: <20160217093716.GC30300@redhat.com>
References: <56C00B60.6000502@gmail.com>
 <20160215091727.GB3105@redhat.com>
 <56C421F6.1000102@gmail.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43378 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757003AbcBQJhV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Feb 2016 04:37:21 -0500
Content-Disposition: inline
In-Reply-To: <56C421F6.1000102@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, qemu-devel@nongnu.org, haomaiwang@gmail.com, mst@redhat.com, aneesh.kumar@linux.vnet.ibm.com, Sage Weil <sage@newdream.net>, gfarnum@redhat.com, gkurz@linux.vnet.ibm.com

On Wed, Feb 17, 2016 at 03:32:06PM +0800, Jevon Qiao wrote:
> Hi Daniel,
> 
> Thank you for reviewing my code, please see my reply in-line.
> On 15/2/16 17:17, Daniel P. Berrange wrote:
> >On Sun, Feb 14, 2016 at 01:06:40PM +0800, Jevon Qiao wrote:
> >>+
> >>+static int cephfs_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
> >>+{
> >>+    const char *sec_model = qemu_opt_get(opts, "security_model");
> >>+    const char *path = qemu_opt_get(opts, "path");
> >>+
> >>+    if (!sec_model) {
> >>+        fprintf(stderr, "Invalid argument security_model specified with "
> >>+        "cephfs fsdriver\n");
> >Bad indent.
> BTW, is there any tool I can use to check the coding style in Qemu?

As already mentioned there is 'scripts/checkpatch.pl'. If you are just
wanting to check a single patch before sending it you can run it
manually eg

   git show | ./scripts/checkpatch.pl -

If you have a branch holding a whole series of patches to submit, then
it is easier to automate it. eg

 git rebase -i master -x 'git show | ./scripts/checkpatch.pl -'


NB, the script doesn't catch all style problems, but it does a pretty
good job. So even if the script passes, don't be suprised if reviewers
point out further style issues.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
