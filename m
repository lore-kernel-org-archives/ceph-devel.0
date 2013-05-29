From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Speed up 'rbd rm'
Date: Wed, 29 May 2013 12:21:07 -0700
Message-ID: <51A65523.10107@inktank.com>
References: <20130529055942.GA3977@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49014 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965961Ab3E2TWo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 May 2013 15:22:44 -0400
Received: by mail-pb0-f42.google.com with SMTP id uo1so9636174pbc.15
        for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 12:22:43 -0700 (PDT)
In-Reply-To: <20130529055942.GA3977@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

On 05/28/2013 10:59 PM, Chris Dunlop wrote:
> I see there's a new commit to speed up an 'rbd rm':
>
> http://tracker.ceph.com/projects/ceph/repository/revisions/40956410169709c32a282d9b872cb5f618a48926
>
> Is it safe to cherry-pick this commit on top of 0.56.6 (or, if not, v0.61.2) to speed up the remove?

You'll need 537386d906b8c0e395433461dcb03a82eb33f34f as well. It should
apply cleanly to 0.61.2, and probably 0.56.6 too.

