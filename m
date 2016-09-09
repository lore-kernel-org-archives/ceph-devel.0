From: Matt Benjamin <mbenjamin@redhat.com>
Subject: rename PR
Date: Fri, 9 Sep 2016 10:16:30 -0400 (EDT)
Message-ID: <71460615.83653154.1473430590652.JavaMail.zimbra@redhat.com>
References: <580189648.83640635.1473430099895.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:49915 "EHLO
        mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbcIIOQb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Sep 2016 10:16:31 -0400
In-Reply-To: <580189648.83640635.1473430099895.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chen Min <chenmin@xsky.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi Chen,

I wanted to let you know, I merged your exact-match PR.  Now, I suspect that you're also not running a recent-enough version of nfs-ganesha, because I think that the rename issue you fixed wouldn't easily reproduce if you were.

A key point I wanted to highlight is that it's part of the scaling (and ha, and...) strategy that our nfs file handles are name-stable, rather than arbitrary values.  One implication of that is that when a file is renamed, the renamed object has a different file id and hence NFS file handle value than it did before the rename.  We use the parent directory's change attribute to ensure that clients that had the vnode cached see an invalidate.  (Nothing in your PR contradicts that, of course.)

Another strategic decision we made is, we don't rename directories (just stating it for posterity). :)

Cheers,

Matt

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
