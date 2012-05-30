From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: rbd command : is it possible to pass authkey in argument ?
Date: Wed, 30 May 2012 11:15:29 +0200 (CEST)
Message-ID: <0a37bcdb-3791-4255-b403-1ca147cf02c0@mailpro>
References: <1612d6e1-fed0-4cda-bfc4-df0006875f75@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:47717 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381Ab2E3JPu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 05:15:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 722D31805B5E1
	for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 11:15:34 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U5sYI-aA-l1l for <ceph-devel@vger.kernel.org>;
	Wed, 30 May 2012 11:15:29 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id 3E4EA1804090C
	for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 11:15:29 +0200 (CEST)
In-Reply-To: <1612d6e1-fed0-4cda-bfc4-df0006875f75@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm writing rbd module for proxmox kvm distribution,

Is it possible to pass authkey as argument in rbd command line ? (I can do in with qemu-rbd drive option)

Or does it need to use a keyring file ?

Regards,

Alexandre

