From: Xing Lin <xinglin@cs.utah.edu>
Subject: Re: Test infrastructure: 2 or more servers?
Date: Tue, 15 Jan 2013 15:03:55 -0700
Message-ID: <50F5D24B.70308@cs.utah.edu>
References: <CAJH6TXhBucB2t-ZRmXf5bCZyNaTRJoSHZhoJ9hsW8mR7NxhWnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:36135 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632Ab3AOWEB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 17:04:01 -0500
In-Reply-To: <CAJH6TXhBucB2t-ZRmXf5bCZyNaTRJoSHZhoJ9hsW8mR7NxhWnA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

You can change the number replicas in runtime with the following command:

$ ceph osd pool set {poolname} size {num-replicas}

Xing

On 01/15/2013 03:00 PM, Gandalf Corvotempesta wrote:
> Is possible to change the number of replicas in realtime ?

