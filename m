From: Sage Weil <sweil@redhat.com>
Subject: Re: reducing package size / compression time
Date: Sun, 13 Sep 2015 18:40:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509131839480.23022@cobra.newdream.net>
References: <55F5FAD2.10802@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53769 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbbINBkP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 13 Sep 2015 21:40:15 -0400
In-Reply-To: <55F5FAD2.10802@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 14 Sep 2015, Loic Dachary wrote:
> Hi Sage,
> 
> You did something to reduce the size (hence the compression time) of the 
> debug packages using 
> https://fedoraproject.org/wiki/Features/DwarfCompressor. Would you be so 
> kind as to remind me which commit does that ?

https://github.com/ceph/autobuild-ceph/commit/193864ec69edb4dbb0112bb3ea54e6d2f20b30dd

The suggestion came from Boris.

sage
