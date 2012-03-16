From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH -v2] Generic libcephfs Java bindings
Date: Fri, 16 Mar 2012 11:58:38 -0700
Message-ID: <38955F3F-701C-4B3D-BE3B-BC3319021B7B@cs.ucsc.edu>
References: <575E1B43-986C-4165-AF8E-B6C256263498@cs.ucsc.edu> <8FB333053FF344758B28D74716543012@dreamhost.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:44254 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755685Ab2CPS6k convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Mar 2012 14:58:40 -0400
In-Reply-To: <8FB333053FF344758B28D74716543012@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>, Joe Buck <buck@soe.ucsc.edu>

Hey Greg,

On Mar 15, 2012, at 2:49 PM, Greg Farnum wrote:

>> java: use protected getdnames(int bufSize)
> 
> But you left it public in CephMount?

Fixed. The original call chain was CephDirectory->CephMount->CephProxy, which meant that CephDirectory and CephMount each had similar methods. It's unclear what benefit putting them into CephMount had since a CephDirectory object is always required. Anyway, I removed that redundancy to fix this.

>> java: document CPP macro-foo
> 
> Looks like a couple of my line notes are still left. Am I just confused in my opinions? :(

Nope, I screwed up the email-to-todos.

> There's no note that set_default_file_replication is a no-op in its documentation.

Fixed.

> closedir does not explain what happens to the CephDirectory state under success and failure. Honestly I don't even know what you're supposed to do with it if it fails, and why the code resets it to PREPARING instead of a CLOSED state is unclear to me. :)

The motivation for closedir:success->PREPARING is that technically the CephDirectory object could be re-opened (any clean-up associated with the underlying struct ceph_dir_result is complete after closedir). On failure it remains OPEN to prevent it from being re-opened. This is the same semantics used for CephMount (re-mount is allowed only after a shutdown).

After some thought, I think there is a pretty simple way to avoid this whole state-machine mess by enforcing state with the API and exceptions. For example, CephDirectory:open should not exist to avoid even asking the question 'can a CephDirectory be re-opened'. Valid states for CephDirectory can be enforced by throwing an exception in CephMount:opendir (preventing CephDirectory from being created), and some sane, documented semantics for a closed CephDirectory can be added, such as returning null from CephDirectory:getdnames.

A similar approach to that of the Java 6 IO API can be taken for files in Ceph by using a CephFile (ops over paths), CephFileInputStream, and CephFileOutputStream (for opened files).

I had originally not taken this path, instead valuing a close 1-1 mapping between Java and libcephfs, but now I'm reconsidering. Do you have any thoughts? 

> If possible for my reviewing sanity, it'd be nice if I could access the changes you've made to things instead of trying to figure out how to run diffs against changing filenames and stuff, too, but that's just a wish.

Sorry about this! I /really/ kicked myself after pushing that rebase for the same reason... :(

Thanks,
- Noah