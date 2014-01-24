From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: creation of the puppet-ceph repository
Date: Fri, 24 Jan 2014 14:57:36 +0100
Message-ID: <CAJH6TXjCRiomcpt=QoSrdCsn8KSKUwW4hf9MHQtfk5yv7n_CUw@mail.gmail.com>
References: <52AC97E2.8080907@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:49103 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbaAXN5i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jan 2014 08:57:38 -0500
Received: by mail-we0-f169.google.com with SMTP id u57so2725238wes.0
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jan 2014 05:57:37 -0800 (PST)
In-Reply-To: <52AC97E2.8080907@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

2013/12/14 Loic Dachary <loic@dachary.org>:
> Hi,
>
> Could someone with sufficient permission please create the puppet-ceph repository (empty, no README or .gitignore) at http://github.com/ceph/ ?
>
> A few weeks ago it was decided to host the development of the module on stackforge ( https://github.com/stackforge/puppet-ceph ) and also to establish a mirror under the ceph github namespace.

Any usage guide for these puppet recipes?
I would like to follow this:
https://github.com/ceph/puppet-ceph/blob/master/USECASES.md
"I want to operate a production cluster"

But it's not clear how to add OSD nodes and how to specify journal
disks and size.
For example, in my environment I have 12 spinning disks to be used
(with discovery, if possible) as OSD storage, 1 SSD to be used as
operating system (that obviously must not be formatted) and 2 OSD to
be used as journal with 1 partitions (15GB each) for each OSD.

Should I configure somethinghin the recipe ?
