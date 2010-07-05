From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: Redundancy with Ceph
Date: Mon, 05 Jul 2010 10:04:21 +0200
Message-ID: <4C319205.8080600@chaschperli.ch>
References: <201007042234.46732.cray@unix-ag.uni-kl.de> <201007050033.50739.cray@unix-ag.uni-kl.de> <i0rpno$ao1$1@dough.gmane.org> <201007050955.30279.cray@unix-ag.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trillian.muellerit.ch ([83.169.22.129]:38146 "EHLO
	trillian.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769Ab0GEIE2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jul 2010 04:04:28 -0400
In-Reply-To: <201007050955.30279.cray@unix-ag.uni-kl.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Baun <cray@unix-ag.uni-kl.de>
Cc: ceph-devel@vger.kernel.org

On 05.07.2010 09:55, Christian Baun wrote:
> Hi Thomas,
>
> Thanks a lot for the link and your help!
> Now, the issue are clear.
>
> The output of "ceph osd dump -o -" said that there shall be replication because max_osd is 3 and the size of all pools is 2. But osd2 was "out down".
> The reason: I forgot to start the ceph server at osd2.


you can also use the --allhosts with /etc/init.d/ceph

example:

/etc/init.d/ceph --allhosts start

this starts ceph on all configured hosts with ssh.

- Thomas
