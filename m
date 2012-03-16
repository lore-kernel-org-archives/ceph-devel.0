From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH -v2] Generic libcephfs Java bindings
Date: Fri, 16 Mar 2012 14:00:43 -0700
Message-ID: <95A70EC09B8441EE9D494FBDD8061B4E@dreamhost.com>
References: <575E1B43-986C-4165-AF8E-B6C256263498@cs.ucsc.edu>
 <8FB333053FF344758B28D74716543012@dreamhost.com>
 <38955F3F-701C-4B3D-BE3B-BC3319021B7B@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54561 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965109Ab2CPVAs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Mar 2012 17:00:48 -0400
Received: by yenl12 with SMTP id l12so4636906yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Mar 2012 14:00:47 -0700 (PDT)
In-Reply-To: <38955F3F-701C-4B3D-BE3B-BC3319021B7B@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Friday, March 16, 2012 at 11:58 AM, Noah Watkins wrote:
> > closedir does not explain what happens to the CephDirectory state under success and failure. Honestly I don't even know what you're supposed to do with it if it fails, and why the code resets it to PREPARING instead of a CLOSED state is unclear to me. :)
> 
> 
> The motivation for closedir:success->PREPARING is that technically the CephDirectory object could be re-opened (any clean-up associated with the underlying struct ceph_dir_result is complete after closedir). On failure it remains OPEN to prevent it from being re-opened. This is the same semantics used for CephMount (re-mount is allowed only after a shutdown).
Given the semantics we already have I think just putting them into a CLOSED (or FAULT) state and forcing people to create new objects is probably more sane and reasonable enough to do. But obviously don't bother if we do...
 
> After some thought, I think there is a pretty simple way to avoid this whole state-machine mess by enforcing state with the API and exceptions. For example, CephDirectory:open should not exist to avoid even asking the question 'can a CephDirectory be re-opened'. Valid states for CephDirectory can be enforced by throwing an exception in CephMount:opendir (preventing CephDirectory from being created), and some sane, documented semantics for a closed CephDirectory can be added, such as returning null from CephDirectory:getdnames.
> 
> A similar approach to that of the Java 6 IO API can be taken for files in Ceph by using a CephFile (ops over paths), CephFileInputStream, and CephFileOutputStream (for opened files).
> 
> I had originally not taken this path, instead valuing a close 1-1 mapping between Java and libcephfs, but now I'm reconsidering. Do you have any thoughts?
Hrm. I've been in the C++ world for a long time!
I guess probably following Java practices is the right answer for Java bindings though (and you seem to have started down that path already with CephDirectory). I wouldn't expect a real drop in functionality, and the increase in user clarity should be well worth the work?
 
> 
> > If possible for my reviewing sanity, it'd be nice if I could access the changes you've made to things instead of trying to figure out how to run diffs against changing filenames and stuff, too, but that's just a wish.
> 
> Sorry about this! I /really/ kicked myself after pushing that rebase for the same reason... :(

Heh, thanks. :)
-Greg


