From: Loic Dachary <loic@dachary.org>
Subject: ceph-workbench 1.5.15 released
Date: Fri, 10 Feb 2017 00:00:27 +0100
Message-ID: <01fcc394-8f9b-17eb-a169-0102ec0a3e17@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53949 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752837AbdBIXAc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2017 18:00:32 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Piotr,

Now that teuthology-openstack is fixed and uses the latest teuthology master branch [1], I took this opportunity to publish a new version of ceph-workbench[2]. It should work out of the box with an OVH tenant. You can run a teuthology suite with something like:

   ceph-workbench ceph-qa-suite --verbose --suite rados --ceph kraken

and collect the results from the teuthology cluster it creates, like with the basic example that ran today at http://158.69.82.163:8081/

Cheers

[1] https://github.com/ceph/teuthology/pull/1028
[2] http://ceph-workbench.readthedocs.io/en/latest/
-- 
Loïc Dachary, Artisan Logiciel Libre
