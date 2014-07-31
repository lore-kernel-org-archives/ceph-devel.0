From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: KeyFileStore ?
Date: Thu, 31 Jul 2014 09:56:32 -0400 (EDT)
Message-ID: <1866818785.20.1406814992606.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <alpine.DEB.2.00.1407302156410.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:4189 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbaGaN4k (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 Jul 2014 09:56:40 -0400
In-Reply-To: <alpine.DEB.2.00.1407302156410.18917@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

+1 
----- "Sage Weil" <sweil@redhat.com> wrote:

> 
> Anyway, at the end of the day, small writes or overwrites would still
> be 
> journaled, but large writes or large new objects would not, which
> would (I 
> think) be a pretty big improvement.

Yes.

  Overall, I think the design will
> be 
> much simpler to reason about, and there are several potential avenues
> to 
> be clever and make improvements.  I'm not sure we can say the same
> about 
> the FileStore design, which suffers from the fact that it has evolved
> 
> slowly over the last 9 years or so.
> 

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
