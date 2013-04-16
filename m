From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: ceph and efficient access of distributed resources
Date: Tue, 16 Apr 2013 22:06:31 +0200
Message-ID: <CAJH6TXiaE-Srrs68JN=mGV2jWh_ofsHVC8zNWaG_BTaaeq0L8g@mail.gmail.com>
References: <loom.20130412T055215-88@post.gmane.org>
	<51683184.9010301@inktank.com>
	<CAJH6TXgurT4yUshaH4QOgUKOaB3DqQd1-=HPshp+eH5HB7p3Hg@mail.gmail.com>
	<516C7E55.1050801@inktank.com>
	<516C8168.40402@inktank.com>
	<CAJH6TXhRtWQ1ypEb5JOwzp9T3Nd7A=J_6Dn0M25vXjYMg8j7fQ@mail.gmail.com>
	<516D5DB3.4060800@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:50697 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935907Ab3DPUGd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 16:06:33 -0400
Received: by mail-wg0-f48.google.com with SMTP id f11so896578wgh.27
        for <ceph-devel@vger.kernel.org>; Tue, 16 Apr 2013 13:06:31 -0700 (PDT)
In-Reply-To: <516D5DB3.4060800@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@inktank.com>
Cc: Matthias Urlichs <matthias@urlichs.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2013/4/16 Mark Kampe <mark.kampe@inktank.com>:
> RADOS is the underlying storage cluster, but the access methods (block,
> object, and file) stripe their data across many RADOS objects, which
> CRUSH very effectively distributes across all of the servers.  A 100MB
> read or write turns into dozens of parallel operations to servers all
> over the cluster.

Let me try to explain.
AFAIK check will split datas into chunks of 4MB each, so, a single
12MB file will be stored in 3 different chunks across multiple OSDs
and then replicated many times (based on value of replica count)

Let's assume a 12MB file and a 3x replica.
RADOS will create 3x3 chuks for the same file stored on 9 OSDs

When reading AFAIK replicas are not used, so all reads are done to the
"master copy".
But these 3 chunks are read in parallel on multiple OSDs or all read
request are done trough a single OSD? In the first case we will have
3x bandwidth for read operations directed to a file with at least 3
chunks, in the latter we have a big bottleneck.
