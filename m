From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 16:18:44 +0200
Message-ID: <4FC4DAC4.9000307@profihost.ag>
References: <aa40ea07-d700-4d9f-8ee3-9e514585b127@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35394 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab2E2OSo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 10:18:44 -0400
In-Reply-To: <aa40ea07-d700-4d9f-8ee3-9e514585b127@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Am 29.05.2012 15:01, schrieb Alexandre DERUMIER:
> fio benchmark will give you raw device performance bypassing filesystem.
> 
> So maybe the problem is in xfs or linux vfs layer.
> 
> I think you need to bench the filesystem to compare performance
here another test with bonnie, which shows the same:
http://pastebin.com/raw.php?i=fGTt4NLi

Stefan
