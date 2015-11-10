From: Sage Weil <sage@newdream.net>
Subject: Re: [CEPH][Crush][Tunables] issue when updating tunables
Date: Tue, 10 Nov 2015 02:23:21 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511100221010.32494@cobra.newdream.net>
References: <25091_1447144373_5641ABB5_25091_8387_1_B9C8EFBF13B1354DB5FA000660D66DD00D64A5FA@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52183 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbKJKXW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 05:23:22 -0500
In-Reply-To: <25091_1447144373_5641ABB5_25091_8387_1_B9C8EFBF13B1354DB5FA000660D66DD00D64A5FA@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 10 Nov 2015, ghislain.chevalier@orange.com wrote:
> Hi all,
> 
> Context:
> Firefly 0.80.9
> Ubuntu 14.04.1
> Almost a production platform  in an openstack environment
> 176 OSD (SAS and SSD), 2 crushmap-oriented storage classes , 8 servers in 2 rooms, 3 monitors on openstack controllers
> Usage: Rados Gateway for object service and RBD as back-end for Cinder and Glance
> 
> The Ceph cluster was installed by Mirantis procedures (puppet/fuel/ceph-deploy):
> 
> I noticed that tunables were curiously set.
> ceph  osd crush show-tunables ==>
> { "choose_local_tries": 0,
>   "choose_local_fallback_tries": 0,
>   "choose_total_tries": 50,
>   "chooseleaf_descend_once": 1,
>   "chooseleaf_vary_r": 1,
>   "straw_calc_version": 1,
>   "profile": "unknown",
>   "optimal_tunables": 0,
>   "legacy_tunables": 0,
>   "require_feature_tunables": 1,
>   "require_feature_tunables2": 1,
>   "require_feature_tunables3": 1,
>   "has_v2_rules": 0,
>   "has_v3_rules": 0}
> 
> I tried to update them
> ceph  osd crush tunables optimal ==>
> adjusted tunables profile to optimal
> 
> But when checking
> ceph  osd crush show-tunables ==>
> { "choose_local_tries": 0,
>   "choose_local_fallback_tries": 0,
>   "choose_total_tries": 50,
>   "chooseleaf_descend_once": 1,
>   "chooseleaf_vary_r": 1,
>   "straw_calc_version": 1,
>   "profile": "unknown",
>   "optimal_tunables": 0,
>   "legacy_tunables": 0,
>   "require_feature_tunables": 1,
>   "require_feature_tunables2": 1,
>   "require_feature_tunables3": 1,
>   "has_v2_rules": 0,
>   "has_v3_rules": 0}
> 
> Nothing has changed.
> 
> I finally did
> ceph osd crush set-tunable straw_calc_version 0

You actually want straw_calc_version 1.  This is just confusing output 
from the 'firefly' tunable detection... the straw_calc_version does not 
have any client dependencies.

sage


> 
> and
> ceph  osd crush show-tunables ==>
> { "choose_local_tries": 0,
>   "choose_local_fallback_tries": 0,
>   "choose_total_tries": 50,
>   "chooseleaf_descend_once": 1,
>   "chooseleaf_vary_r": 1,
>   "straw_calc_version": 0,
>   "profile": "firefly",
>   "optimal_tunables": 1,
>   "legacy_tunables": 0,
>   "require_feature_tunables": 1,
>   "require_feature_tunables2": 1,
>   "require_feature_tunables3": 1,
>   "has_v2_rules": 0,
>   "has_v3_rules": 0}
> 
> It's OK
> 
> My question:
> Does the "ceph osd crush tunables <profile>" command change all the requested parameters in order to set the tunables to the right profile?
> 
> Brgds
> 
> _________________________________________________________________________________________________________________________
> 
> Ce message et ses pieces jointes peuvent contenir des informations confidentielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les messages electroniques etant susceptibles d'alteration,
> France Telecom - Orange decline toute responsabilite si ce message a ete altere, deforme ou falsifie. Merci
> 
> This message and its attachments may contain confidential or privileged information that may be protected by law;
> they should not be distributed, used or copied without authorization.
> If you have received this email in error, please notify the sender and delete this message and its attachments.
> As emails may be altered, France Telecom - Orange shall not be liable if this message was modified, changed or falsified.
> Thank you.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
