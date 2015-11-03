From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Symbolic links like feature on radosgw
Date: Mon, 2 Nov 2015 23:51:20 -0700
Message-ID: <20151102235120.5ad4230c@lembas.zaitcev.lan>
References: <CAKtk8hcvWJmdYmY20ZQsUuE=ww+Q=pDv6=HRVJhZ6Hk01U3wSg@mail.gmail.com>
	<CAKtk8he19oYaEC9op5PFj6mRaA0jqQ5eFe2rRkj2JMV-E29AhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39535 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752145AbbKCGvW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 Nov 2015 01:51:22 -0500
In-Reply-To: <CAKtk8he19oYaEC9op5PFj6mRaA0jqQ5eFe2rRkj2JMV-E29AhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <guangyy@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yehuda Sadeh <yehuda@inktank.com>, zaitcev@redhat.com

On Mon, 2 Nov 2015 21:25:31 -0800
Guang Yang <guangyy@gmail.com> wrote:

> Is this a valid feature request we can put into radosgw? The way I am
> thinking to implement is like symbolic link, the link object just
> contains a pointer to the original object.

It's not going to be sufficient. What do you think the Content-Size
and Content-Type should be for the HEAD and GET on the symlink object?
What I'm getting to though, for symlink to be of any use, it must
return the linked object on GETs. Yet, it must be distinguishable
(return some kind of system metadata). Also, it must be possible to
discover that it is, in fact, a symlink. A query parameter perhaps.

-- Pete
