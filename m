From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Virtualenv tests still nort running...
Date: Wed, 30 Mar 2016 22:39:25 +0200
Message-ID: <56FC397D.8020700@digiware.nl>
References: <56FA67A8.6050809@digiware.nl> <56FA74F4.5040905@dachary.org>
 <56FA9B5C.5060307@digiware.nl> <56FB9BA0.2060901@digiware.nl>
 <56FBA5FC.6040001@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:23430 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbcC3Ujh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Mar 2016 16:39:37 -0400
In-Reply-To: <56FBA5FC.6040001@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On 30-3-2016 12:10, Loic Dachary wrote:
> Hi Willem,
> 
> Would you mind proposing a pull request with that change ? It looks good to me.
> 

Loic,

It does run from make.

But just running it on the commandline, does not really deliver....

[/usr/srcs/Ceph/work/ceph/src] wjw@freetest.digiware.nl>
ceph-disk/run-tox.sh
ceph-disk/run-tox.sh: line 21: ceph-disk-virtualenv/bin/activate: No
such file or directory
ceph-disk/run-tox.sh: line 22: ceph-disk-virtualenv/tox.out: No such
file or directory
ceph-disk/run-tox.sh: line 24: ceph-disk-virtualenv/tox.out: No such
file or directory

But perhaps the testscripts are not intended to run separate on the
commandline?

--WjW

