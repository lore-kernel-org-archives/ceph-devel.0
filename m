From: David Casier AEVOO <david.casier@aevoo.fr>
Subject: Re: [Teuthology] Upgrade hammer on ubuntu : all passed
Date: Tue, 21 Jul 2015 07:05:30 +0200
Message-ID: <55ADD31A.3020603@aevoo.fr>
References: <55ACD3DB.2050606@aevoo.fr> <55AD7505.2070907@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 62-210-192-203.rev.poneytelecom.eu ([62.210.192.203]:41934 "EHLO
	aevoo.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbbGUFGc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Jul 2015 01:06:32 -0400
In-Reply-To: <55AD7505.2070907@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org


On 07/21/2015 12:24 AM, Loic Dachary wrote:
> teuthology-suite --ceph hammer-backports --machine-type openstack --suite upgrade/hammer-x --filter ubuntu_14.04 $HOME/src/ceph-qa-suite_master/machine_types/vps.yaml $(pwd)/teuthology/test/integration/archive-on-error.yaml
Hi Loic,
Job started
http://ceph.aevoo.fr:8081/ubuntu-2015-07-21_05:02:44-upgrade:hammer-hammer---basic-openstack/

David
