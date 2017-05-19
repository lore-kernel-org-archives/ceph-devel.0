From: Tim Serong <tserong@suse.com>
Subject: subpackages for mgr modules
Date: Fri, 19 May 2017 16:19:07 +1000
Message-ID: <3c199f5d-a09a-f600-5c16-7e0c25495efc@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:35224 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755065AbdESGTV (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 19 May 2017 02:19:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

At some point, we're going to want to have (some of) mgr's python
modules shipped not as part of the ceph-mgr package, but as subpackages
that can be optionally installed (ceph-mgr-foo, ceph-mgr-bar, whatever).
 That's easy to do.  What I'm wondering about is having installation of
an mgr module subpackage automatically enable the loading of that module.

Ordinarily, to enable an mgr module that isn't enabled by default at
compile time, you'd set "mgr modules = foo bar" in the [mgr] section of
ceph.conf.  But that will get irritating.

We can't have mgr just load everything that exists (someone might want
to disable some modules, without necessarily uninstalling them).

A couple of approaches I thought of are:

1) Add a command line argument (or arguments) to ceph-mgr to list
modules to enable (or disable).  This could in turn be set by some
variable(s) in /etc/sysconfig/ceph.  Subpackages then tweak those
variables at install time.

2) Do something with symlinks; set up a directory structure something
like this:

/usr/lib64/ceph/mgr/enabled/
/usr/lib64/ceph/mgr/modules/
/usr/lib64/ceph/mgr/modules/fsstatus
/usr/lib64/ceph/mgr/modules/rest
/usr/lib64/ceph/mgr/modules/...

Then, any module you want to enable, create a symlink to it from the
"enabled" directory.  Subpackages could do this at install time.  mgr
iterates through that directory and loads anything present.

(Personally I rather prefer approach 2 to approach 1).

I'm sure there's other possibilities.  Thoughts, anyone?

Thanks,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
