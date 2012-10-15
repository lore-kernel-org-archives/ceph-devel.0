From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: rbd command to display free space in a cluster ?
Date: Mon, 15 Oct 2012 09:52:44 +0200 (CEST)
Message-ID: <ec165b12-5d49-49d0-b5c9-cdb51bc2b442@mailpro>
References: <38420316-19c7-4ec8-bb69-fbe9b3a67d18@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:38010 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab2JOIAW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Oct 2012 04:00:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id D962718024BFF
	for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 09:52:49 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kYHrrLt5r65z for <ceph-devel@vger.kernel.org>;
	Mon, 15 Oct 2012 09:52:44 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id A38BC18024921
	for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 09:52:44 +0200 (CEST)
In-Reply-To: <38420316-19c7-4ec8-bb69-fbe9b3a67d18@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm looking for a way to retrieve the free space from a rbd cluster with rbd command.

Any hint ?

(something like ceph -w status, but without need to parse the result)

Regards,

Alexandre
