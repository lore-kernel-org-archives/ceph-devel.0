From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: RE: [ceph][radosgw] radosgw behind a reverse proxy
Date: Fri, 4 Mar 2016 06:52:16 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF022B51CF@SHSMSX104.ccr.corp.intel.com>
References: <13775_1457022979_56D86803_13775_1230_1_B9C8EFBF13B1354DB5FA000660D66DD00D6BE394@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19665 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbcCDGwW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2016 01:52:22 -0500
In-Reply-To: <13775_1457022979_56D86803_13775_1230_1_B9C8EFBF13B1354DB5FA000660D66DD00D6BE394@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ghislain.chevalier@orange.com" <ghislain.chevalier@orange.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

There's one option in rgw to customize the swift storage url:
https://github.com/ceph/ceph/blob/master/src/common/config_opts.h#L1202

Can you please try again with rgw_swift_url = http://cepstorage.orange-labs.fr:80

thanks, -yuan

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of ghislain.chevalier@orange.com
Sent: Friday, March 4, 2016 12:36 AM
To: ceph-devel@vger.kernel.org
Subject: [ceph][radosgw] radosgw behind a reverse proxy

Hi all,

Context: 
Ceph version : firefly 0.80.11
OS : ubuntu 12.04.5 LTS


I installed a rados gateway with civetweb listening on port 8081 This rados gateway is accessible from the internet cephstorage.orange-labs.fr:80 A reverse proxy forwards the  requests from cephstorage.orange-labs.fr:80 to the rgw server v-sbceph21:8081

It works well using the S3 API.

But when using the swift API, if I successfully get the token (cepstorage.orange-labs.fr/auth) , the url for getting the objects is malformed : cephstorage.orange-labs.fr:8081/swift...

Is there a solution to force the port to 80?

Best regards

_________________________________________________________________________________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confidentielles ou privilegiees et ne doivent donc pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu ce message par erreur, veuillez le signaler a l'expediteur et le detruire ainsi que les pieces jointes. Les messages electroniques etant susceptibles d'alteration, Orange decline toute responsabilite si ce message a ete altere, deforme ou falsifie. Merci.

This message and its attachments may contain confidential or privileged information that may be protected by law; they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and delete this message and its attachments.
As emails may be altered, Orange is not liable for messages that have been modified, changed or falsified.
Thank you.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
