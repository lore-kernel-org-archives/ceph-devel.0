From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Ideas on NSS vs fork?
Date: Fri, 29 Apr 2011 09:14:24 -0700
Message-ID: <20110429161424.GA30051@dreamer>
References: <20110428212902.GA3932@dreamer>
 <BANLkTimF1sLvLuw3tztW8Ee6eLV6vP1-8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44670 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab1D2QOY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2011 12:14:24 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimF1sLvLuw3tztW8Ee6eLV6vP1-8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Apr 28, 2011 at 11:02:57PM -0700, Colin Patrick McCabe wrote:
> The question we need to answer is really whether forking somehow
> destroys the state of the parent process, even if the child thread
> never runs any libNSS code. If the answer is no, which is very likely,
> then essentially our situation is unchanged.

For NSS, only the pid that ran ceph::crypto::init() has a working
crypto library.

1. If you init before forking, any forked processes will have their
   NSS return errors, with no way to fix that. The parent keeps
   working.

2. If you init after forking, the parent never even tries to init crypto,
   the child does and gets a perfectly working crypto library.

2b. As an extension of above, the parent *could* init crypto after it
    has already forked off the child. We just have no need for that.


None of these make it possible for the child to wreck the NSS state in
the parent.

(The Ceph daemons before commit c9825f08 follow #1, that commits makes
them follow #2.)

-- 
:(){ :|:&};:
