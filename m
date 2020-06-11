From: Jeff Layton <jlayton@kernel.org>
Subject: Re: Questions of QoS on ceph
Date: Thu, 11 Jun 2020 12:24:58 -0400
Message-ID: <7ae2e9ec09cddaf1cb6420bfe6758becc7fb434b.camel@kernel.org>
References: <b8eca4d9-e368-0f35-f3dc-6049d9a213fd@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgFKQZA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:25:00 -0400
In-Reply-To: <b8eca4d9-e368-0f35-f3dc-6049d9a213fd@gmx.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: norman <norman.kern@gmx.com>, ceph-devel@vger.kernel.org
Cc: sage@redhat.com, ceph-users <ceph-users@ceph.io>

On Wed, 2020-06-10 at 16:38 +0800, norman wrote:
> Hi guys,
> 
> I want to setup a  ceph cluster for teams, using fs and s3 interface. I
> met a problem about the QoS: How can I limit the
> 
> bw or qps of a client to avoid the someone blocking others by running
> lots of threads?
> 

(this is probably a better question for ceph-users mailing list.
cc'ed...)

It's not clear to me which one concerns you most:

1/ parceling out a single client's resources between different tasks
(e.g. multiple programs interacting on a kcephfs mount).

2/ parceling out resources of the entire cluster between different
clients

...both turn out to be pretty thorny problems, and ceph doesn't really
have much in the way of mechanisms for addressing either.

The Ceph MDS can do things like recall caps to manage resources but I
don't believe it does that in response to (e.g.) excess activity vs. a
single OSD. It's more focused on its own memory consumption.

-- 
Jeff Layton <jlayton@kernel.org>
