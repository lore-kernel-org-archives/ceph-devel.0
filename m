From: Nathan Cutler <ncutler@suse.de>
Subject: Re: jewel -> kraken upgrade
Date: Wed, 29 Jun 2016 07:45:13 +0200
Message-ID: <36904b0e-ec18-82a8-d0fc-1ede17351693@suse.de>
References: <075b96eb-bee1-8618-74a3-a10da327fef2@suse.de>
 <alpine.DEB.2.11.1606281343110.8816@piezo.us.to>
 <31000f1d-0158-9112-c753-423d29758077@suse.de>
 <alpine.DEB.2.11.1606281545010.18172@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52833 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbcF2FpR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jun 2016 01:45:17 -0400
In-Reply-To: <alpine.DEB.2.11.1606281545010.18172@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Done

Thanks! master is now good

$ git describe ceph/master
v11.0.0-46-g4c26fae

and master will be merged into kraken soon, right? Because:

$ git describe ceph/kraken
v10.2.0-1165-g7117842

Nathan
