From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH -v2] Generic libcephfs Java bindings
Date: Thu, 15 Mar 2012 14:49:25 -0700
Message-ID: <8FB333053FF344758B28D74716543012@dreamhost.com>
References: <575E1B43-986C-4165-AF8E-B6C256263498@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63945 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448Ab2COVt3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Mar 2012 17:49:29 -0400
Received: by yenl12 with SMTP id l12so3569681yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 14:49:29 -0700 (PDT)
In-Reply-To: <575E1B43-986C-4165-AF8E-B6C256263498@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>, Joe Buck <buck@soe.ucsc.edu>

On Wednesday, March 14, 2012 at 11:21 PM, Noah Watkins wrote:
> This is version 2 of the generic libcephfs Java bindings based on feedback from the original patch set (thanks!). The short-log at the bottom of the e-mail shows the commits made based on feedback, but the Git branch below has them all rebased into fewer patches for a clean history.
> 
> Thanks,
> - Noah
> 
> Consolidated patch set is available in the git repository at:
> 
> git://github.com/noahdesu/ceph (http://github.com/noahdesu/ceph) wip/java-cephfs
> 
> Noah Watkins (3):
> java: add Java and C++ source files
> automake: setup autotools to build cephfs-java
> debian: add libcephfs-java package
> 
> Sage Weil (2):
> do_autogen.sh (http://do_autogen.sh): add -j flag to enable java stuff
> Makefile: add src/include to #include path for libcephfs_jni_la
> 
> ============================================================
> Original change log based on feedback
> ============================================================
> 
> Noah Watkins (12):
> java: add Java and C++ source files
> java: setup autotools to build cephfs-java
> debian: add libcephfs-java package
> java: add MIT license
> java: document valid states in JavaDoc
> java: order methods according to libcephfs.h
> java: fix typo; update testing notes
> java: remove redundant mount() interface
> java: use protected getdnames(int bufSize)

But you left it public in CephMount?
 
> java: switch classpath to com.ceph.fs
> java: remove unused macro
> java: document CPP macro-foo

Looks like a couple of my line notes are still left. Am I just confused in my opinions? :(
There's no note that set_default_file_replication is a no-op in its documentation.
closedir does not explain what happens to the CephDirectory state under success and failure. Honestly I don't even know what you're supposed to do with it if it fails, and why the code resets it to PREPARING instead of a CLOSED state is unclear to me. :)

If possible for my reviewing sanity, it'd be nice if I could access the changes you've made to things instead of trying to figure out how to run diffs against changing filenames and stuff, too, but that's just a wish.
Thanks for your work!
-Greg

