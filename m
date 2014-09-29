From: Wido den Hollander <wido@42on.com>
Subject: Re: C++11
Date: Mon, 29 Sep 2014 19:56:41 +0200
Message-ID: <54299D59.4040604@42on.com>
References: <1410796508-28711-1-git-send-email-j@jannau.net> <1411994072-18850-1-git-send-email-j@jannau.net> <CANP1eJGxY8wR4smOfZ49+1dwjWCU7FrdbOG4UvMJR7UP77UX4g@mail.gmail.com> <alpine.DEB.2.00.1409290821220.14393@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:52183 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168AbaI2SFJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 29 Sep 2014 14:05:09 -0400
In-Reply-To: <alpine.DEB.2.00.1409290821220.14393@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Milosz Tanski <milosz@adfin.com>
Cc: Janne Grunau <j@jannau.net>, ceph-devel <ceph-devel@vger.kernel.org>

On 29-09-14 17:24, Sage Weil wrote:
> On Mon, 29 Sep 2014, Milosz Tanski wrote:
>> A second more general Ceph question is somewhat off-topic. What about
>> C++11 use in the Ceph code base (like in this case)? It's not
>> explicitly prohibited by the coding style document, but I imagine the
>> goal is to build on as many systems as possible and quite a few
>> supported distros have pretty old versions of GCC. I'm asking this
>> because I imagine some of the performance work that's about to happen
>> will want to use things like lockless queues, and then you get into
>> C++11 memory model and std::atomic... etc.
> 
> We are all very eager to move to C++11.  The challenge is that we still 
> need to build packages for the target distros.  That doesn't necessarily 
> mean that the compilers on those distros need to support c++11 as long as 
> the runtime does... if we can make the build enviroment sane.
> 
> I'm really curious what other projects do here...
> 

At the CloudStack project we recently switched from Java 6 to Java 7 and
we said that from version X we required Java 7 on the system.

For Ceph, what keeps us from saying that version H (after Giant)
requires a C++11 compliant compiler?

That might rule out Ubuntu 12.04 and CentOS6/RHEL6, but does that really
matter that much for something 'new' like Ceph?

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
