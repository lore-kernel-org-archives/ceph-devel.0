From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: upstream/firefly exporting the same snap 2 times results in different
 exports
Date: Wed, 22 Jul 2015 12:27:11 +0200
Message-ID: <55AF6FFF.5080104@suse.cz>
References: <55AE3B3A.2040902@profihost.ag> <1431119614.1353345.1437489164103.JavaMail.zimbra@redhat.com> <55AE798F.1010206@profihost.ag> <1828157940.1473499.1437499191528.JavaMail.zimbra@redhat.com> <55AE9BD9.6010801@profihost.ag> <55AEA17A.8040901@redhat.com> <55AEA306.6000809@profihost.ag> <55AEB0B1.6040500@redhat.com> <55AF405B.4050602@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35170 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933287AbbGVK1N (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Jul 2015 06:27:13 -0400
In-Reply-To: <55AF405B.4050602@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On 2015-07-22 09:03, Stefan Priebe - Profihost AG wrote:
> That would be really important. I've seen that this one was already in
> upstream/firefly-backports. What's the purpose of that branch?

That is where the Stable Releases and Backports team stages backports
and does integration testing on them before they are merged into the
'firefly' named branch.

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
