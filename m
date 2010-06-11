From: Peter Niemayer <niemayer@isg.de>
Subject: Re: Using other filesystems than btrfs with Ceph
Date: Fri, 11 Jun 2010 18:47:08 +0200
Message-ID: <hutpad$p9t$1@dough.gmane.org>
References: <hutgsk$oh4$1@dough.gmane.org> <AANLkTin6wleXQVepvMACh8JMr5sa1g4neVXD_Voi7rYT@mail.gmail.com> <Pine.LNX.4.64.1006110938120.20973@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:54412 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756746Ab0FKQuH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Jun 2010 12:50:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ON7Qi-0001Yi-I9
	for ceph-devel@vger.kernel.org; Fri, 11 Jun 2010 18:50:04 +0200
Received: from barriere.frankfurter-softwarefabrik.de ([217.11.197.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jun 2010 18:50:04 +0200
Received: from niemayer by barriere.frankfurter-softwarefabrik.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jun 2010 18:50:04 +0200
In-Reply-To: <Pine.LNX.4.64.1006110938120.20973@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 06/11/2010 06:40 PM, Sage Weil wrote:
> The btrfs isn't required for consistency if the writeahead journal is
> enabled (which it is by default).  However, at the moment the code that
> controls trimming the journal assumes ext3 data=ordered fsync semantics
> (fsync flushes the entire journal and all prior writes).  This needs a
> little bit of work to do the right thing with ext4 and xfs.
>
> So: I would stick with btrfs or ext3 for now if you want recovery to work
> reliably!

The recovery you are referring to, here, is that an operation required...

a) after an outage that involved many/all redundant OSDs
b) after a physical failure of one underlying storage device
c) after every disconnect/reconnect of Ceph nodes

?

Regards,

Peter Niemayer

