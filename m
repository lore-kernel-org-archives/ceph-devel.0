From: Sage Weil <sage@newdream.net>
Subject: Re: Changes to Rocksdb in tree
Date: Fri, 28 Oct 2016 10:46:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610281044550.10754@piezo.us.to>
References: <db531186-389a-fafe-c911-8e75a33da72a@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39369 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbcJ1KqL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2016 06:46:11 -0400
In-Reply-To: <db531186-389a-fafe-c911-8e75a33da72a@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 28 Oct 2016, Willem Jan Withagen wrote:
> Hi,
> 
> Now that we have an In-tree rocksdb:
> When I have changes to rocksdb how to I get them permanently into the
> Ceph tree?
> 
> I submitted the changes upstream to rocksdb.

Once they are merged upstream in rocksdb we will push the commit to 
github.com/ceph/rocksdb and update the submodule.  If you like, we can 
cherry-pick the patch in our tree too for the time being (in which case 
you can submit a PR to ceph/rocksdb too).

sage
