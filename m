From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Not starting a OSD journal
Date: Sun, 29 Jan 2017 17:21:42 +0100
Message-ID: <351131ca-d626-3bba-833b-c3281a5b25e1@suse.cz>
References: <30ca4a82-d51a-c190-6e4c-0ac329644d04@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbdA2QVv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 29 Jan 2017 11:21:51 -0500
In-Reply-To: <30ca4a82-d51a-c190-6e4c-0ac329644d04@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

> I'm rummaging thru the options, but I do not really see an option to
> fully disable journaling?
>
> One of the reasons for testing that is that ZFS already has very good
> journaling functionality. So I'd like to see what kind of performance
> difference that makes.
>
> Or is this like setting journal-size to 0 or the path to /dev/null?

All writes go through the journal, so it is required. However, the 
journal can be in a file within the OSD data partition. To deploy an OSD 
in this configuration, it should be sufficient to *not* supply the 
JOURNAL positional parameter to "ceph-disk prepare" [1].

By doing this, you of course lose the option of putting the journal on a 
separate (SSD) disk. If your data partition is on an HDD, journal-on-SSD 
is going to give superior performance.

[1] See "ceph-disk prepare --help" for a description of these arguments.

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
