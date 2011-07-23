From: Sage Weil <sage@newdream.net>
Subject: Re: write operations
Date: Sat, 23 Jul 2011 14:38:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107231438210.15589@cobra.newdream.net>
References: <CAJMJAuM74+eod5PMKC_VowxwAMyutbKJr0oY8xX2ELFAybZk5w@mail.gmail.com>
 <Pine.LNX.4.64.1107230728180.30052@cobra.newdream.net>
 <loom.20110723T182256-13@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55848 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab1GWVfL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jul 2011 17:35:11 -0400
In-Reply-To: <loom.20110723T182256-13@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Sat, 23 Jul 2011, Fyodor Ustinov wrote:
> Sage Weil <sage <at> newdream.net> writes:
> 
> > 
> > Ceph (by default) stripes files over 4MB objects.  The default policy is 
> > configurable on a per-directory or per-file basis.
> Wow. Hot to?

See 'man cephfs'.  This should probably go in the wiki too.

sage
