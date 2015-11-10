From: <ghislain.chevalier@orange.com>
Subject: [CEPH][Crush][Tunables] issue when updating tunables
Date: Tue, 10 Nov 2015 08:32:52 +0000
Message-ID: <25091_1447144373_5641ABB5_25091_8387_1_B9C8EFBF13B1354DB5FA000660D66DD00D64A5FA@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-nor34.orange.com ([80.12.70.34]:44626 "EHLO
	relais-inet.orange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbbKJIlO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 03:41:14 -0500
Received: from opfednr02.francetelecom.fr (unknown [xx.xx.xx.66])
	by opfednr20.francetelecom.fr (ESMTP service) with ESMTP id 3BFA440379
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 09:32:53 +0100 (CET)
Received: from Exchangemail-eme2.itn.ftgroup (unknown [xx.xx.31.24])
	by opfednr02.francetelecom.fr (ESMTP service) with ESMTP id 1A3CA120070
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 09:32:53 +0100 (CET)
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

Context:
Firefly 0.80.9
Ubuntu 14.04.1
Almost a production platform  in an openstack environment
176 OSD (SAS and SSD), 2 crushmap-oriented storage classes , 8 servers in 2 rooms, 3 monitors on openstack controllers
Usage: Rados Gateway for object service and RBD as back-end for Cinder and Glance

The Ceph cluster was installed by Mirantis procedures (puppet/fuel/ceph-deploy):

I noticed that tunables were curiously set.
ceph  osd crush show-tunables ==>
{ "choose_local_tries": 0,
  "choose_local_fallback_tries": 0,
  "choose_total_tries": 50,
  "chooseleaf_descend_once": 1,
  "chooseleaf_vary_r": 1,
  "straw_calc_version": 1,
  "profile": "unknown",
  "optimal_tunables": 0,
  "legacy_tunables": 0,
  "require_feature_tunables": 1,
  "require_feature_tunables2": 1,
  "require_feature_tunables3": 1,
  "has_v2_rules": 0,
  "has_v3_rules": 0}

I tried to update them
ceph  osd crush tunables optimal ==>
adjusted tunables profile to optimal

But when checking
ceph  osd crush show-tunables ==>
{ "choose_local_tries": 0,
  "choose_local_fallback_tries": 0,
  "choose_total_tries": 50,
  "chooseleaf_descend_once": 1,
  "chooseleaf_vary_r": 1,
  "straw_calc_version": 1,
  "profile": "unknown",
  "optimal_tunables": 0,
  "legacy_tunables": 0,
  "require_feature_tunables": 1,
  "require_feature_tunables2": 1,
  "require_feature_tunables3": 1,
  "has_v2_rules": 0,
  "has_v3_rules": 0}

Nothing has changed.

I finally did
ceph osd crush set-tunable straw_calc_version 0

and
ceph  osd crush show-tunables ==>
{ "choose_local_tries": 0,
  "choose_local_fallback_tries": 0,
  "choose_total_tries": 50,
  "chooseleaf_descend_once": 1,
  "chooseleaf_vary_r": 1,
  "straw_calc_version": 0,
  "profile": "firefly",
  "optimal_tunables": 1,
  "legacy_tunables": 0,
  "require_feature_tunables": 1,
  "require_feature_tunables2": 1,
  "require_feature_tunables3": 1,
  "has_v2_rules": 0,
  "has_v3_rules": 0}

It's OK

My question:
Does the "ceph osd crush tunables <profile>" command change all the requested parameters in order to set the tunables to the right profile?

Brgds

_________________________________________________________________________________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confidentielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages electroniques etant susceptibles d'alteration,
France Telecom - Orange decline toute responsabilite si ce message a ete altere, deforme ou falsifie. Merci

This message and its attachments may contain confidential or privileged information that may be protected by law;
they should not be distributed, used or copied without authorization.
If you have received this email in error, please notify the sender and delete this message and its attachments.
As emails may be altered, France Telecom - Orange shall not be liable if this message was modified, changed or falsified.
Thank you.

