From: Gregory Farnum <greg@inktank.com>
Subject: Re: Replication at file/folder filen
Date: Mon, 21 May 2012 11:40:05 -0700
Message-ID: <CAPYLRzhid7pRn2dD1sEr2w=3pLGihANNuMs-ZN9f0BBBv8niOQ@mail.gmail.com>
References: <loom.20120521T192333-932@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52368 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab2EUSkH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 14:40:07 -0400
Received: by lbbgm6 with SMTP id gm6so3684257lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 11:40:05 -0700 (PDT)
In-Reply-To: <loom.20120521T192333-932@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, May 21, 2012 at 10:28 AM, Madhusudhana U
<madhusudhana.u.acharya@gmail.com> wrote:
> Hi all,
> I assume in CEPH, by default, replications are set for both data and metadata.
> Is it possible for setting replication for individual file/folders ? I find this
> very usefule. In most of the cases, we may need more protections for just few
> files/folders. Instead of setting replication level for entire data, it would be
> good to set for required files/folders. If not possible in current version,
> is it possible to add this in future? I would love to see this feature in CEPH.

Replication levels are set on the level of RADOS pools. By default,
those are "data" and "metadata" (for the filesystem).
However, you can create more pools which the MDS uses, and you can
specify that newly-created files (individually, or on the directory
subtree level) go into a different pool from the system default.
Check out the cephfs tool for more info on setting the pool.

There is not currently a way to move existing files into a new pool
(without doing a copy through the client, anyway), and nothing on the
roadmap to change that. If it would be helpful, let us know!
-Greg
